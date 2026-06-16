-- =============================================================================
-- get_info_sqlserver_security — Requêtes SQL de collecte sécurité SQL Server
--
-- Exécution : sqlcmd -U monitoring -S <host> -P <pass> -C
-- Les requêtes ci-dessous correspondent aux fichiers sql/*.sql appelés
-- par le script.
-- =============================================================================


-- ── Options de configuration (sql/mssql_getconfigoptions.sql) ────────────────

SELECT @@Servername as Servername,name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name in  ('Ad Hoc Distributed Queries','clr enabled','cross db ownership chaining','Database Mail XPs','Ole Automation Procedures',
'remote access','scan for startup procs','xp_cmdshell','default trace enabled','clr strict security');
GO
SELECT @@Servername as Servername,name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'remote admin connections' AND SERVERPROPERTY('IsClustered') = 0;
GO


-- ── Informations registre (sql/mssql_getregistryinfo.sql) ────────────────────

DECLARE @getValue INT;
EXEC master.sys.xp_instance_regread
@rootkey = N'HKEY_LOCAL_MACHINE',
@key = N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib',
@value_name = N'HideInstance',
@value = @getValue OUTPUT;
SELECT @@Servername, 'Hide Instance', @getValue;
GO
DECLARE @getValue INT;
EXEC master.sys.xp_instance_regread
@rootkey = N'HKEY_LOCAL_MACHINE',
@key = N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib',
@value_name = N'ForceEncryption',
@value = @getValue OUTPUT;
SELECT @@Servername, 'ForceEncryption', @getValue;
GO
DECLARE @value nvarchar(256);
EXECUTE master.dbo.xp_instance_regread
N'HKEY_LOCAL_MACHINE',
N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib\Tcp\IPAll',
N'TcpPort',
@value OUTPUT,
N'no_output';
SELECT @@Servername, 'TCP Port',  @value AS TCP_Port
GO
DECLARE @NumErrorLogs int;
EXEC master.sys.xp_instance_regread
N'HKEY_LOCAL_MACHINE',
N'Software\Microsoft\MSSQLServer\MSSQLServer',
N'NumErrorLogs',
@NumErrorLogs OUTPUT;
SELECT @@Servername, 'NumErrorlogFiles', ISNULL(@NumErrorLogs, -1) AS [NumberOfLogFiles];
GO


-- ── Permission guest CONNECT (sql/mssql_getguestconnect.sql) ─────────────────

DECLARE @command varchar(1000)
SELECT @command = 'USE [?] if exists (SELECT DB_NAME() AS DatabaseName, ''guest'' AS Database_User,[permission_name], [state_desc]
FROM sys.database_permissions WHERE [grantee_principal_id] = DATABASE_PRINCIPAL_ID(''guest'')
AND [state_desc] LIKE ''GRANT%''
AND [permission_name] = ''CONNECT''
AND DB_NAME() NOT IN (''master'',''tempdb'',''msdb''))
SELECT @@Servername, DB_NAME() AS DatabaseName,[permission_name], [state_desc]
FROM sys.database_permissions
WHERE [grantee_principal_id] = DATABASE_PRINCIPAL_ID(''guest'')
AND [state_desc] LIKE ''GRANT%''
AND [permission_name] = ''CONNECT''
AND DB_NAME() NOT IN (''master'',''tempdb'',''msdb'')
ELSE
SELECT @@Servername, DB_NAME(), ''no_permission'', ''no_permission'' '
EXEC sp_MSforeachdb @command
GO


-- ── Utilisateurs orphelins (sql/mssql_getorphanedusers.sql) ──────────────────

EXEC sp_MSforeachdb 'USE [?] If exists
(SELECT @@servername, db_name(), name
FROM sys.database_principals
WHERE sid NOT IN (SELECT sid FROM sys.server_principals)
    AND type = ''S''
    AND principal_id != 2
    AND DATALENGTH(sid) <= 28
    AND name <>''MS_DataCollectorInternalUser'')
SELECT @@servername, db_name(), name
FROM sys.database_principals
WHERE sid NOT IN (
        SELECT sid
        FROM sys.server_principals
        )
    AND type = ''S''
    AND principal_id != 2
    AND DATALENGTH(sid) <= 28
    AND name <>''MS_DataCollectorInternalUser''
ELSE SELECT @@Servername, db_name(), ''NoOrphanedUser'''
GO


-- ── Propriétés des bases (sql/mssql_getdbproperties.sql) ─────────────────────

SELECT @@servername,name, is_auto_close_on,is_trustworthy_on
FROM sys.databases
GO


-- ── Permissions PUBLIC (sql/mssql_getpublicperm.sql) ─────────────────────────

if exists (SELECT * FROM master.sys.server_permissions
WHERE (grantee_principal_id = SUSER_SID(N'public') and state_desc LIKE 'GRANT%')
AND NOT (state_desc = 'GRANT' and [permission_name] = 'VIEW ANY DATABASE' and class_desc = 'SERVER')
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 2)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 3)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 4)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 5))
SELECT @@servername As servername, db_name() as dbname,SUSER_NAME(grantee_principal_id) as username,permission_name, state_desc FROM master.sys.server_permissions
WHERE (grantee_principal_id = SUSER_SID(N'public') and state_desc LIKE 'GRANT%')
AND NOT (state_desc = 'GRANT' and [permission_name] = 'VIEW ANY DATABASE' and class_desc = 'SERVER')
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 2)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 3)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 4)
AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and class_desc = 'ENDPOINT' and major_id = 5);
ELSE
SELECT @@Servername, DB_NAME(),'Public', 'OnlyDefaultPermission', 'OnlyDefaultPermission'
GO


-- ── Groupes Windows avec accès (sql/mssql_getgroups.sql) ─────────────────────

if exists (SELECT @@servername as Servername, pr.[name], pe.[permission_name], pe.[state_desc]
FROM sys.server_principals pr
JOIN sys.server_permissions pe
ON pr.principal_id = pe.grantee_principal_id
WHERE pr.name like 'BUILTIN%'
UNION
SELECT @@servername as Servername, pr.[name] AS LocalGroupName, pe.[permission_name], pe.[state_desc]
FROM sys.server_principals pr
JOIN sys.server_permissions pe
ON pr.[principal_id] = pe.[grantee_principal_id]
WHERE pr.[type_desc] = 'WINDOWS_GROUP'
AND pr.[name] like CAST(SERVERPROPERTY('MachineName') AS nvarchar) + '%')
SELECT @@servername as Servername, pr.[name], pe.[permission_name], pe.[state_desc]
FROM sys.server_principals pr
JOIN sys.server_permissions pe
ON pr.principal_id = pe.grantee_principal_id
WHERE pr.name like 'BUILTIN%'
UNION
SELECT @@servername as Servername, pr.[name] AS LocalGroupName, pe.[permission_name], pe.[state_desc]
FROM sys.server_principals pr
JOIN sys.server_permissions pe
ON pr.[principal_id] = pe.[grantee_principal_id]
WHERE pr.[type_desc] = 'WINDOWS_GROUP'
AND pr.[name] like CAST(SERVERPROPERTY('MachineName') AS nvarchar) + '%';
ELSE
SELECT @@SERVERNAME, 'NoGroup','NoPerm','NoState'
GO


-- ── Logins SQL avec accès sysadmin / CONTROL SERVER (sql/mssql_getlogins.sql)

SELECT @@servername, l.[name],l.principal_id,IS_SRVROLEMEMBER('sysadmin',name) as IsSysadmin,l.is_policy_checked, 'sysadmin membership' AS 'Access_Method',l.is_expiration_checked,l.is_disabled,l.create_date
FROM sys.sql_logins AS l
UNION ALL
SELECT @@Servername, l.[name],l.principal_id,IS_SRVROLEMEMBER('sysadmin',name) as IsSysadmin,l.is_policy_checked,'CONTROL SERVER' AS 'Access_Method',l.is_expiration_checked,l.is_disabled,l.create_date
FROM sys.sql_logins AS l
JOIN sys.server_permissions AS p
ON l.principal_id = p.grantee_principal_id
WHERE p.type = 'CL' AND p.state IN ('G', 'W')
GO


-- ── Niveau d'audit (sql/mssql_getauditlevel.sql) ─────────────────────────────

DECLARE @AuditLevel int
EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',
   N'Software\Microsoft\MSSQLServer\MSSQLServer',
   N'AuditLevel', @AuditLevel OUTPUT
SELECT @@Servername, CASE WHEN @AuditLevel = 0 THEN 'None'
   WHEN @AuditLevel = 1 THEN 'Successful'
   WHEN @AuditLevel = 2 THEN 'Failed'
   WHEN @AuditLevel = 3 THEN 'All'
   END AS [AuditLevel]
GO


-- ── Audit SQL Server — AUDIT_CHANGE_GROUP / FAILED_LOGIN_GROUP / SUCCESSFUL_LOGIN_GROUP
--    (sql/mssql_getsqlserveraudit.sql) ─────────────────────────────────────────

if exists (SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='CNAU')
SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='CNAU'
ELSE
SELECT @@SERVERNAME, 'NoAudit',0,'NONE','NONE',0,'AUDIT_CHANGE_GROUP',0

if exists (SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='LGFL')
SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='LGFL'
ELSE
SELECT @@SERVERNAME, 'NoAudit',0,'NONE','NONE',0,'FAILED_LOGIN_GROUP',0

if exists (SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='LGSD')
SELECT @@servername as servername,
S.name AS 'Audit Name'
, S.is_state_enabled AS 'Audit Enabled'
, S.type_desc AS 'Write Location'
, SA.name AS 'Audit Specification Name'
, SA.is_state_enabled as 'Audit Specification Enabled'
, SAD.audit_action_name
, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
JOIN sys.server_audit_specifications AS SA
ON SAD.server_specification_id = SA.server_specification_id
JOIN sys.server_audits AS S
ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id ='LGSD'
ELSE
SELECT @@SERVERNAME, 'NoAudit',0,'NONE','NONE',0,'SUCCESSFUL_LOGIN_GROUP',0
GO


-- ── Chiffrement (sql/mssql_getencryption.sql) ────────────────────────────────

-- Clés symétriques par base
DECLARE @command varchar(1000)
SELECT @command = 'USE [?] if exists (SELECT db_name() AS Database_Name, ''symmetric'',name AS Key_Name,algorithm_desc FROM sys.symmetric_keys WHERE db_id() > 4)
SELECT @@servername,db_name() AS Database_Name, ''symmetric'',name AS Key_Name,algorithm_desc FROM sys.symmetric_keys WHERE db_id() > 4
ELSE
SELECT @@Servername, DB_NAME(),''symmetric'',''NoSymKeyFound'', ''NotFound'' '
EXEC sp_MSforeachdb @command

-- Clés asymétriques par base
DECLARE @command2 varchar(1000)
SELECT @command2 = 'USE [?] if exists (SELECT db_name() AS Database_Name, ''asymmetric'',name AS Key_Name, key_length FROM sys.asymmetric_keys WHERE db_id() > 4)
SELECT @@servername,db_name() AS Database_Name, ''asymmetric'',name AS Key_Name, key_length FROM sys.asymmetric_keys WHERE db_id() > 4
ELSE
SELECT @@Servername, DB_NAME(),''asymmetric'',''NoAsymKeyFound'', ''NotFound'' '
EXEC sp_MSforeachdb @command2

-- TDE — bases chiffrées
SELECT @@servername,db.name,dm.encryptor_type,dm.key_algorithm,dm.key_length FROM sys.databases db LEFT OUTER JOIN sys.dm_database_encryption_keys dm ON db.database_id = dm.database_id where db.name not in ('master','tempdb','model','msdb') and db.is_encrypted=1;
GO
