SELECT 
tb.NAME [Tabela],
COUNT(cl.NAME) [Colunas]
FROM SYSOBJECTS AS tb, 
SYSCOLUMNS AS cl, 
SYSTYPES AS tp 
WHERE tb.ID = cl.ID 
AND cl.USERTYPE = tp.USERTYPE 
AND tb.NAME like 'tb_%' 
GROUP BY tb.name