/*
   menu
   06: ITEM DE CUSTEIO
      AC_GrpItmCst
      AC_CtgAgrItmCst
      AC_UndMdd
      AC_ItmCst
      AC_CtcItmCst

   TB_UndMdd
   TB_ItmCst 
   TB_GrpItmCst
   TB_CvrUndMdd 
   TB_UndMddPmtItmCst 
   TB_FcaTcn 
   TB_ItmCstFcaTcn 
*/

/*   
USE DBMIRA

SELECT *
FROM TB_GrpItmCst
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT *
FROM TB_UndMdd
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT TB_ItmCst.* 
FROM TB_ItmCst 
WHERE ID_StcItmCst = 1
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT *
FROM TB_CvrUndMdd
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT TB_UndMddPmtItmCst.*
FROM TB_UndMddPmtItmCst
INNER JOIN TB_ItmCst ON TB_UndMddPmtItmCst.CD_ItmCst = TB_ItmCst.CD_ItmCst
WHERE ID_StcItmCst = 1
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT *
FROM TB_FcaTcn
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT TB_ItmCstFcaTcn.*
FROM TB_ItmCstFcaTcn
INNER JOIN TB_ItmCst ON TB_ItmCstFcaTcn.CD_ItmCst = TB_ItmCst.CD_ItmCst
WHERE ID_StcItmCst = 0
FOR XML RAW, ROOT('Table') -- nó raiz


SELECT TB_ItmCstFcaTcn.* 
FROM TB_ItmCstFcaTcn
INNER JOIN TB_ItmCst ON TB_ItmCstFcaTcn.CD_ItmCst = TB_ItmCst.CD_ItmCst
WHERE ID_StcItmCst = 1
FOR XML RAW, ROOT('Table') -- nó raiz

SELECT TB_CtcItmCst.*
FROM TB_CtcItmCst
INNER JOIN TB_ItmCst ON TB_CtcItmCst.CD_ItmCst = TB_ItmCst.CD_ItmCst
WHERE ID_StcItmCst = 1
AND DT_CtcItmCst > '2015-05-01'
FOR XML RAW, ROOT('Table') -- nó raiz
*/

/*
   
    
   
    
    
    
    
*/   

DECLARE 
@idoc int, 
@doc xml 

--##
SET @doc = (SELECT CAST(BulkColumn AS XML)
            FROM OPENROWSET(BULK N'C:\TempSQL\TB_ItmCstFcaTcn.xml', SINGLE_BLOB)
            AS Arquivo) 

EXEC sp_xml_preparedocument @idoc OUTPUT, @doc 

--##
DELETE TB_ItmCstFcaTcn

--##
INSERT INTO TB_ItmCstFcaTcn
--##
SELECT * FROM OPENXML (@idoc, '/Table/row',0)  with TB_ItmCstFcaTcn
 
EXEC sp_xml_removedocument @idoc