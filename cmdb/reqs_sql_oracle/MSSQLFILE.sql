-- Source: MSSQLFILE.php
-- Oracle version (no changes required)

SELECT hostname, env, database_name, file_id, type_desc, name, physical_name,
       size_mb, growth_percent, growth_mb, max_size
FROM mssql_files
ORDER BY hostname, database_name;
