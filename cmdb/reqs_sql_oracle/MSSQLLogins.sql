-- Source: MSSQLLogins.php
-- Oracle version (column names are case-insensitive in Oracle; aliases preserved for PHP compatibility)

SELECT instance_name, loginname AS LoginName, accountcreationdate AS AccountCreationDate,
       lasttimeaccountmodified AS LastTimeAccountModified, passwordlastsettime AS PasswordLastSetTime,
       defaultdatabase AS DefaultDatabase, defaultlanguage AS DefaultLanguage,
       isdisabledchecked AS IsDisabledChecked, ispolicychecked AS IsPolicyChecked,
       isexpirationchecked AS IsExpirationChecked, isexpired AS IsExpired,
       daysuntilexpiration AS DaysUntilExpiration, islocked AS IsLocked,
       ismustchange AS IsMustChange, lockouttime AS LockoutTime,
       badpasswordcount AS BadPasswordCount, badpasswordtime AS BadPasswordTime,
       historylength AS HistoryLength, loginsid AS LoginSid,
       logintype AS LoginType, hasserverrole AS HasServerRole
FROM mssql_logins
ORDER BY instance_name, loginname;
