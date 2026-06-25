-- Source: MSSQLLogins.php

SELECT instance_name, LoginName, AccountCreationDate, LastTimeAccountModified, PasswordLastSetTime,
       DefaultDatabase, DefaultLanguage, IsDisabledChecked, IsPolicyChecked, IsExpirationChecked,
       IsExpired, DaysUntilExpiration, IsLocked, IsMustChange, LockoutTime, BadPasswordCount,
       BadPasswordTime, HistoryLength, LoginSid, LoginType, HasServerRole
FROM mssql_logins
ORDER BY instance_name, loginName;
