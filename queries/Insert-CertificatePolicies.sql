INSERT IGNORE
INTO pscertdb.CertificatePolicies (
    Oid, 
    Thumbprint
)
VALUES (
    @Oid, 
    @Thumbprint
)