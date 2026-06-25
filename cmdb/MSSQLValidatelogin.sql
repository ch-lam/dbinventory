-- Source: MSSQLValidatelogin.php

SELECT servername, sid, login, is_disabled, modify_date, scandate
FROM mssql_validatelogin
ORDER BY servername;
