INSERT IGNORE
INTO pscertdb.EnhancedKeyUsages (
    Oid, 
    Thumbprint
)
VALUES (
    @Oid, 
    @Thumbprint
)