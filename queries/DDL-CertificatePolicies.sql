-- pscertdb.CertificatePolicies definition

CREATE TABLE `CertificatePolicies` (
  `Oid` varchar(100) NOT NULL,
  `Thumbprint` varchar(100) NOT NULL,
  PRIMARY KEY (`Oid`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;