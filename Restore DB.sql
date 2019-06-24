-------------------------------------
--[Local Development] Prepare server to customer support
-------------------------------------
-------------------------------------
--Restore DB
USE [master]

DECLARE @AdministrativeDB_fileName VARCHAR(250)		= N'e:\work\_db\'+'AdministrativeDB.bak'


ALTER DATABASE [AdministrativeDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE

RESTORE DATABASE [AdministrativeDB] 
FROM  DISK = @AdministrativeDB_fileName WITH  FILE = 1, 
 KEEP_REPLICATION,  NOUNLOAD,  REPLACE,  STATS = 5

ALTER DATABASE [AdministrativeDB] SET MULTI_USER

GO

-------------------------------------