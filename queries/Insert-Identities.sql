INSERT IGNORE
INTO pscertdb.Identities (
    Name, 
    Value, 
    Thumbprint
)
VALUES (
    @Name, 
    @Value, 
    @Thumbprint
)