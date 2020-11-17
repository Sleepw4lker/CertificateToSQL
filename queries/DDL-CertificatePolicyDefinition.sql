-- pscertdb.CertificatePolicyDefinition definition

CREATE TABLE `CertificatePolicyDefinition` (
  `Oid` varchar(100) NOT NULL,
  `Url` varchar(255) DEFAULT NULL,
  `UserNotice` varchar(4096) DEFAULT NULL,
  `Description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`Oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;