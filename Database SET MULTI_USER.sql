--==================================================================--
-- Database SET MULTI_USER
--==================================================================--

/*
KILL [spid number here]

GO

SET DEADLOCK_PRIORITY HIGH

GO
*/
ALTER DATABASE CITC_Complaints SET MULTI_USER WITH ROLLBACK IMMEDIATE

GO
--==================================================================--