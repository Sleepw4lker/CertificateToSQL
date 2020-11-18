# CertificateToSQL

A little Hobby Project of mine. Throw an X509Certificate Object at the Import-Certificate.ps1 and it gets uploaded into an SQL Server, atomarizing (hopefully all) interesting data.

DDL can be found in the "queries" folder.

I use the [SimplySQL Module](https://github.com/mithrandyr/SimplySql) with a MariaDB Backend. Porting to other Database Servers should be super easy due to the excellent implementation in SimplySQL.

## Examples:

### Importing from the File System

Certificate Files can be converted to an X509Certificate Object with the Open-Certificate.ps1.

```powershell
Get-ChildItem -Path .\*.cer |
    .\Open-Certificate.ps1 | 
        .\Import-Certificate.ps1 -ComputerName '<mydbserver>' -Credential (Get-Credential)
```

### Importing from the ADCS CA Database

It can also be combined with an ADCS CA Database Query like [this one](https://github.com/Sleepw4lker/CaDatabaseQuery) or from the awesome [PSPKI Module](https://github.com/PKISolutions/PSPKI).

```powershell
Get-AdcsDatabaseRow -CertificationAuthority '<caName>' -Property RawCertificate | 
    .\Open-Certificate.ps1 | 
        .\Import-Certificate.ps1 -ComputerName '<mydbserver>' -Credential (Get-Credential)
```