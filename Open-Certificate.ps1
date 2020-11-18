[CmdletBinding()]
param(
    [Parameter(  
        Position = 0,   
        Mandatory = $True,   
        ValueFromPipeline = $True,  
        ValueFromPipelineByPropertyName = $True  
    )]
    [Object]
    $Object
)

process {

    $CertificateObject = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2

    If ($Object -is [System.IO.FileInfo]) {

        Try {
            $CertificateObject.Import($Object.FullName)
            $CertificateObject
        }
        Catch {
            Write-Warning -Message "Could not import given File $($Object.Name) as a Certificate Object."
        }
    }

    If ($Object -is [PSCustomObject]) {

        Try {
            $CertificateObject.Import([Convert]::FromBase64String($Object.RawCertificate))
            $CertificateObject
        }
        Catch {
            Write-Warning -Message "Could not import given Object as a Certificate Object."
        }
    }
}