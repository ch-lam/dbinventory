DECLARE @command varchar(1000) 
SELECT @command = 'USE [?] if exists (SELECT db_name() AS Database_Name, ''symmetric'',name AS Key_Name,algorithm_desc FROM sys.symmetric_keys WHERE db_id() > 4)
SELECT @@servername,db_name() AS Database_Name, ''symmetric'',name AS Key_Name,algorithm_desc FROM sys.symmetric_keys WHERE db_id() > 4
ELSE 
SELECT @@Servername, DB_NAME(),''symmetric'',''NoSymKeyFound'', ''NotFound'' '
EXEC sp_MSforeachdb @command

DECLARE @command2 varchar(1000) 
SELECT @command2 = 'USE [?] if exists (SELECT db_name() AS Database_Name, ''asymmetric'',name AS Key_Name, key_length FROM sys.asymmetric_keys WHERE db_id() > 4)
SELECT @@servername,db_name() AS Database_Name, ''asymmetric'',name AS Key_Name, key_length FROM sys.asymmetric_keys WHERE db_id() > 4
ELSE 
SELECT @@Servername, DB_NAME(),''asymmetric'',''NoAsymKeyFound'', ''NotFound'' '
EXEC sp_MSforeachdb @command2

SELECT @@servername,db.name,dm.encryptor_type,dm.key_algorithm,dm.key_length FROM sys.databases db LEFT OUTER JOIN sys.dm_database_encryption_keys dm ON db.database_id = dm.database_id where db.name not in ('master','tempdb','model','msdb') and db.is_encrypted=1;
