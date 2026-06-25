-- Source: OracleDB.php

SELECT hostname, instance_name, db_version, db_name, database_type, count_pdb,
       db_log_mode, db_role, db_charset, db_edition, rac_state, db_unique_name,
       environment, license_type
FROM oracle_database_list
ORDER BY hostname, instance_name;
