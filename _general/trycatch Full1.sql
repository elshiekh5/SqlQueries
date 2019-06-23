BEGIN TRY

BEGIN TRANSACTION

PRINT 'do work'

COMMIT

END TRY
BEGIN CATCH

DECLARE @errMsg VARCHAR(500) = ERROR_MESSAGE()
, @errState INT = ERROR_STATE()
, @errSeverity int = ERROR_SEVERITY()

INSERT INTO dbo.Failures (errorMsg)
VALUES (@errMsg)

RAISERROR(@errMsg, @errSeverity, @errState);

END CATCH