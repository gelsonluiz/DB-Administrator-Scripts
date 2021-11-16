-- Remover Auditoria e Reduzir tamanho do banco

--use DBMIRARO_IMPORT
--go

exec sp_spaceused
exec sp_spaceused 'producao.ArquivoDeProducaoRemoto0920'
exec sp_spaceused 'producao.HistoricoDeEnvioDaProducaoInteracao'
exec sp_spaceused 'producao.ArquivoDeProducao'
Truncate table producao.ArquivoDeProducaoRemoto0920
DBCC SHRINKDATABASE (SENAC_SIG, 10);
exec sp_spaceused

