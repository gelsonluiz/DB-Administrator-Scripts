-- Remover Auditoria e Reduzir tamanho do banco

--use DBMIRARO_IMPORT
--go

exec sp_spaceused
exec sp_spaceused 'TB_AdrMra'
exec sp_spaceused 'TB_LogAcsFrm'
exec sp_spaceused 'TB_MngAdsUsrMra'
Truncate table TB_AdrMra
Truncate table TB_LogAcsFrm
Truncate table TB_MngAdsUsrMra
DBCC SHRINKDATABASE (DBMIRAMS_GELSON, 10);
exec sp_spaceused

