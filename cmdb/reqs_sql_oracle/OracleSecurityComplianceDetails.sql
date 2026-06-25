-- Source: OracleSecurityComplianceDetails.php
-- Oracle version:
--   comment -> comments in exception tables
--   REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK') for NUMBER columns
--   CONCAT() -> || operator (all involved columns are VARCHAR2)
-- Paramètre: :db_name  (correspond à $_GET["db_name"])

-- SQLNET Network Encryption
SELECT 'SQL Net Encryption Method', a.sqlnet_encryption,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK')
FROM oracle_security_network_encryption a
WHERE a.db_name = :db_name;

-- DB Parameters
SELECT a.parameter_name, a.parameter_value,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_parameter a, oracle_security_parameter_exception b
WHERE a.db_name = b.db_name
  AND a.parameter_name = b.parameter_name
  AND a.parameter_value = b.parameter_value
  AND a.db_name = :db_name
UNION ALL
SELECT parameter_name, parameter_value,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_parameter
WHERE db_name || parameter_name || parameter_value NOT IN (
    SELECT db_name || parameter_name || parameter_value
    FROM oracle_security_parameter_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- Audit Activated
SELECT pdb_name, audit_parameter,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK')
FROM oracle_security_audit_enable
WHERE db_name = :db_name;

-- User Default Password
SELECT pdb_name, username,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK')
FROM oracle_security_default_user_pwd
WHERE db_name = :db_name;

-- DB Profile Definition
SELECT a.pdb_name, a.profile, a.resource_name, a.limit_value,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_profile a, oracle_security_profile_exception b
WHERE a.db_name = b.db_name
  AND a.profile = b.profile
  AND a.resource_name = b.resource_name
  AND a.limit_value = b.limit_value
  AND a.db_name = :db_name
UNION ALL
SELECT pdb_name, profile, resource_name, limit_value,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_profile
WHERE db_name || pdb_name || profile || resource_name || limit_value NOT IN (
    SELECT pdb_name || profile || resource_name || limit_value
    FROM oracle_security_profile_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- Users PasswordFile (Admin High Privs)
SELECT a.username,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_admin_high_privs a, oracle_security_admin_high_privs_exception b
WHERE a.db_name = b.db_name
  AND a.username = b.username
  AND a.db_name = :db_name
UNION ALL
SELECT username,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_admin_high_privs
WHERE db_name || username NOT IN (
    SELECT db_name || username
    FROM oracle_security_admin_high_privs_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- Users With Default Profile
SELECT a.pdb_name, a.username, a.profile,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_default_profile a, oracle_security_default_profile_exception b
WHERE a.db_name = b.db_name
  AND a.pdb_name = b.pdb_name
  AND a.username = b.username
  AND a.profile = b.profile
  AND a.db_name = :db_name
UNION ALL
SELECT pdb_name, username, profile,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_default_profile
WHERE db_name || pdb_name || username || profile NOT IN (
    SELECT db_name || pdb_name || username || profile
    FROM oracle_security_default_profile_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- Encrypted TableSpace State
SELECT db_name, pdb_name, tablespace_name, encrypted,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK')
FROM oracle_security_tablespace_encrypted
WHERE db_name = :db_name;

-- High Role Privs
SELECT a.pdb_name, a.username, a.privilege,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_high_role_privs a, oracle_security_high_role_privs_exception b
WHERE a.db_name = b.db_name
  AND a.pdb_name = b.pdb_name
  AND a.username = b.username
  AND a.privilege = b.privilege
  AND a.db_name = :db_name
UNION ALL
SELECT pdb_name, username, privilege,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_high_role_privs
WHERE db_name || pdb_name || username || privilege NOT IN (
    SELECT db_name || pdb_name || username || privilege
    FROM oracle_security_high_role_privs_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- High Sys Privs
SELECT a.pdb_name, a.username, a.privilege,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_high_sys_privs a, oracle_security_high_sys_privs_exception b
WHERE a.db_name = b.db_name
  AND a.pdb_name = b.pdb_name
  AND a.username = b.username
  AND a.privilege = b.privilege
  AND a.db_name = :db_name
UNION ALL
SELECT pdb_name, username, privilege,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_high_sys_privs
WHERE db_name || pdb_name || username || privilege NOT IN (
    SELECT db_name || pdb_name || username || privilege
    FROM oracle_security_high_sys_privs_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;

-- High Tab Privs
SELECT a.pdb_name, a.username, a.privilege,
       REPLACE(REPLACE(TO_CHAR(a.compliance_score),'1','OK'),'0','NOK'),
       b.comments AS Exception
FROM oracle_security_high_tab_privs a, oracle_security_high_tab_privs_exception b
WHERE a.db_name = b.db_name
  AND a.pdb_name = b.pdb_name
  AND a.username = b.username
  AND a.privilege = b.privilege
  AND a.db_name = :db_name
UNION ALL
SELECT pdb_name, username, privilege,
       REPLACE(REPLACE(TO_CHAR(compliance_score),'1','OK'),'0','NOK'),
       'No exception set' AS Exception
FROM oracle_security_high_tab_privs
WHERE db_name || pdb_name || username || privilege NOT IN (
    SELECT db_name || pdb_name || username || privilege
    FROM oracle_security_high_tab_privs_exception
    WHERE db_name = :db_name
)
  AND db_name = :db_name;
