-- SELECT * FROM INFORMATION_SCHEMA.VIEWS ORDER BY TABLE_NAME

USE master
GO
SELECT 
 qs.sql_handle
,qs.creation_time
,qs.last_execution_time
--,qp.dbid
,qs.execution_count
,qs.last_logical_reads
,qs.last_logical_writes
,qs.last_physical_reads
--,st.text
FROM sys.dm_exec_query_stats AS qs
-- CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle)AS st
-- CROSS APPLY sys.dm_exec_text_query_plan(qs.plan_handle,DEFAULT,DEFAULT)AS qp
--WHERE st.text like '%vw_CfcPdcAlnCru2016%'
--AND st.text not like 'SELECT qs.sql_handle,%'
ORDER BY qs.last_execution_time desc



--select top 100 * from vw_CfcPdcAlnCru2016
