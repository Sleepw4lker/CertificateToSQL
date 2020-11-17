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
            Write-Warning -Message "Could not import given Object $($Object.Name) as a Certificate Object."
        }
    }

    If ($Object -is [System.String]) {

        Try {
            $CertificateObject.Import([Convert]::FromBase64String($Object))
            $CertificateObject
        }
        Catch {
            Write-Warning -Message "Could not import given String as a Certificate Object."
        }
    }
}