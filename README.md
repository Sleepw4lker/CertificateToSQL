# CertificateToSQL

A little Hoppy Project of mine. Throw an X509Certificate Object at the Upload-Certificate.ps1 and it gets uploaded into an SQL Server, atomarizing (hopefully all) interesting data.

DDL can be found in the "queries" folder.

I use the SimplySQL Module with a MySQL Backend. Porting to other Database Servers should be super easy due to the excellent implementation in SimplySQL.