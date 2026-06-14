EXEC sp_MSforeachdb
	'
	 SELECT 
	   @@SERVERNAME,
	   ''?'',
	   u.name,
	   CASE WHEN (r.principal_id IS NULL) THEN ''public'' ELSE r.name END GroupName,
	   l.name LoginName,
	   l.default_database_name,
	   u.default_schema_name,
	   u.principal_id,
	   u.sid
	 FROM [?].sys.database_principals u
	   LEFT JOIN ([?].sys.database_role_members m
	   JOIN [?].sys.database_principals r 
	   ON m.role_principal_id = r.principal_id)
	   ON m.member_principal_id = u.principal_id
	   LEFT JOIN [?].sys.server_principals l
	   ON u.sid = l.sid
	 WHERE u.TYPE <> ''R''
	   /*and u.name like ''tester''*/
	 order by u.name
	 '
