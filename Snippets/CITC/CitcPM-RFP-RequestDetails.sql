---------------------------------------------------------------------------------------
--CitcPM-RFP-RequestDetails
--CITC get pm RFP request details by RequestNumber
---------------------------------------------------------------------------------------
Declare @RequestNumber nvarchar(50) ='408448'
---------------------------------------------------------------------------------------
declare @PKID BigInt 
declare @RequestId BigInt 
declare @ProcessInstanceID BigInt 
---------------------------------------------------------------------------------------
Select	@RequestId= RequestId,@ProcessInstanceID = ProcessInstanceID From dbo.Request	 where RequestNumber = @RequestNumber
Select	@PKID = RFPRequestID From pm.PM_RFP_Request	 where RequestId =@RequestId
---------------------------------------------------------------------------------------

Select * From pm.PM_RFP_Request	 where RFPRequestID =@PKID
SELECT * FROM dbo.Request WHERE RequestID   = @RequestId 
SELECT * FROM dbo.RequestLog WHERE RequestID   = @RequestId 
SELECT * FROM dbo.Attachment WHERE RelatedEntityID   = @RequestId 
---------------------------------------------------------------------------------------
Select * from pm.RFP_Standards where RFPRequestID =@PKID
Select * from pm.RFP_Outputs where RFPRequestID =@PKID
Select * from pm.RFP_SelectedCompanies where RFPRequestID =@PKID
---------------------------------------------------------------------------------------
Select 'RequestNumber	    : ' as [key], @RequestNumber as [value]
union 
Select 'RequestId	               : ',@RequestId
union 
Select 'ProcessInstanceID	 : ', @ProcessInstanceID
union 
Select 'PKID	                         : ', @PKID
---------------------------------------------------------------------------------------


--SELECT ProjectStatusID FROM pm.PM_ProjectRequest

--update pm.PM_RFP_Request	 set RFPStatusID = 2 where  RFPRequestID =56
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







