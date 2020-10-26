WITH PsaFsc AS
(
    SELECT *,
    indice = ROW_NUMBER() OVER (ORDER BY NM_CmtPsaFsc) 
    FROM TB_PsaFsc
)
SELECT *
FROM PsaFsc
WHERE indice BETWEEN 1 AND 100
ORDER BY NM_CmtPsaFsc
