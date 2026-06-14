EXEC sp_MSforeachdb 'USE [?] If exists
(SELECT @@servername, db_name(), name
FROM sys.database_principals
WHERE sid NOT IN (SELECT sid FROM sys.server_principals)
    AND type = ''S''
    AND principal_id != 2
    AND DATALENGTH(sid) <= 28 
    AND name <>''MS_DataCollectorInternalUser'')
SELECT @@servername, db_name(), name
FROM sys.database_principals
WHERE sid NOT IN (
        SELECT sid
        FROM sys.server_principals
        )
    AND type = ''S''
    AND principal_id != 2
    AND DATALENGTH(sid) <= 28
    AND name <>''MS_DataCollectorInternalUser''
ELSE SELECT @@Servername, db_name(), ''NoOrphanedUser'''
