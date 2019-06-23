--Here is the script which can help you find “What are various resource bottlenecks?”

-- SQL Wait Stats and Queies
-- (C) Pinal Dave https://blog.sqlauthority.com/ ) 2016
-- Send query result to pinal@sqlauthority.com for quick feedback
SELECT  wait_type AS Wait_Type, 
wait_time_ms / 1000.0 AS Wait_Time_Seconds,
waiting_tasks_count AS Waiting_Tasks_Count,
-- CAST((wait_time_ms / 1000.0)/waiting_tasks_count AS decimal(10,4)) AS AVG_Waiting_Tasks_Count,
wait_time_ms * 100.0 / SUM(wait_time_ms) OVER() AS Percentage_WaitTime
--,waiting_tasks_count * 100.0 / SUM(waiting_tasks_count) OVER() AS Percentage_Count
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN
(N'BROKER_EVENTHANDLER',
N'BROKER_RECEIVE_WAITFOR',
N'BROKER_TASK_STOP',
N'BROKER_TO_FLUSH',
N'BROKER_TRANSMITTER',
N'CHECKPOINT_QUEUE',
N'CHKPT',
N'CLR_AUTO_EVENT',
N'CLR_MANUAL_EVENT',
N'CLR_SEMAPHORE',
N'DBMIRROR_DBM_EVENT',
N'DBMIRROR_DBM_MUTEX',
N'DBMIRROR_EVENTS_QUEUE',
N'DBMIRROR_WORKER_QUEUE',
N'DBMIRRORING_CMD',
N'DIRTY_PAGE_POLL',
N'DISPATCHER_QUEUE_SEMAPHORE',
N'EXECSYNC',
N'FSAGENT',
N'FT_IFTS_SCHEDULER_IDLE_WAIT',
N'FT_IFTSHC_MUTEX',
N'HADR_CLUSAPI_CALL',
N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
N'HADR_LOGCAPTURE_WAIT',
N'HADR_NOTIFICATION_DEQUEUE',
N'HADR_TIMER_TASK',
N'HADR_WORK_QUEUE',
N'LAZYWRITER_SLEEP',
N'LOGMGR_QUEUE',
N'MEMORY_ALLOCATION_EXT',
N'ONDEMAND_TASK_QUEUE',
N'PREEMPTIVE_HADR_LEASE_MECHANISM',
N'PREEMPTIVE_OS_AUTHENTICATIONOPS',
N'PREEMPTIVE_OS_AUTHORIZATIONOPS',
N'PREEMPTIVE_OS_COMOPS',
N'PREEMPTIVE_OS_CREATEFILE',
N'PREEMPTIVE_OS_CRYPTOPS',
N'PREEMPTIVE_OS_DEVICEOPS',
N'PREEMPTIVE_OS_FILEOPS',
N'PREEMPTIVE_OS_GENERICOPS',
N'PREEMPTIVE_OS_LIBRARYOPS',
N'PREEMPTIVE_OS_PIPEOPS',
N'PREEMPTIVE_OS_QUERYREGISTRY',
N'PREEMPTIVE_OS_VERIFYTRUST',
N'PREEMPTIVE_OS_WAITFORSINGLEOBJECT',
N'PREEMPTIVE_OS_WRITEFILEGATHER',
N'PREEMPTIVE_SP_SERVER_DIAGNOSTICS',
N'PREEMPTIVE_XE_GETTARGETSTATE',
N'PWAIT_ALL_COMPONENTS_INITIALIZED',
N'PWAIT_DIRECTLOGCONSUMER_GETNEXT',
N'QDS_ASYNC_QUEUE',
N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP',
N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
N'QDS_SHUTDOWN_QUEUE',
N'REDO_THREAD_PENDING_WORK',
N'REQUEST_FOR_DEADLOCK_SEARCH',
N'RESOURCE_QUEUE',
N'SERVER_IDLE_CHECK',
N'SLEEP_BPOOL_FLUSH',
N'SLEEP_DBSTARTUP', 
N'SLEEP_DCOMSTARTUP',
N'SLEEP_MASTERDBREADY', 
N'SLEEP_MASTERMDREADY',
N'SLEEP_MASTERUPGRADED', 
N'SLEEP_MSDBSTARTUP',
N'SLEEP_SYSTEMTASK', 
N'SLEEP_TASK',
N'SP_SERVER_DIAGNOSTICS_SLEEP',
N'SQLTRACE_BUFFER_FLUSH',
N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
N'SQLTRACE_WAIT_ENTRIES',
N'UCS_SESSION_REGISTRATION',
N'WAIT_FOR_RESULTS',
N'WAIT_XTP_CKPT_CLOSE',
N'WAIT_XTP_HOST_WAIT',
N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG',
N'WAIT_XTP_RECOVERY',
N'WAITFOR',
N'WAITFOR_TASKSHUTDOWN',
N'XE_TIMER_EVENT',
N'XE_DISPATCHER_WAIT'
) AND wait_time_ms >= 1
ORDER BY Wait_Time_Seconds DESC
-- ORDER BY Waiting_Tasks_Count DESC