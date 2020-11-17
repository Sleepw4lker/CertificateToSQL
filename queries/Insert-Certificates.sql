INSERT IGNORE
INTO pscertdb.Certificates (
    SubjectCN,
    IssuerCN,
    SerialNumber,
    NotBefore,
    NotAfter,
    ski,
    aki,
    KeyAlgorithm,
    KeyLength,
    KeyUsage,
    Thumbprint,
    isCA,
    CertificateTemplate,
    CertificateTemplateMajorVersion,
    CertificateTemplateMinorVersion,
    SignatureAlgorithm
)
VALUES (
    @SubjectCN, 
    @IssuerCN, 
    @SerialNumber, 
    @NotBefore, 
    @NotAfter, 
    @ski, 
    @aki, 
    @KeyAlgorithm, 
    @KeyLength,
    @KeyUsage,
    @Thumbprint, 
    @isCA, 
    @CertificateTemplate, 
    @CertificateTemplateMajorVersion,
    @CertificateTemplateMinorVersion,
    @SignatureAlgorithm
);