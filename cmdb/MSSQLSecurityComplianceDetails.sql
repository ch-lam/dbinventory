-- Source: MSSQLSecurityComplianceDetails.php
-- Paramètre: :servername  (correspond à $_GET["servername"])

-- Configuration Options
SELECT a.name, a.config_value,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_configoptions a, mssql_security_configoptions_exception b
WHERE a.servername = b.servername
  AND a.name = b.name
  AND a.config_value = b.config_value
  AND a.servername = :servername
UNION ALL
SELECT name, config_value,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_configoptions
WHERE concat(servername,name,config_value) NOT IN (
    SELECT concat(servername,name,config_value)
    FROM mssql_security_configoptions_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Database Properties
SELECT a.db_name, a.is_auto_close_on, a.is_trustworthy_on,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_dbproperties a, mssql_security_dbproperties_exception b
WHERE a.servername = b.servername
  AND a.db_name = b.db_name
  AND a.servername = :servername
UNION ALL
SELECT db_name, is_auto_close_on, is_trustworthy_on,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_dbproperties
WHERE concat(servername,db_name,is_auto_close_on,is_trustworthy_on) NOT IN (
    SELECT concat(servername,db_name,is_auto_close_on,is_trustworthy_on)
    FROM mssql_security_dbproperties_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Encryption
SELECT a.db_name, a.key_type, a.key_name, a.algorithm_desc,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_encryption a, mssql_security_encryption_exception b
WHERE a.servername = b.servername
  AND a.db_name = b.db_name
  AND a.key_type = b.key_type
  AND a.key_name = b.key_name
  AND a.servername = :servername
UNION ALL
SELECT db_name, key_type, key_name, algorithm_desc,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_encryption
WHERE concat(servername,db_name,key_type,key_name) NOT IN (
    SELECT concat(servername,db_name,key_type,key_name)
    FROM mssql_security_encryption_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Local Builtin Groups
SELECT localgroupname, permission_name, state_desc,
       replace(replace(compliance_score,'1','OK'),0,'NOK')
FROM mssql_security_groups
WHERE servername = :servername;

-- Guest Connect
SELECT a.db_name, a.permission_name, a.state_desc,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_guestconnect a, mssql_security_guestconnect_exception b
WHERE a.db_name = b.db_name
  AND a.permission_name = b.permission_name
  AND a.state_desc = b.state_desc
  AND a.servername = :servername
UNION ALL
SELECT db_name, permission_name, state_desc,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_guestconnect
WHERE concat(db_name,permission_name,state_desc) NOT IN (
    SELECT concat(db_name,permission_name,state_desc)
    FROM mssql_security_guestconnect_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Logins
SELECT a.login_name, a.principal_id, a.is_sysadmin, a.is_policy_checked, a.access_method,
       a.is_expiration_checked, a.is_disabled, a.create_date,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_logins a, mssql_security_logins_exception b
WHERE a.servername = b.servername
  AND a.login_name = b.login_name
  AND a.servername = :servername
UNION ALL
SELECT login_name, principal_id, is_sysadmin, is_policy_checked, access_method,
       is_expiration_checked, is_disabled, create_date,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_logins
WHERE concat(servername,login_name) NOT IN (
    SELECT concat(servername,login_name)
    FROM mssql_security_logins_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Orphaned Users
SELECT a.db_name, a.user_name,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_orphanedusers a, mssql_security_orphanedusers_exception b
WHERE a.servername = b.servername
  AND a.db_name = b.db_name
  AND a.user_name = b.user_name
  AND a.servername = :servername
UNION ALL
SELECT db_name, user_name,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_orphanedusers
WHERE concat(servername,db_name,user_name) NOT IN (
    SELECT concat(servername,db_name,user_name)
    FROM mssql_security_orphanedusers_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Public Permissions
SELECT a.db_name, a.username, a.permission_name, a.state_desc,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_publicpermission a, mssql_security_publicpermission_exception b
WHERE a.servername = b.servername
  AND a.db_name = b.db_name
  AND a.username = b.username
  AND a.state_desc = b.state_desc
  AND a.servername = :servername
UNION ALL
SELECT db_name, username, permission_name, state_desc,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_publicpermission
WHERE concat(db_name,username,permission_name,state_desc) NOT IN (
    SELECT concat(db_name,username,permission_name,state_desc)
    FROM mssql_security_publicpermission_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- Registry Checks
SELECT a.name, a.value,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_registryinfo a, mssql_security_registryinfo_exception b
WHERE a.servername = b.servername
  AND concat(a.servername,a.name) IN (
      SELECT concat(servername,name)
      FROM mssql_security_registryinfo_exception
      WHERE a.servername = :servername
  )
  AND a.servername = :servername
UNION ALL
SELECT name, value,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_registryinfo
WHERE concat(servername,name) NOT IN (
    SELECT concat(servername,name)
    FROM mssql_security_registryinfo_exception
    WHERE servername = :servername
)
  AND servername = :servername;

-- SQL Server Audit
SELECT a.auditname, a.auditenabled, a.writelocation, a.auditspecificationname,
       a.auditspecificationenabled, a.auditactionname,
       replace(replace(a.compliance_score,'1','OK'),0,'NOK'),
       b.comment AS Exception
FROM mssql_security_sqlserveraudit a, mssql_security_sqlserveraudit_exception b
WHERE a.servername = b.servername
  AND a.servername = :servername
UNION ALL
SELECT auditname, auditenabled, writelocation, auditspecificationname,
       auditspecificationenabled, auditactionname,
       replace(replace(compliance_score,'1','OK'),0,'NOK'),
       'No exception set' AS Exception
FROM mssql_security_sqlserveraudit
WHERE concat(servername,auditactionname) NOT IN (
    SELECT concat(servername,auditactionname)
    FROM mssql_security_sqlserveraudit_exception
    WHERE servername = :servername
)
  AND servername = :servername;
