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