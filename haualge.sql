DROP TABLE IF EXISTS `dnsResponses`;
DROP TABLE IF EXISTS `answers`;
DROP TABLE IF EXISTS `flowlogs`;
DROP TABLE IF EXISTS `hosts`;

CREATE TABLE `answers` (
  `host` varbinary(255) NOT NULL,
  `ip_addresses` varbinary(512) NOT NULL,
  `ttls` varbinary(255) NOT NULL,
  idx bigint UNSIGNED AUTO_INCREMENT,
  UNIQUE KEY (host, ip_addresses, ttls),
  PRIMARY KEY (idx)
) ENGINE=InnoDB;

CREATE TABLE dnsResponses (
  time timestamp NOT NULL,
  src_ip binary(16) NOT NULL,
  dest_ip binary(16) NOT NULL,
  opcode int UNSIGNED NOT NULL,
  resultcode int UNSIGNED NOT NULL,
  answer bigint UNSIGNED NOT NULL,
  FOREIGN KEY (answer) REFERENCES answers(idx)
) ENGINE=InnoDB;

CREATE TABLE `hosts` (
  `hostID` bigint(20) NOT NULL AUTO_INCREMENT,
  `hostname` varbinary(128) NOT NULL,
  `ipAddress` varbinary(16) NOT NULL,
  PRIMARY KEY (`hostID`)
) ENGINE=InnoDB;

CREATE TABLE `flowlogs` (
  `intervalStart` timestamp NOT NULL,
  `intervalStop` timestamp NOT NULL,
  `addressA` varbinary(16) NOT NULL,
  `addressB` varbinary(16) NOT NULL,
  `hostA` bigint NOT NULL,
  `hostB` bigint NOT NULL,
  `bytesAtoB` bigint NOT NULL,
  `bytesBtoA` bigint NOT NULL,
  FOREIGN KEY (hostA) REFERENCES hosts(hostID),
  FOREIGN KEY (hostB) REFERENCES hosts(hostID)
) ENGINE=InnoDB;