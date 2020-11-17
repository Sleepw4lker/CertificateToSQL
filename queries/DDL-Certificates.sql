-- pscertdb.Certificates definition

CREATE TABLE `Certificates` (
  `SerialNumber` varchar(38) NOT NULL,
  `NotBefore` datetime NOT NULL,
  `NotAfter` datetime NOT NULL,
  `SubjectCN` varchar(255) DEFAULT NULL,
  `ski` varchar(40) DEFAULT NULL,
  `aki` varchar(40) DEFAULT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  `IssuerCN` varchar(64) NOT NULL,
  `KeyLength` int(11) NOT NULL,
  `isCA` bit(1) NOT NULL,
  `CertificateTemplate` varchar(128) DEFAULT NULL,
  `SignatureAlgorithm` varchar(16) NOT NULL,
  `KeyAlgorithm` varchar(16) NOT NULL,
  `CertificateTemplateMajorVersion` int(11) DEFAULT NULL,
  `CertificateTemplateMinorVersion` int(11) DEFAULT NULL,
  `KeyUsage` int(11) DEFAULT NULL,
  PRIMARY KEY (`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;