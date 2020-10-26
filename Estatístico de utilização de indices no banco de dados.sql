SELECT
DB_NAME(database_id) As Banco, 
OBJECT_NAME(I.object_id) As Tabela, 
I.Name As Indice,
U.User_Seeks As Pesquisas, 
U.User_Scans As Varreduras, 
U.User_Lookups As LookUps,
U.Last_User_Seek As UltimaPesquisa, 
U.Last_User_Scan As UltimaVarredura,
U.Last_User_LookUp As UltimoLookUp, 
U.Last_User_Update As UltimaAtualizacao
FROM sys.indexes As I
LEFT OUTER JOIN sys.dm_db_index_usage_stats As U ON I.object_id = U.object_id AND I.index_id = U.index_id
--WHERE DB_NAME(database_id) = 'DBMIRARN'
--WHERE I.object_id = OBJECT_ID('TB_DcmLtoFnr')
WHERE I.object_id > 1000
AND OBJECT_NAME(I.object_id) LIKE 'TB_ArqAln'
--AND I.Name = 'ix_PsqApoNmrCar'
--AND DB_NAME(database_id) = 'DBMIRARO_IMPORT'
ORDER BY 
OBJECT_NAME(I.object_id) ,
I.Name 
--Pesquisas,
--Varreduras,
--LookUps


-- drop index IX_TB_ArqAlnY on TB_ArqAln