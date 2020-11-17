[Cmdletbinding()]
param(
    [Parameter(Mandatory=$False)]
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

    Import-Module ActiveDirectory

    $ForestDn = $(Get-ADForest | Select-Object -ExpandProperty RootDomain | Get-ADDomain).DistinguishedName
    $PkiDn = "CN=Public Key Services,CN=Services,CN=Configuration,$ForestDn"

    Import-Module SimplySql

    Open-MySqlConnection `
        -Server $ComputerName `
        -Database $Database `
        -Credential $Credential

    # Load the SQL Queries for the Job
    $InsertCertificateTemplates = Get-Content -Path ".\queries\Insert-CertificateTemplates.sql"
}

process {

    Get-ChildItem -Path "AD:CN=Certificate Templates,$PkiDn" | ForEach-Object -Process {

        $Template = Get-ADObject $_ -Properties "msPKI-Cert-Template-OID",name,displayName

        $TemplateData = @{
            Oid = $Template."msPKI-Cert-Template-OID"
            Name = $Template.name
            DisplayName = $Template.displayName
            ForestDN = $ForestDn
        }
    
        [void](Invoke-SqlUpdate -Query $InsertCertificateTemplates -Parameters $TemplateData)

    }

}

end {
    Close-SqlConnection
}