
[CmdletBinding()]
param(
    [Parameter(  
        Position = 0,   
        Mandatory = $True,   
        ValueFromPipeline = $True,  
        ValueFromPipelineByPropertyName = $True  
    )]
    [X509Certificate]
    $Certificate,

    [Parameter(Mandatory=$True)]
    [String]
    $ComputerName,

    [Parameter(Mandatory=$False)]
    [String]
    $Database = 'pscertdb',

    [Parameter(Mandatory=$True)]
    [PSCredential]
    $Credential
)

begin {

    # https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509nametype?view=net-5.0
    New-Variable -Option Constant -Name X509NameType_SimpleName -Value 0

    New-Variable -Option Constant -Name XCN_CRYPT_STRING_BASE64 -Value 1
    New-Variable -Option Constant -Name XCN_CRYPT_STRING_HEXRAW -Value 12
    
    New-Variable -Option Constant -Name szOID_ENROLL_CERTTYPE_EXTENSION -Value "1.3.6.1.4.1.311.20.2"
    New-Variable -Option Constant -Name szOID_CERTIFICATE_TEMPLATE -Value "1.3.6.1.4.1.311.21.7"
    New-Variable -Option Constant -Name XCN_OID_CERT_POLICIES -Value "2.5.29.32"
    New-Variable -Option Constant -Name XCN_OID_KEY_USAGE -Value "2.5.29.15"
    New-Variable -Option Constant -Name XCN_OID_ENHANCED_KEY_USAGE "2.5.29.37"
    New-Variable -Option Constant -Name XCN_OID_SUBJECT_ALT_NAME2 -Value "2.5.29.17"
    New-Variable -Option Constant -Name XCN_OID_SUBJECT_KEY_IDENTIFIER -Value "2.5.29.14"
    New-Variable -Option Constant -Name XCN_OID_AUTHORITY_KEY_IDENTIFIER2 -Value "2.5.29.35"

    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_OTHER_NAME -Value 1
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_RFC822_NAME -Value 2
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_DNS_NAME -Value 3
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_X400_ADDRESS -Value 4
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_DIRECTORY_NAME -Value 5
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_EDI_PARTY_NAME -Value 6
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_URL -Value 7
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_IP_ADDRESS -Value 8
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_REGISTERED_ID -Value 9
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_GUID -Value 10
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME -Value 11
    New-Variable -Option Constant -Name XCN_CERT_ALT_NAME_UNKNOWN -Value 12

    Import-Module SimplySql

    Open-MySqlConnection `
        -Server $ComputerName `
        -Database $Database `
        -Credential $Credential

    # Load the SQL Queries for the Job
    $InsertCertificates         = Get-Content -Path ".\queries\Insert-Certificates.sql"
    $InsertCertificatePolicies  = Get-Content -Path ".\queries\Insert-CertificatePolicies.sql"
    $InsertIdentities           = Get-Content -Path ".\queries\Insert-Identities.sql"
    $InsertEnhancedKeyUsages    = Get-Content -Path ".\queries\Insert-EnhancedKeyUsages.sql"
}

process {

    # Extract basic Certificate Data
    $CertData = @{
        SubjectCN           = $Certificate.GetNameInfo($X509NameType_SimpleName,[Int]$False) # For the Case when there is no Key Match possible
        IssuerCN            = $Certificate.GetNameInfo($X509NameType_SimpleName,[Int]$True) # For the Case when there is no Key Match possible
        SerialNumber        = $Certificate.SerialNumber
        NotBefore           = $Certificate.NotBefore
        NotAfter            = $Certificate.NotAfter
        KeyAlgorithm        = $Certificate.PublicKey.EncodedKeyValue.Oid.FriendlyName
        KeyLength           = $Certificate.PublicKey.Key.KeySize
        thumbprint          = $Certificate.Thumbprint
        isCA                = [Int]($Certificate.Extensions.CertificateAuthority)
        SignatureAlgorithm  = $Certificate.SignatureAlgorithm.FriendlyName
    }

    # Extract Subject Data, if any
    $Certificate.Subject.Split(',') | ForEach-Object -Process {

        $RDNs = $_.Split('=')

        If (($null -ne $RDNs[0]) -and ($null -ne $RDNs[1])) {
            $SubjectData = @{
                Name = $RDNs[0].Trim()
                Value = $RDNs[1]
                Thumbprint = $Certificate.Thumbprint
            }
        }

        [void](Invoke-SqlUpdate -Query $InsertIdentities -Parameters $SubjectData)
    }

    # Process Certificate Extensions, if any
    ForEach ($Extension in $Certificate.Extensions) {

        Switch ($Extension.Oid.Value) {

            $szOID_ENROLL_CERTTYPE_EXTENSION {

                # Version 1 Certificate Template Name
                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensiontemplatename

                $TemplateObject = New-Object -ComObject X509Enrollment.CX509ExtensionTemplateName
                     
                $TemplateObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $CertData.Add("CertificateTemplate",$TemplateObject.TemplateName)

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($TemplateObject))


            } # szOID_ENROLL_CERTTYPE_EXTENSION

            $szOID_CERTIFICATE_TEMPLATE {

                # Version 2 Certificate Template Information
                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensiontemplate

                $TemplateObject = New-Object -ComObject X509Enrollment.CX509ExtensionTemplate
                     
                $TemplateObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $CertData.Add("CertificateTemplate", $TemplateObject.TemplateOid.Value)
                $CertData.Add("CertificateTemplateMajorVersion", $TemplateObject.MajorVersion)
                $CertData.Add("CertificateTemplateMinorVersion", $TemplateObject.MinorVersion)

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($TemplateObject))

            } # szOID_CERTIFICATE_TEMPLATE

            $XCN_OID_CERT_POLICIES {

                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensioncertificatepolicies

                $PoliciesObject = New-Object -ComObject X509Enrollment.CX509ExtensionCertificatePolicies
                     
                $PoliciesObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $PoliciesObject.Policies | ForEach-Object -Process {

                    <#
                    $_.PolicyQualifiers 
                    https://docs.microsoft.com/en-us/windows/win32/api/certenroll/ne-certenroll-policyqualifiertype
                    #>

                    If ($_.ObjectId.Value) {
                    
                        $PolicyData = @{
                            Oid = $_.ObjectId.Value
                            Thumbprint = $Certificate.Thumbprint
                        }

                        [void](Invoke-SqlUpdate -Query $InsertCertificatePolicies -Parameters $PolicyData)

                    }
                }

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($PoliciesObject))

            } # XCN_OID_CERT_POLICIES
        
            $XCN_OID_SUBJECT_KEY_IDENTIFIER {

                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensionsubjectkeyidentifier

                $SkiObject = New-Object -ComObject X509Enrollment.CX509ExtensionSubjectKeyIdentifier

                $SkiObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $CertData.Add("ski", $SkiObject.SubjectKeyIdentifier($XCN_CRYPT_STRING_HEXRAW).ToUpper())

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($SkiObject))

            } # XCN_OID_SUBJECT_KEY_IDENTIFIER
        
            $XCN_OID_AUTHORITY_KEY_IDENTIFIER2 {

                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensionauthoritykeyidentifier

                $AkiObject = New-Object -ComObject X509Enrollment.CX509ExtensionAuthorityKeyIdentifier

                $AkiObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $CertData.Add("aki", $AkiObject.AuthorityKeyIdentifier($XCN_CRYPT_STRING_HEXRAW).ToUpper())

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($AkiObject))

            } #XCN_OID_AUTHORITY_KEY_IDENTIFIER2

            $XCN_OID_KEY_USAGE {

                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensionkeyusage

                $KeyUsageObject = New-Object -ComObject X509Enrollment.CX509ExtensionKeyUsage

                $KeyUsageObject.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    )

                $CertData.Add("KeyUsage", $KeyUsageObject.KeyUsage)

                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($KeyUsageObject))

            } # XCN_OID_KEY_USAGE

            $XCN_OID_ENHANCED_KEY_USAGE {

                $Extension.EnhancedKeyUsages.Value | ForEach-Object -Process {

                    $EkuData = @{
                        Oid = $_
                        Thumbprint = $Certificate.Thumbprint
                    }

                    [void](Invoke-SqlUpdate -Query $InsertEnhancedKeyUsages -Parameters $EkuData)
                }
            } # XCN_OID_ENHANCED_KEY_USAGE

            $XCN_OID_SUBJECT_ALT_NAME2 {

                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/nf-certenroll-ix509extensionalternativenames-initializedecode
                # https://docs.microsoft.com/en-us/windows/win32/api/certenroll/ne-certenroll-encodingtype
                $SanObjects = New-Object -ComObject X509Enrollment.CX509ExtensionAlternativeNames
                     
                $SanObjects.InitializeDecode(
                    $XCN_CRYPT_STRING_BASE64,
                    [System.Convert]::ToBase64String($Extension.RawData)
                    ) 

                Foreach ($SanObject in $SanObjects.AlternativeNames) {

                    switch ($SanObject.Type) {

                        $XCN_CERT_ALT_NAME_DNS_NAME {

                            $SubjectData = @{
                                Name = "DNS"
                                Value = $SanObject.strValue
                                Thumbprint = $Certificate.Thumbprint
                            }
                        }

                        $XCN_CERT_ALT_NAME_IP_ADDRESS {

                            $SubjectData = @{
                                Name = "IP"
                                Value = ([IPAddress] ([Convert]::FromBase64String($SanObject.RawData($XCN_CRYPT_STRING_BASE64))))
                                Thumbprint = $Certificate.Thumbprint
                            }
                        }
                        
                        $XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME {

                            $SubjectData = @{
                                Name = "UPN"
                                Value = $SanObject.strValue
                                Thumbprint = $Certificate.Thumbprint
                            }
                        }

                        default {

                            <#
                            To Do: implement more SAN Types...

                            SubjectAltName ::= GeneralNames

                            GeneralNames ::= SEQUENCE SIZE (1..MAX) OF GeneralName

                            GeneralName ::= CHOICE {
                                    otherName                       [0]     OtherName,
                                    rfc822Name                      [1]     IA5String,
                                    dNSName                         [2]     IA5String,
                                    x400Address                     [3]     ORAddress,
                                    directoryName                   [4]     Name,
                                    ediPartyName                    [5]     EDIPartyName,
                                    uniformResourceIdentifier       [6]     IA5String,
                                    iPAddress                       [7]     OCTET STRING,
                                    registeredID                    [8]     OBJECT IDENTIFIER }

                            OtherName ::= SEQUENCE {
                                    type-id    OBJECT IDENTIFIER,
                                    value      [0] EXPLICIT ANY DEFINED BY type-id }

                            EDIPartyName ::= SEQUENCE {
                                    nameAssigner            [0]     DirectoryString OPTIONAL,
                                    partyName               [1]     DirectoryString }
                            #>

                            Write-Warning -Message "The Subject Alternative Name Type $($SanObject.Type) in Certificate $($Certificate.Thumbprint) is not yet implemented!"
                        }
                    }

                    [void](Invoke-SqlUpdate -Query $InsertIdentities -Parameters $SubjectData)
                }
                
                [void]([System.Runtime.Interopservices.Marshal]::ReleaseComObject($SanObjects))
                
            } # XCN_OID_SUBJECT_ALT_NAME2
        }
    }

    [void](Invoke-SqlUpdate -Query $InsertCertificates -Parameters $CertData)

}

end {
    Close-SqlConnection
}