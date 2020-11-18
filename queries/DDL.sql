CREATE DATABASE `pscertdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

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

-- pscertdb.Identities definition

CREATE TABLE `Identities` (
  `Name` varchar(64) NOT NULL,
  `Value` varchar(512) NOT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  PRIMARY KEY (`Name`,`Value`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pscertdb.CertificatePolicies definition

CREATE TABLE `CertificatePolicies` (
  `Oid` varchar(100) NOT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  PRIMARY KEY (`Oid`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pscertdb.CertificatePolicyDefinition definition

CREATE TABLE `CertificatePolicyDefinition` (
  `Oid` varchar(100) NOT NULL,
  `Url` varchar(255) DEFAULT NULL,
  `UserNotice` varchar(4096) DEFAULT NULL,
  `Description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`Oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pscertdb.CertificateTemplates definition

CREATE TABLE `CertificateTemplates` (
  `Oid` varchar(100) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `ForestDN` varchar(100) NOT NULL,
  PRIMARY KEY (`Oid`,`ForestDN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pscertdb.EnhancedKeyUsages definition

CREATE TABLE `EnhancedKeyUsages` (
  `Oid` varchar(100) NOT NULL,
  `Thumbprint` varchar(40) NOT NULL,
  PRIMARY KEY (`Oid`,`Thumbprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- pscertdb.EnhancedKeyUsageDefinition definition

CREATE TABLE `EnhancedKeyUsageDefinition` (
  `Oid` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Oid`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.12.1', 'All Application Policies');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.21.5', 'CA Encryption Certificate');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.20.2.1', 'Certificate Request Agent');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.2', 'Client Authentication');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.3', 'Code Signing');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.12', 'Document Signing');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.4', 'Encrypting file system');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.4.1', 'File Recovery');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.5', 'IP Security End System');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.8.2.2', 'IP Security IKE Intermediate');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.6', 'IP Security Tunnel Endpoint');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.7', 'IP Security User');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.11', 'Key Recovery');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.2.3.5', 'KDC Authentication');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.1', 'Microsoft Trust List Signing');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.10', 'Qualified Subordination');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.10.3.9', 'Root List Signer');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.4', 'Secure E-mail');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.1', 'Server Authentication');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.20.2.2', 'Smart Card Logon');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.8', 'Time Stamping');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.5.5.7.3.9', 'OCSP Signing');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.54.1.2', 'Remote Desktop Authentication');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('1.3.6.1.4.1.311.21.5', 'Private Key Archival');
INSERT INTO pscertdb.EnhancedKeyUsageDefinition (Oid, Name) VALUES ('2.16.840.1.113741.1.2.3', 'AMT Provisioning');