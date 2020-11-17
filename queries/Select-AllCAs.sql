USE pscertdb;
SELECT i.Value,c.IssuerCN,c.NotBefore,c.NotAfter,c.KeyLength,c.SignatureAlgorithm,c.Thumbprint,c.ski
FROM Identities i
LEFT JOIN Certificates c
ON i.Thumbprint = c.Thumbprint
WHERE c.isCA = 1
AND i.Name = "CN"
ORDER BY i.Value ASC;