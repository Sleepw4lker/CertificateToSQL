-- pscertdb.Identities definition

CREATE TABLE `Identities` (
  `Name` varchar(64) NOT NULL,
  `Value` varchar(100) NOT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  PRIMARY KEY (`Name`,`Value`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;