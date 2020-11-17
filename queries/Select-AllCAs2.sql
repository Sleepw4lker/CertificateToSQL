SELECT SubjectCN,IssuerCN,NotBefore,NotAfter,KeyLength,SignatureAlgorithm,Thumbprint,ski
FROM pscertdb.Certificates
WHERE isCA = 1;