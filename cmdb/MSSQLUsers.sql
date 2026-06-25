-- Source: MSSQLUsers.php

SELECT instance_name, database_name, name, groupname, loginname,
       defaultdbname, defaultschemaname, principalid, sid
FROM mssql_users
ORDER BY instance_name, database_name;
