-- pscertdb.EnhancedKeyUsages definition

CREATE TABLE `EnhancedKeyUsages` (
  `Oid` varchar(100) NOT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  PRIMARY KEY (`Oid`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;