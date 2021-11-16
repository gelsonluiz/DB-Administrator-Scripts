DECLARE
@Campo VarChar(255)
--
SET @Campo = '%CentroDeCusto%'
-- 
-- FUNÇÕES E PROCEDURES
SELECT 
O.NAME
FROM sysobjects O, syscomments s
WHERE O.ID=S.ID 
--AND S.[text] 
AND TEXT LIKE @Campo
UNION
-- TABELAS
select 
a.name
from sys.tables a 
inner join sys.columns b on a.object_id = b.object_id
where b.name LIKE @Campo
ORDER BY 1


select top 100 * from planodecurso.Titulo t where CentroDeCusto is not null