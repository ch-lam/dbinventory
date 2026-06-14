SELECT @@SERVERNAME as instance_name, sp.[name] as LoginName, sp.create_date AS AccountCreateDate,
sp.modify_date AS LastTimeAccountModified,
LOGINPROPERTY( sp.[name], 'PasswordLastSetTime' ) AS PasswordLastSetTime,
sp.default_database_name as DefaultDatabase,
sp.default_language_name as DefaultLanguage,
sp.is_disabled as IsDisabledChecked,
sl.is_policy_checked as IsPolicyChecked,
sl.is_expiration_checked as IsExpirationChecked,
LOGINPROPERTY( sp.[name], 'IsExpired' ) AS IsExpired,
LOGINPROPERTY (sp.[name], 'DaysUntilExpiration' ) AS DaysUntilExpiration,
LOGINPROPERTY( sp.[name], 'IsLocked' ) AS IsLocked,
LOGINPROPERTY( sp.[name], 'IsMustChange' ) AS IsMustChange,
LOGINPROPERTY( sp.[name], 'LockoutTime' ) AS LockoutTime,
LOGINPROPERTY( sp.[name], 'BadPasswordCount' ) AS BadPasswordCount,
LOGINPROPERTY( sp.[name], 'BadPasswordTime' ) AS BadPasswordTime,
LOGINPROPERTY( sp.[name], 'HistoryLength' ) AS HistoryLength,
sp.sid, sp.type,
CASE WHEN sysadmin = 1 THEN 'sysadmin'
WHEN securityadmin=1 THEN 'securityadmin'
WHEN serveradmin=1 THEN 'serveradmin'
WHEN setupadmin=1 THEN 'setupadmin'
WHEN processadmin=1 THEN 'processadmin'
WHEN diskadmin=1 THEN 'diskadmin'
WHEN dbcreator=1 THEN 'dbcreator'
WHEN bulkadmin=1 THEN 'bulkadmin'
ELSE 'Public' END AS 'ServerRole'
FROM sys.server_principals sp
Join syslogins sysl on sysl.loginname=sp.name
LEFT OUTER JOIN sys.sql_logins sl on sl.sid = sp.sid
WHERE sp.type not in ('C', 'R')
