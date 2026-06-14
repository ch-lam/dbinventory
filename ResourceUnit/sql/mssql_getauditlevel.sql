DECLARE @AuditLevel int
EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', 
   N'Software\Microsoft\MSSQLServer\MSSQLServer', 
   N'AuditLevel', @AuditLevel OUTPUT
SELECT @@Servername, CASE WHEN @AuditLevel = 0 THEN 'None'
   WHEN @AuditLevel = 1 THEN 'Successful'
   WHEN @AuditLevel = 2 THEN 'Failed'
   WHEN @AuditLevel = 3 THEN 'All' 
   END AS [AuditLevel] 
