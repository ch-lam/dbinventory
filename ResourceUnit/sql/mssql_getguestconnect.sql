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
