---------------------------------------------------------------------------------------
-- 
--CITC get pm charter request details by RequestNumber
---------------------------------------------------------------------------------------
Declare @RequestNumber nvarchar(50) ='408269'
---------------------------------------------------------------------------------------
declare @PKID BigInt 
declare @RequestId BigInt 
declare @ProcessInstanceID BigInt 
---------------------------------------------------------------------------------------
Select	@RequestId= RequestId ,@ProcessInstanceID = ProcessInstanceID From dbo.Request	 where RequestNumber = @RequestNumber
Select	@PKID = ProjectRequestID From pm.PM_ProjectRequest	 where RequestId =@RequestId
---------------------------------------------------------------------------------------

Select * From pm.PM_ProjectRequest	 where ProjectRequestID =@PKID
SELECT * FROM dbo.Request WHERE RequestID   = @RequestId 
SELECT * FROM dbo.RequestLog WHERE RequestID   = @RequestId 
SELECT * FROM dbo.Attachment WHERE RelatedEntityID   = @RequestId 
---------------------------------------------------------------------------------------
Select * from pm.PM_Objectives where ProjectRequestID =@PKID
Select * from pm.PM_ExpectedBenefits where ProjectRequestID =@PKID
Select * from pm.PM_Risks where ProjectRequestID =@PKID
Select * from pm.PM_ProjectStakeholders where ProjectRequestID =@PKID
Select * from pm.PM_BudgetDetails where ProjectRequestID =@PKID
---------------------------------------------------------------------------------------
Select 'RequestNumber	    : ' as [key], @RequestNumber as [value]
union 
Select 'RequestId	               : ',@RequestId
union 
Select 'ProcessInstanceID	 : ', @ProcessInstanceID
union 
Select 'PKID	                         : ', @PKID
---------------------------------------------------------------------------------------
Select * From pm.PM_ProjectRequest order by 1 desc
Select * from Request where RequestID = 1428681
-- update request to be ready as RFP
--------------------------------------

 update pm.PM_ProjectRequest 
 set   ProjectStatusID = 3,
		PMOStudier = isnull(PMOStudier, 'solayan.c')
  where ProjectRequestID = @PKID

 ---------------------------------------------------------------------------------------

 /*
Update pm.PM_ProjectRequest 
SET ProjectStatusID = 3
Update pm.PM_ProjectRequest 
SET
PMOStudier ='solayan.c'
Where PMOStudier is null

Update pm.PM_RFP_Request 
SET RFPStudier ='solayan.c'
Where RFPStudier is null*/