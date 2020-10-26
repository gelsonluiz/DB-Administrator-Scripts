WITH PsaFsc AS
(
    SELECT *,
    indice = ROW_NUMBER() OVER (ORDER BY CD_PsaFsc) 
    FROM TB_PsaFsc
)
SELECT *
FROM TB_PsaFsc
INNER JOIN PsaFsc ON TB_PsaFsc.CD_PsaFsc = PsaFsc.CD_PsaFsc
WHERE indice BETWEEN 1 AND 100
ORDER BY TB_PsaFsc.CD_PsaFsc
