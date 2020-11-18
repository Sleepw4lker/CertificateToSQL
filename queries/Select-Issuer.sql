SELECT a.SubjectCN, b.SubjectCN AS Issuer, a.SerialNumber, a.NotBefore, a.NotAfter, a.ski, a.aki, a.Thumbprint, a.KeyLength, a.isCA, a.CertificateTemplate, a.SignatureAlgorithm, a.KeyAlgorithm, a.CertificateTemplateMajorVersion, a.CertificateTemplateMinorVersion, a.KeyUsage
FROM pscertdb.Certificates a
LEFT JOIN pscertdb.Certificates b
ON a.aki = b.ski
