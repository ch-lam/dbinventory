/*
** Create Monitoring user for Zabbix collector to be deployed in all mssql servers
** (it should be part of post deployment template after a new cdb/pdb, this script if for 
**  manual deployment only and documentation purposes).
*/

USE [master]
GO
CREATE LOGIN [monitoring] WITH PASSWORD='***************************', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [monitoring]
GO