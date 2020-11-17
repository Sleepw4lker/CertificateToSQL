-- pscertdb.CertificateTemplates definition

CREATE TABLE `CertificateTemplates` (
  `Oid` varchar(100) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `ForestDN` varchar(100) NOT NULL,
  PRIMARY KEY (`Oid`,`ForestDN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;