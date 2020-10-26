-- Converter datas
Convert(varchar(10), TB_TrmOrg.DT_IncDiaLtvTrmOrg, 103) [Data Inicio],
Convert(varchar(10), TB_TrmOrg.DT_TroDiaLtvTrmOrg, 103) [Data Termino],

-- Retora último dia do mês
select dateadd(day, -1, dateadd(month,1,'2014-02-01'))

-- Funções de datas
DECLARE
@DataInc Datetime,
@DataTro Datetime

SET @DataInc = '2013-09-26 01:23:45.678'
SET @DataTro = '2013-09-26 02:34:56.789'

SELECT 
 ElapsedSecs=DATEDIFF(second, Min(@DataInc), MAX(@DataTro))
,ElapsedTime=CAST(DATEADD(second, DATEDIFF(second, Min(@DataInc), MAX(@DataTro)), 0) AS TIME)


-- Primeiro e Ultimo dia do mês/ano
set @DT_AnoIni =  CAST(CAST(@NR_AnoRfrArqCru AS VarChar(4))+'-'+ CAST(@NR_MesRfrArqCru AS VarChar(2))+'-01' AS SmallDatetime)
set @DT_AnoFin =  DateAdd(year, 1, @DT_AnoIni) -1