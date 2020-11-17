USE pscertdb;
SELECT i.Value,c.SerialNumber, c.NotBefore, c.NotAfter, c.SubjectCN, c. Thumbprint, c.ski, c.CertificateTemplate 
FROM Identities i
LEFT JOIN Certificates c
ON i.Thumbprint = c.Thumbprint
WHERE i.Name = "DNS"