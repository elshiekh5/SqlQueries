--The first step is a simple query to retrieve the last executed step for each job from sysjobactivity table. 
--The query will be like this:
select job_id,last_executed_step_id
 from msdb.dbo.sysjobactivity
 where last_executed_step_id is not null
 
 ---------------------------------------------------------------------------
/*
 For each job we retrieved with the query above, we need to retrieve the records about 
 the steps of the job from sysjobhistory table. We can do this using Cross Apply 
 in the query and using the field last_executed_step_id as a parameter for the Top expression
 in the query. The query to retrieve the details of the last execution of each job will be like this:
*/
with qry as
(select job_id,last_executed_step_id
 from msdb.dbo.sysjobactivity
 where last_executed_step_id is not null)
select 
   job_name, run_status,
   run_date, run_time,
   run_duration, step_name, message
 from qry
cross apply
(select top (qry.last_executed_step_id + 1)
        sysjobs.name as job_name,
        sysjobhistory.run_status,
        run_date, run_time,
        run_duration, step_name,
        message, step_id
             FROM   msdb.dbo.sysjobhistory
             INNER JOIN msdb.dbo.sysjobs
               ON msdb.dbo.sysjobhistory.job_id = msdb.dbo.sysjobs.job_id
    where msdb.dbo.sysjobs.job_id=qry.job_id
order by run_date desc,run_time desc) t
order by job_name,step_id
---------------------------------------------------------------------------
--run_date:

convert(date,convert(varchar,run_date)) run_date

---------------------------------------------------------------------------
--run_time:

      Isnull(Substring(CONVERT(VARCHAR, run_time + 1000000), 2, 2) + ':' +
         Substring(CONVERT(VARCHAR, run_time + 1000000), 4, 2)
       + ':' +
         Substring(CONVERT(VARCHAR, run_time + 1000000), 6, 2), '') as run_time
		 
---------------------------------------------------------------------------
--run_status:

             CASE sysjobhistory.run_status
               WHEN 0 THEN 'Failed'
               WHEN 1 THEN 'Succeeded'
               WHEN 2 THEN 'Retry'
           WHEN 3 THEN 'Cancelled'
             END
             AS
             run_status
			 
---------------------------------------------------------------------------
/*
To make the use of this query easier, we can filter the result for only the failed executions and create a view for this query. The view will be like this:
*/
Create View LastFailedJobs as
with qry as
(select job_id,last_executed_step_id
 from msdb.dbo.sysjobactivity
 where last_executed_step_id is not null)
select 
   job_name, 
   CASE run_status
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Cancelled'
    END
    AS
    run_status,
   convert(date,convert(varchar,run_date)) run_date, 
    Isnull(Substring(CONVERT(VARCHAR, run_time + 1000000), 2, 2) + ':' +
                Substring(CONVERT(VARCHAR, run_time + 1000000), 4, 2)
        + ':' +
        Substring(CONVERT(VARCHAR, run_time + 1000000), 6, 2), '') as run_time,
   run_duration, step_name, message
 from qry
cross apply
(select top (qry.last_executed_step_id + 1)
        sysjobs.name as job_name,
        sysjobhistory.run_status,
        run_date, run_time,
        run_duration, step_name,
        message, step_id
             FROM   msdb.dbo.sysjobhistory
             INNER JOIN msdb.dbo.sysjobs
               ON msdb.dbo.sysjobhistory.job_id = msdb.dbo.sysjobs.job_id
    where msdb.dbo.sysjobs.job_id=qry.job_id
order by run_date desc,run_time desc) t
where run_status<>1
order by job_name,step_id
------------------------------------------------------------------------------
/*
Memory Use

Does our SQL Server has enough memory or our server is under memory pressure?

We need to check the buffer cache to identify if we have a good amount of cache hits and there isn’t memory pressure.

We can do this by checking performance counters. Three good performance counters to check are:

Page Life Expectancy: It’s Lifetime of the pages in the cache. The recommended value is over 300 sec.
Free List Stalls/sec: The number of requests that have to wait for a free page. If this value is high, your server is under memory pressure.
Page Reads/sec: If this counter has a high value this will confirm the memory pressure already highlighted by two counters
The query to retrieve these values will be like this:


*/

SELECT object_name, counter_name, cntr_value
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE '%Buffer Manager%'
AND [counter_name] in ('Page life expectancy','Free list stalls/sec',
'Page reads/sec')