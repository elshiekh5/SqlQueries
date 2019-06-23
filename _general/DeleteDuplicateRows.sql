WITH TempEmp (UserAccountID,duplicateRecCount)
AS
(
SELECT UserAccountID,ROW_NUMBER() OVER(PARTITION by IDNumber ORDER BY CreationDate) 
AS duplicateRecCount
FROM dbo.TempUserAccount tua
)
--Now Delete Duplicate Rows


Delete FROM dbo.TempUserNumber 
WHERE UserAccountID IN (SELECT UserAccountID FROM TempEmp WHERE duplicateRecCount > 1 )
