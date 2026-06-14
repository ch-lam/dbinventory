select @@SERVERNAME as instance_name, DB_Name(database_id) as database_name, file_id, type_desc, name, physical_name, (size)*8/1024 as size_mb
        ,case (is_percent_growth) WHEN 1 THEN growth ELSE 0 END  as growth_percent
        ,case (is_percent_growth) WHEN 0 THEN growth*8/1024 ELSE 0 END  as growth_mb
	,max_size
        from sys.master_files
        WHERE type in (0, 1)
