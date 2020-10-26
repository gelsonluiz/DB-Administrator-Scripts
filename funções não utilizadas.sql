SELECT	
   object_name(m.object_id) AS Nome_Procedure,
	MAX(qs.last_execution_time) AS Ultima_Execucao,
	execution_count,
	db_name(st.dbid) AS 'Database Name'
FROM	sys.sql_modules m
	LEFT JOIN (sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_sql_text (qs.sql_handle) st) ON m.object_id = st.objectid
    AND st.dbid = db_id()
GROUP  BY object_name(m.object_id), execution_count,db_name(st.dbid)  ;


