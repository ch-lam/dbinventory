-- Source: MSSQLLoginWoPerm.php
-- Oracle version (no changes required)

SELECT instance_name, loginname, type_desc, is_disabled, db_perms, srv_perms, modify_date, scandate
FROM mssql_loginwoperm
WHERE loginname <> 'NT SERVICE/ClusSvc'
ORDER BY instance_name, loginname;
