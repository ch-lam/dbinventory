SELECT @@servername, l.[name],l.principal_id,IS_SRVROLEMEMBER('sysadmin',name) as IsSysadmin,l.is_policy_checked, 'sysadmin membership' AS 'Access_Method',l.is_expiration_checked,l.is_disabled,l.create_date
FROM sys.sql_logins AS l
UNION ALL
SELECT @@Servername, l.[name],l.principal_id,IS_SRVROLEMEMBER('sysadmin',name) as IsSysadmin,l.is_policy_checked,'CONTROL SERVER' AS 'Access_Method',l.is_expiration_checked,l.is_disabled,l.create_date
FROM sys.sql_logins AS l
JOIN sys.server_permissions AS p
ON l.principal_id = p.grantee_principal_id
WHERE p.type = 'CL' AND p.state IN ('G', 'W')
