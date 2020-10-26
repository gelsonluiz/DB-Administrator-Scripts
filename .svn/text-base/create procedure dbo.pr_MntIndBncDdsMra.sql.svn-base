-- script para manutenção dos indices mais usados.
create procedure dbo.pr_MntIndBncDdsMra
as
begin


declare
@script nvarchar(max),
@IndexName nvarchar(max),    
@tablename nvarchar(max),

@Banco nvarchar(max), 
@Tabela nvarchar(max), 
@Indice nvarchar(max),
@Pesquisas int,

@DC_AsnEniMngElr  varchar(6000),
@DC_CopTxtEniMngElr  varchar(6000),
@DC_CnaDttEniMngElr  varchar(200),

	
@caminho VARCHAR(255),
@Arquivo VARCHAR(255),
@retEcho INT,
@arqTexto VARCHAR(8000),
@Texto VARCHAR(8000),

@Qtd_Atl int

set @Banco =( SELECT top 1 specific_catalog  FROM INFORMATION_SCHEMA.ROUTINES ) -- 'DBMIRAES_FLAVIO'
set @Qtd_Atl = 0

-- pegar os indices mais usados.

declare Indices cursor
for
	SELECT
		
		OBJECT_NAME(I.object_id) As Tabela, 
		I.Name As Indice,
		U.User_Seeks As Pesquisas
	FROM sys.indexes As I
	LEFT OUTER JOIN sys.dm_db_index_usage_stats As U ON I.object_id = U.object_id AND I.index_id = U.index_id
	WHERE I.object_id > 1000
	and DB_NAME(database_id) = @Banco --
	and U.User_Seeks > 999
	AND OBJECT_NAME(I.object_id) LIKE 'TB_%'

OPEN Indices


FETCH NEXT FROM Indices into
	@Tabela , 
	@Indice ,
	@Pesquisas 

WHILE @@FETCH_STATUS = 0
BEGIN

	set @IndexName = @Indice -- 'IX_CD_DmdAco'
	set @tablename = @Tabela --  'TB_DmdAco'

	set @script ='ALTER INDEX '+@IndexName+' ON '+@tablename+' REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = OFF,STATISTICS_NORECOMPUTE = OFF)'
	
	-- print @script

	EXEC sp_executesql @script
	set @Qtd_Atl = @Qtd_Atl + 1

	FETCH NEXT FROM Indices into
		@Tabela , 
		@Indice ,
		@Pesquisas 	
	
end

set @Texto = @Banco+' - Atualizado ('+CAST(@Qtd_Atl as varchar(30))+').' 

close Indices
deallocate Indices



insert into TE_ManutencaoIndices (manutencao) values (@Texto)

end 