-- Source: OracleSchemas.php

SELECT *
FROM oracle_users
ORDER BY hostname, instance_name, pdb_name, username;
