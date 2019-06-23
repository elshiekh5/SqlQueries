/*Index usage stats
Next, let's take a look at index usage stats, so we can see how much actual activity is currently running against our candidate tables (and, particularly, updates).
*/
SELECT [object_id], index_id, user_seeks, user_scans, user_lookups, user_updates 
INTO #indexusage
FROM sys.dm_db_index_usage_stats AS s
WHERE database_id = DB_ID()
AND EXISTS (SELECT 1 FROM #candidates WHERE [object_id] = s.[object_id]);