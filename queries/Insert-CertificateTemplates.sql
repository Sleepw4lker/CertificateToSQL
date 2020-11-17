INSERT IGNORE
INTO pscertdb.CertificateTemplates (
    Oid,
    Name, 
    DisplayName,
    ForestDN
)
VALUES (
    @Oid,
    @Name, 
    @DisplayName,
    @ForestDN
)