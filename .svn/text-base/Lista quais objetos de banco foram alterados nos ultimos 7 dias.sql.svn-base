SELECT * 
FROM sys.objects 
WHERE DATEDIFF(D,modify_date, GETDATE()) < 7
AND TYPE <> 'U' -- se não quiser as tabelas
AND name NOT LIKE '%AUDIT%'
-- AND -- se quiser identificar o tipo de objeto no caso 'P' Procedure