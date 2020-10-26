use master
go
DECLARE @TMP1 TABLE (
 [restore_history_id]	int
,[restore_date] datetime
,[destination_database_name] nvarchar(256)
,[user_name] nvarchar(256)
,[backup_set_id] int
,[restore_type]	char(1)
,[replace] bit	
,[recovery] bit
,[restart] bit
,[stop_at] datetime
,[device_count] tinyint
,[stop_at_mark_name] nvarchar(256)
,[stop_before] bit
,[restore_history_id_I] int
,[file_number]	numeric(10,0)
,[destination_phys_drive]	nvarchar(520)
,[destination_phys_name]	nvarchar(520)
,[Restored From] nvarchar(520))


INSERT INTO @TMP1
SELECT 
 h.[restore_history_id] 
,[restore_date] 
,[destination_database_name] 
,h.[user_name]
,h.[backup_set_id] 
,[restore_type]
,[replace] 
,[recovery]
,[restart] 
,[stop_at] 
,[device_count] 
,[stop_at_mark_name] 
,[stop_before] 
,r.[restore_history_id] [restore_history_id_I] 
,[file_number]	
,[destination_phys_drive]	
,[destination_phys_name]	
,bmf.physical_device_name AS [Restored From]
FROM msdb.dbo.restorehistory AS H 
INNER JOIN msdb.dbo.restorefile AS R ON H.restore_history_id = R.restore_history_id
INNER JOIN msdb.dbo.backupset bs ON H.backup_set_id = bs.backup_set_id
INNER JOIN msdb.dbo.backupmediafamily bmf ON bmf.media_set_id = bs.media_set_id
ORDER BY H.restore_history_id DESC


SELECT DISTINCT
 [restore_history_id]	
,[destination_database_name] 
,[restore_date] 
,[user_name] 
,[backup_set_id] 
,[restore_type]
,[replace] 	
,[recovery] 
,[restart] 
,[stop_at] 
,[device_count] 
,[stop_at_mark_name] 
,[stop_before] 
,[Restored From]
FROM @TMP1 TMP1
WHERE  TMP1.restore_history_id IN (SELECT Max(TMP2.restore_history_id) 
                                FROM @TMP1 TMP2
                                WHERE TMP1.destination_database_name = TMP2.destination_database_name
                                -- AND destination_database_name = 'DBMIRAAC_IMPORT'
                                GROUP BY TMP2.destination_database_name)
AND destination_database_name IN (select name as DBName 
                                 from sys.databases
                                 where name like '%MIRA%'
                                 and not(name like '%SST%')
                                 and not(name like '%GLOBAL%')
                                 and not(name in ('DBMIRA_ANALYSIS','DBMIRA_BI','DBMIRA_SUPORTE')))
                                                
ORDER BY [destination_database_name]                                 