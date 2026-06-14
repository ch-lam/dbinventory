-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 12 juin 2026 à 09:30
-- Version du serveur : 11.8.5-MariaDB
-- Version de PHP : 8.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `inventory`
--
CREATE DATABASE IF NOT EXISTS `inventory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE `inventory`;

-- --------------------------------------------------------

--
-- Structure de la table `adminlogin`
--

CREATE TABLE `adminlogin` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chl_ipam_comment`
--

CREATE TABLE `chl_ipam_comment` (
  `hostname` varchar(100) NOT NULL,
  `comment` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_backup`
--

CREATE TABLE `mssql_backup` (
  `hostname` varchar(50) NOT NULL,
  `database_name` varchar(100) NOT NULL,
  `backup_start_date` datetime NOT NULL,
  `backup_finish_date` datetime NOT NULL,
  `backup_type` varchar(20) NOT NULL,
  `backup_size` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_backup_info_history`
--

CREATE TABLE `mssql_backup_info_history` (
  `scoring_result` timestamp NOT NULL DEFAULT current_timestamp(),
  `environment` varchar(20) NOT NULL,
  `cumulative_hours_between_backup` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_backup_stats`
--

CREATE TABLE `mssql_backup_stats` (
  `hostname` varchar(50) NOT NULL,
  `database_name` varchar(100) NOT NULL,
  `recovery_model` varchar(20) NOT NULL,
  `Backup_Type` varchar(20) NOT NULL,
  `cumulative_hours_between_backup` int(11) NOT NULL,
  `NbreBU` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_backup_summary`
--

CREATE TABLE `mssql_backup_summary` (
  `hostname` varchar(50) NOT NULL DEFAULT '',
  `database_name` varchar(100) NOT NULL DEFAULT '',
  `recovery_model` varchar(100) DEFAULT NULL,
  `backup_type` varchar(20) NOT NULL DEFAULT '',
  `backup_start_date` datetime NOT NULL,
  `previous_backup` datetime NOT NULL,
  `hours_between_backup` int(10) NOT NULL,
  `environment` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_backup_temp`
--

CREATE TABLE `mssql_backup_temp` (
  `hostname` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `database_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `backup_start_date` datetime NOT NULL,
  `backup_finish_date` datetime NOT NULL,
  `backup_type` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `backup_size` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_database`
--

CREATE TABLE `mssql_database` (
  `hostname` varchar(100) DEFAULT NULL,
  `database_id` int(5) DEFAULT NULL,
  `database_name` varchar(100) DEFAULT NULL,
  `database_state` varchar(100) DEFAULT NULL,
  `recovery_model` varchar(100) DEFAULT NULL,
  `compatibility_level` varchar(100) DEFAULT NULL,
  `collation` varchar(100) DEFAULT NULL,
  `last_backup_date` varchar(100) DEFAULT NULL,
  `last_backup_diff_date` varchar(100) DEFAULT NULL,
  `last_backup_log_date` varchar(100) DEFAULT NULL,
  `create_date` varchar(100) DEFAULT NULL,
  `is_mirroring_enabled` int(6) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `agtype` varchar(50) DEFAULT NULL,
  `agname` varchar(50) DEFAULT NULL,
  `env` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_files`
--

CREATE TABLE `mssql_files` (
  `hostname` varchar(100) NOT NULL,
  `database_name` varchar(100) NOT NULL,
  `file_id` int(11) NOT NULL,
  `type_desc` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `physical_name` varchar(255) NOT NULL,
  `size_mb` int(11) NOT NULL,
  `growth_percent` int(11) NOT NULL,
  `growth_mb` int(11) NOT NULL,
  `max_size` int(11) NOT NULL,
  `env` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_hosts`
--

CREATE TABLE `mssql_hosts` (
  `hostname` varchar(100) DEFAULT NULL,
  `mssql_edition` varchar(100) DEFAULT NULL,
  `mssql_product_version` varchar(100) DEFAULT NULL,
  `collation` varchar(100) DEFAULT NULL,
  `is_clustered` int(5) DEFAULT NULL,
  `ActiveNodeName` varchar(50) NOT NULL,
  `clusternode1` varchar(50) DEFAULT NULL,
  `clusternode2` varchar(50) DEFAULT NULL,
  `parallel_threshold` int(20) DEFAULT NULL,
  `max_dop` int(20) DEFAULT NULL,
  `min_memory` int(20) DEFAULT NULL,
  `max_memory` int(20) DEFAULT NULL,
  `xp_cmdshell_enabled` int(20) DEFAULT NULL,
  `num_cpus` int(6) DEFAULT NULL,
  `memory_gb` int(6) DEFAULT NULL,
  `os_type` varchar(100) DEFAULT NULL,
  `service_account` varchar(100) DEFAULT NULL,
  `env` varchar(10) NOT NULL,
  `license_type` varchar(50) NOT NULL,
  `install_date` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_logins`
--

CREATE TABLE `mssql_logins` (
  `instance_name` varchar(40) NOT NULL,
  `LoginName` varchar(100) NOT NULL,
  `AccountCreationDate` varchar(30) NOT NULL,
  `LastTimeAccountModified` varchar(30) NOT NULL,
  `PasswordLastSetTime` varchar(30) NOT NULL,
  `DefaultDatabase` varchar(100) NOT NULL,
  `DefaultLanguage` varchar(50) NOT NULL,
  `IsDisabledChecked` varchar(30) NOT NULL,
  `IsPolicyChecked` varchar(30) NOT NULL,
  `IsExpirationChecked` varchar(30) NOT NULL,
  `IsExpired` varchar(30) NOT NULL,
  `DaysUntilExpiration` varchar(30) DEFAULT NULL,
  `IsLocked` varchar(30) NOT NULL,
  `IsMustChange` varchar(30) NOT NULL,
  `LockoutTime` varchar(30) NOT NULL,
  `BadPasswordCount` varchar(30) NOT NULL,
  `BadPasswordTime` varchar(30) NOT NULL,
  `HistoryLength` varchar(30) NOT NULL,
  `LoginSid` varchar(200) NOT NULL,
  `LoginType` varchar(10) NOT NULL,
  `HasServerRole` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_loginwoperm`
--

CREATE TABLE `mssql_loginwoperm` (
  `instance_name` varchar(50) NOT NULL,
  `loginname` varchar(150) NOT NULL,
  `Type_desc` varchar(50) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL,
  `db_perms` varchar(150) NOT NULL,
  `srv_perms` varchar(150) NOT NULL,
  `modify_date` datetime NOT NULL,
  `ScanDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_auditlevel`
--

CREATE TABLE `mssql_security_auditlevel` (
  `servername` varchar(50) NOT NULL,
  `auditlevel` varchar(50) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_auditlevel_exception`
--

CREATE TABLE `mssql_security_auditlevel_exception` (
  `servername` varchar(50) NOT NULL,
  `auditlevel` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_configoptions`
--

CREATE TABLE `mssql_security_configoptions` (
  `servername` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config_value` int(11) NOT NULL,
  `run_value` int(11) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_configoptions_exception`
--

CREATE TABLE `mssql_security_configoptions_exception` (
  `servername` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config_value` int(11) NOT NULL,
  `run_value` int(11) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_dbproperties`
--

CREATE TABLE `mssql_security_dbproperties` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `is_auto_close_on` int(11) NOT NULL,
  `is_trustworthy_on` int(11) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_dbproperties_exception`
--

CREATE TABLE `mssql_security_dbproperties_exception` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `is_auto_close_on` int(11) NOT NULL,
  `is_trustworthy_on` int(11) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_encryption`
--

CREATE TABLE `mssql_security_encryption` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `key_type` varchar(50) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `algorithm_desc` varchar(50) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_encryption_exception`
--

CREATE TABLE `mssql_security_encryption_exception` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `key_type` varchar(50) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `algorithm_desc` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_groups`
--

CREATE TABLE `mssql_security_groups` (
  `Servername` varchar(50) NOT NULL,
  `localgroupname` varchar(50) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_groups_exception`
--

CREATE TABLE `mssql_security_groups_exception` (
  `Servername` varchar(50) NOT NULL,
  `localgroupname` varchar(50) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_guestconnect`
--

CREATE TABLE `mssql_security_guestconnect` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `permission_name` varchar(50) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_guestconnect_exception`
--

CREATE TABLE `mssql_security_guestconnect_exception` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `permission_name` varchar(50) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_history`
--

CREATE TABLE `mssql_security_history` (
  `servername` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `compliance_score_total` int(2) DEFAULT NULL,
  `date_value` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_logins`
--

CREATE TABLE `mssql_security_logins` (
  `servername` varchar(50) NOT NULL,
  `login_name` varchar(100) NOT NULL,
  `principal_id` varchar(100) NOT NULL,
  `is_sysadmin` int(2) NOT NULL,
  `is_policy_checked` int(2) NOT NULL,
  `Access_Method` varchar(50) NOT NULL,
  `is_expiration_checked` int(2) NOT NULL,
  `is_disabled` int(2) NOT NULL,
  `create_date` datetime NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_logins_exception`
--

CREATE TABLE `mssql_security_logins_exception` (
  `servername` varchar(50) NOT NULL,
  `login_name` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_orphanedusers`
--

CREATE TABLE `mssql_security_orphanedusers` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_orphanedusers_exception`
--

CREATE TABLE `mssql_security_orphanedusers_exception` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_publicpermission`
--

CREATE TABLE `mssql_security_publicpermission` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_publicpermission_exception`
--

CREATE TABLE `mssql_security_publicpermission_exception` (
  `servername` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `state_desc` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_registryinfo`
--

CREATE TABLE `mssql_security_registryinfo` (
  `servername` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` int(11) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_registryinfo_exception`
--

CREATE TABLE `mssql_security_registryinfo_exception` (
  `servername` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_scoring`
--

CREATE TABLE `mssql_security_scoring` (
  `Servername` varchar(50) NOT NULL,
  `environment` varchar(20) DEFAULT NULL,
  `configoptions` int(2) NOT NULL DEFAULT 0,
  `dbproperties` int(2) NOT NULL DEFAULT 0,
  `auditlevel` int(2) NOT NULL DEFAULT 0,
  `encryption` int(11) NOT NULL DEFAULT 0,
  `groups` int(11) NOT NULL DEFAULT 0,
  `guestconnect` int(11) NOT NULL DEFAULT 0,
  `logins` int(11) NOT NULL DEFAULT 0,
  `orphanedusers` int(11) NOT NULL DEFAULT 0,
  `publicpermission` int(11) NOT NULL DEFAULT 0,
  `registryinfo` int(11) NOT NULL DEFAULT 0,
  `sqlserveraudit` int(11) NOT NULL DEFAULT 0,
  `compliance_score_total` int(2) NOT NULL DEFAULT 0,
  `exception_detected` int(2) NOT NULL DEFAULT 0,
  `legacy_server` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_sqlserveraudit`
--

CREATE TABLE `mssql_security_sqlserveraudit` (
  `servername` varchar(50) NOT NULL,
  `auditname` varchar(50) NOT NULL,
  `auditenabled` int(2) NOT NULL,
  `writelocation` varchar(50) NOT NULL,
  `auditspecificationname` varchar(100) NOT NULL,
  `auditspecificationenabled` int(2) NOT NULL,
  `auditactionname` varchar(100) NOT NULL,
  `audited_result` varchar(30) NOT NULL,
  `compliance_score` int(2) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_security_sqlserveraudit_exception`
--

CREATE TABLE `mssql_security_sqlserveraudit_exception` (
  `servername` varchar(50) NOT NULL,
  `auditactionname` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '0',
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_users`
--

CREATE TABLE `mssql_users` (
  `instance_name` varchar(50) NOT NULL,
  `database_name` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `GroupName` varchar(100) NOT NULL,
  `LoginName` varchar(100) NOT NULL,
  `DefaultDBName` varchar(100) NOT NULL,
  `defaultSchemaName` varchar(100) NOT NULL,
  `PrincipalID` int(11) NOT NULL,
  `sid` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mssql_validatelogin`
--

CREATE TABLE `mssql_validatelogin` (
  `Servername` varchar(150) NOT NULL,
  `sid` varchar(200) NOT NULL,
  `Login` varchar(150) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL,
  `Modify_date` datetime NOT NULL,
  `ScanDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_audit_logon`
--

CREATE TABLE `oracle_audit_logon` (
  `db_name` varchar(50) NOT NULL,
  `logon_time` varchar(100) DEFAULT NULL,
  `db_username` varchar(100) NOT NULL,
  `os_username` varchar(100) NOT NULL,
  `host_client` varchar(100) NOT NULL,
  `client_name` varchar(200) NOT NULL,
  `expected_logon` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_audit_logon_history`
--

CREATE TABLE `oracle_audit_logon_history` (
  `db_name` varchar(50) NOT NULL,
  `logon_time` varchar(100) DEFAULT NULL,
  `db_username` varchar(100) NOT NULL,
  `os_username` varchar(100) NOT NULL,
  `host_client` varchar(100) NOT NULL,
  `client_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_backup_info`
--

CREATE TABLE `oracle_backup_info` (
  `db_name` varchar(50) NOT NULL,
  `environment` varchar(20) DEFAULT NULL,
  `backup_type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `elapsed_time` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_backup_info_archivelog_gap`
--

CREATE TABLE `oracle_backup_info_archivelog_gap` (
  `db_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `previous_time` datetime(6) NOT NULL,
  `hours_between_backup` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_backup_info_history`
--

CREATE TABLE `oracle_backup_info_history` (
  `scoring_result` timestamp NOT NULL DEFAULT current_timestamp(),
  `environment` varchar(20) NOT NULL,
  `count_backup_failed` varchar(50) NOT NULL,
  `cumulative_hours_between_backup` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_backup_summary`
--

CREATE TABLE `oracle_backup_summary` (
  `db_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `failed_backup_detected` int(10) NOT NULL DEFAULT 0,
  `avg_archive_elapsed` int(10) NOT NULL,
  `avg_archive_sla` int(10) NOT NULL,
  `backup_archive_sla_result` int(10) NOT NULL DEFAULT 0,
  `avg_inc_elapsed` int(10) NOT NULL,
  `avg_inc_sla` int(10) NOT NULL,
  `backup_inc_sla_result` int(10) NOT NULL DEFAULT 0,
  `cumulative_hours_between_backup` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_client_info`
--

CREATE TABLE `oracle_client_info` (
  `db_name` varchar(50) NOT NULL,
  `db_version` varchar(50) NOT NULL,
  `environment` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `client_version` varchar(50) NOT NULL,
  `client_driver` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `client_host` varchar(50) NOT NULL,
  `service_name` varchar(50) NOT NULL,
  `failover_type` varchar(50) NOT NULL,
  `failover_method` varchar(50) NOT NULL,
  `check_client` int(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_cpu_mem`
--

CREATE TABLE `oracle_database_capacity_planning_cpu_mem` (
  `pdb_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `cpu_time_minutes` int(100) NOT NULL,
  `avg_sga_mb` int(100) NOT NULL,
  `avg_pga_mb` int(100) NOT NULL,
  `avg_buffer_cache_mb` int(100) NOT NULL,
  `avg_shared_pool_mb` int(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_cpu_mem_history`
--

CREATE TABLE `oracle_database_capacity_planning_cpu_mem_history` (
  `pdb_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `cpu_time_minutes` int(100) NOT NULL,
  `avg_sga_mb` int(100) NOT NULL,
  `avg_pga_mb` int(100) NOT NULL,
  `avg_buffer_cache_mb` int(100) NOT NULL,
  `avg_shared_pool_mb` int(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_cpu_service_history`
--

CREATE TABLE `oracle_database_capacity_planning_cpu_service_history` (
  `pdb_name` varchar(50) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `dbcpu_time_minutes` int(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_cpu_service_prebuilt`
--

CREATE TABLE `oracle_database_capacity_planning_cpu_service_prebuilt` (
  `pdb_name` varchar(50) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `dbcpu_time_minutes` int(100) NOT NULL,
  `percentage_usage` decimal(50,3) NOT NULL,
  `date_value` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_dbsize`
--

CREATE TABLE `oracle_database_capacity_planning_dbsize` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `environment` varchar(20) DEFAULT NULL,
  `tablespace_name` varchar(200) NOT NULL,
  `size_mb` int(20) NOT NULL,
  `sum_segment_mb` int(20) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_dbsize_history`
--

CREATE TABLE `oracle_database_capacity_planning_dbsize_history` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `environment` varchar(20) DEFAULT NULL,
  `tablespace_name` varchar(200) NOT NULL,
  `size_mb` int(20) NOT NULL,
  `sum_segment_mb` int(20) NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_dbsize_segs`
--

CREATE TABLE `oracle_database_capacity_planning_dbsize_segs` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `tablespace_name` varchar(200) NOT NULL,
  `sum_segment_mb` int(20) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_exacc_usage`
--

CREATE TABLE `oracle_database_capacity_planning_exacc_usage` (
  `price` int(50) DEFAULT NULL,
  `cluster_name` varchar(30) NOT NULL,
  `date_of_month` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_history_app_link`
--

CREATE TABLE `oracle_database_capacity_planning_history_app_link` (
  `pdb_name` varchar(50) NOT NULL DEFAULT '',
  `env` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `application_name` varchar(30) NOT NULL DEFAULT '',
  `app_code` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_history_app_link_bkp`
--

CREATE TABLE `oracle_database_capacity_planning_history_app_link_bkp` (
  `pdb_name` varchar(50) NOT NULL DEFAULT '',
  `env` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `application_name` varchar(30) NOT NULL DEFAULT '',
  `app_code` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_history_prebuilt`
--

CREATE TABLE `oracle_database_capacity_planning_history_prebuilt` (
  `pdb_name` varchar(50) NOT NULL DEFAULT '',
  `env` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `application_name` varchar(30) NOT NULL DEFAULT '',
  `cluster_name` varchar(30) NOT NULL,
  `size_gb` int(50) DEFAULT NULL,
  `cpu_consume_per_month_per_pdb` int(200) DEFAULT NULL,
  `cpu_minutes_price` float DEFAULT NULL,
  `global_percentage_consumption` decimal(50,3) DEFAULT NULL,
  `env_percentage_consumption` decimal(50,3) DEFAULT NULL,
  `date_of_month` varchar(8) DEFAULT NULL,
  `cost_total` float NOT NULL,
  `exacc_cost_usage` float NOT NULL,
  `exacc_ocpu_usage` float NOT NULL,
  `zdlra_cost_usage` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_capacity_planning_summary`
--

CREATE TABLE `oracle_database_capacity_planning_summary` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `size_mb` int(20) NOT NULL,
  `cpu_time_minutes` int(100) NOT NULL DEFAULT 0,
  `avg_sga_mb` int(100) NOT NULL DEFAULT 0,
  `avg_pga_mb` int(100) NOT NULL DEFAULT 0,
  `avg_buffer_cache_mb` int(100) NOT NULL DEFAULT 0,
  `avg_shared_pool_mb` int(100) NOT NULL DEFAULT 0,
  `zdlra_cost_usage` float NOT NULL DEFAULT 0,
  `exacc_ocpu_usage` float NOT NULL DEFAULT 0,
  `exacc_cost_usage` float NOT NULL DEFAULT 0,
  `cost_total` float NOT NULL DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_database_list`
--

CREATE TABLE `oracle_database_list` (
  `hostname` varchar(100) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `db_version` varchar(50) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `db_log_mode` varchar(50) NOT NULL,
  `db_role` varchar(50) NOT NULL,
  `db_charset` varchar(50) NOT NULL,
  `db_edition` varchar(50) NOT NULL,
  `rac_state` varchar(50) NOT NULL,
  `sga` varchar(50) DEFAULT NULL,
  `pga` varchar(50) DEFAULT NULL,
  `asm_free` varchar(50) DEFAULT NULL,
  `asm_total` varchar(50) DEFAULT NULL,
  `easy_connect_tns` varchar(100) DEFAULT NULL,
  `db_unique_name` varchar(50) DEFAULT NULL,
  `environment` varchar(20) NOT NULL,
  `license_type` varchar(50) NOT NULL,
  `database_type` varchar(50) NOT NULL,
  `count_pdb` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_dataguard`
--

CREATE TABLE `oracle_dataguard` (
  `primary_db` varchar(100) NOT NULL,
  `standby_db` varchar(100) NOT NULL,
  `pdb_list_impacted` varchar(2000) DEFAULT NULL,
  `service_list_impacted` varchar(2000) DEFAULT NULL,
  `protection_mode` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_hosts`
--

CREATE TABLE `oracle_hosts` (
  `hostname` varchar(100) NOT NULL,
  `num_cpus` int(6) NOT NULL,
  `memory_gb` int(6) NOT NULL,
  `os_type` varchar(100) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `license_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_jdbc_tns`
--

CREATE TABLE `oracle_jdbc_tns` (
  `service_name` varchar(100) NOT NULL,
  `easy_connect_tns` varchar(100) DEFAULT NULL,
  `db_name` varchar(50) NOT NULL,
  `tcp_port` int(5) DEFAULT NULL,
  `primary_hst` varchar(50) DEFAULT NULL,
  `standby_hst` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_lms`
--

CREATE TABLE `oracle_lms` (
  `db_name` varchar(50) NOT NULL,
  `hostname` varchar(50) NOT NULL,
  `db_pdb_name` varchar(50) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `usage_detected` varchar(100) NOT NULL,
  `first_usage_date` text DEFAULT NULL,
  `last_usage_date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_lms_reference`
--

CREATE TABLE `oracle_lms_reference` (
  `product_name` varchar(150) NOT NULL,
  `num_core` int(6) NOT NULL,
  `license_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_pdbs`
--

CREATE TABLE `oracle_pdbs` (
  `hostname` varchar(100) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `pdb_state` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_psu`
--

CREATE TABLE `oracle_psu` (
  `db_name` varchar(50) NOT NULL,
  `db_version` varchar(50) NOT NULL,
  `psu_applied` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_admin_high_privs`
--

CREATE TABLE `oracle_security_admin_high_privs` (
  `db_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_admin_high_privs_exception`
--

CREATE TABLE `oracle_security_admin_high_privs_exception` (
  `db_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_audit_enable`
--

CREATE TABLE `oracle_security_audit_enable` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `audit_parameter` varchar(50) NOT NULL,
  `audit_activated` int(2) DEFAULT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_default_profile`
--

CREATE TABLE `oracle_security_default_profile` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `profile` varchar(50) NOT NULL,
  `oracle_managed` varchar(50) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_default_profile_exception`
--

CREATE TABLE `oracle_security_default_profile_exception` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `profile` varchar(50) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_default_user_pwd`
--

CREATE TABLE `oracle_security_default_user_pwd` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_role_privs`
--

CREATE TABLE `oracle_security_high_role_privs` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_role_privs_exception`
--

CREATE TABLE `oracle_security_high_role_privs_exception` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_sys_privs`
--

CREATE TABLE `oracle_security_high_sys_privs` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_sys_privs_exception`
--

CREATE TABLE `oracle_security_high_sys_privs_exception` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_tab_privs`
--

CREATE TABLE `oracle_security_high_tab_privs` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_high_tab_privs_exception`
--

CREATE TABLE `oracle_security_high_tab_privs_exception` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_history`
--

CREATE TABLE `oracle_security_history` (
  `db_name` varchar(50) NOT NULL,
  `environment` varchar(20) NOT NULL,
  `compliance_score_total` int(2) DEFAULT NULL,
  `date_value` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_network_encryption`
--

CREATE TABLE `oracle_security_network_encryption` (
  `db_name` varchar(50) NOT NULL,
  `sqlnet_encryption` varchar(200) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_parameter`
--

CREATE TABLE `oracle_security_parameter` (
  `db_name` varchar(50) NOT NULL,
  `parameter_value` varchar(50) NOT NULL,
  `parameter_name` varchar(50) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_parameter_exception`
--

CREATE TABLE `oracle_security_parameter_exception` (
  `db_name` varchar(50) NOT NULL,
  `parameter_value` varchar(50) NOT NULL,
  `parameter_name` varchar(50) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_profile`
--

CREATE TABLE `oracle_security_profile` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `profile` varchar(50) NOT NULL,
  `resource_name` varchar(100) NOT NULL,
  `limit_value` varchar(100) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_profile_exception`
--

CREATE TABLE `oracle_security_profile_exception` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `profile` varchar(50) NOT NULL,
  `resource_name` varchar(100) NOT NULL,
  `limit_value` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_scoring`
--

CREATE TABLE `oracle_security_scoring` (
  `db_name` varchar(50) NOT NULL,
  `environment` varchar(20) DEFAULT NULL,
  `admin_high_privs_score` int(2) DEFAULT 0,
  `audit_enable_score` int(2) DEFAULT 0,
  `default_profile_score` int(2) DEFAULT 0,
  `default_user_pwd_score` int(2) DEFAULT 0,
  `high_role_privs_score` int(2) DEFAULT 0,
  `high_sys_privs_score` int(2) DEFAULT 0,
  `high_tab_privs_score` int(2) DEFAULT 0,
  `security_parameter_score` int(2) DEFAULT 0,
  `security_profile_score` int(2) DEFAULT 0,
  `encrypted_tablespace_score` int(2) DEFAULT 0,
  `network_encryption_score` int(2) DEFAULT 0,
  `compliance_score_total` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_security_tablespace_encrypted`
--

CREATE TABLE `oracle_security_tablespace_encrypted` (
  `db_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `license_type` varchar(50) DEFAULT NULL,
  `tablespace_name` varchar(100) NOT NULL,
  `encrypted` varchar(100) NOT NULL,
  `compliance_score` int(2) DEFAULT 0,
  `date_value` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_services`
--

CREATE TABLE `oracle_services` (
  `hostname` varchar(100) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `service_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oracle_users`
--

CREATE TABLE `oracle_users` (
  `hostname` varchar(100) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `pdb_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `account_status` varchar(100) NOT NULL,
  `db_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_support`
--

CREATE TABLE `product_support` (
  `TYPE` varchar(15) NOT NULL,
  `VERSION` varchar(100) NOT NULL,
  `END_OF_SUPPORT_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adminlogin`
--
ALTER TABLE `adminlogin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mssql_backup`
--
ALTER TABLE `mssql_backup`
  ADD KEY `backup_type_idx` (`backup_type`),
  ADD KEY `backup_finish_date_idx` (`backup_finish_date`),
  ADD KEY `backup_start_date_idx` (`backup_start_date`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adminlogin`
--
ALTER TABLE `adminlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
