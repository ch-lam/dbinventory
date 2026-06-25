-- Source: MSSQLDB.php

SELECT hostname, env, database_name, database_state, recovery_model, compatibility_level, collation,
       last_backup_date, last_backup_diff_date, last_backup_log_date, is_mirroring_enabled,
       owner, agtype, agname
FROM mssql_database
ORDER BY hostname, database_id;
