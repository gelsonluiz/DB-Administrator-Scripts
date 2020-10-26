/*
   Retirado de: https://www.simple-talk.com/sql/database-administration/5-monitoring-queries-for-sql-server/ 
*/

SELECT TOP 100
  ROUND(s.avg_total_user_cost * s.avg_user_impact * (s.user_seeks + s.user_scans),0) AS [Total Cost]
 ,d.[statement] AS [Table Name]
 ,equality_columns
 ,inequality_columns
 ,included_columns
 ,last_user_seek
 ,avg_user_impact
 ,avg_total_user_cost
 -- ,*
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
  ON s.group_handle = g.index_group_handle
INNER JOIN sys.dm_db_missing_index_details d
  ON d.index_handle = g.index_handle
--WHERE database_id = 8
ORDER BY [Total Cost]  DESC -- , last_system_seek DESC

/*
--DROP INDEX ixw_TB_AlnFrqIsc_II ON [dbo].[TB_AlnFrqIsc] 
--GO
CREATE NONCLUSTERED INDEX ixw_TB_AlnFrqIsc_I
     ON [dbo].[TB_AlnFrqIsc] ([CD_CdgFrqHraAla], [NR_Mtr])
     INCLUDE ([QT_PrnFrqCle], [CD_FrqCle]);
GO

--DROP INDEX ixw_TB_AlnFrqIsc_II ON [dbo].[TB_AlnFrqIsc] 
--GO
CREATE NONCLUSTERED INDEX ixw_TB_AlnFrqIsc_II
     ON [dbo].[TB_AlnFrqIsc] ([CD_CdgFrqHraAla], [NR_Mtr])
     INCLUDE ([QT_FltFrqCle], [CD_FrqCle]);
GO

--DROP INDEX ixw_TB_AlnFrqIsc_III ON [dbo].[TB_AlnFrqIsc]
--GO
CREATE NONCLUSTERED INDEX ixw_TB_AlnFrqIsc_III
     ON [dbo].[TB_AlnFrqIsc] ([CD_FrqCle])
     INCLUDE ([CD_AlnFrqIsc], [CD_CdgFrqHraAla], [CD_TmpHraAla], [QT_PrnFrqCle], [QT_FltFrqCle], [NR_Mtr], [DT_AnoMtr], [CD_UndOprMtr]);

GO
CREATE NONCLUSTERED INDEX ixw_TB_CndMnr_I
     ON [dbo].[TB_CndMnr] ([CD_DiaLtv])
GO
CREATE NONCLUSTERED INDEX ixw_TB_CndMnr_II
     ON [dbo].[TB_CndMnr] ([CD_BlcTmtOrg])
GO

CREATE NONCLUSTERED INDEX ixw_TB_GrpMtrDiaLtv_I
   ON [dbo].[TB_GrpMtrDiaLtv] ([CD_DiaLtv])
go

CREATE NONCLUSTERED INDEX ixw_TB_OpoFnaCmlAdtCnl_I
   ON [dbo].[TB_OpoFnaCmlAdtCnl]  ([NR_Ctn], [DT_AnoCtn], [CD_UndOprCtn])
   
   
CREATE NONCLUSTERED INDEX ixw_TB_LogArqIgnMraMxm_I
   ON [dbo].[TB_LogArqIgnMraMxm] ([CD_AgmGrcArqIgn])
   INCLUDE ([DC_NmeLogArqIgnMraMxm])
*/


