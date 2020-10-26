DECLARE
@NM_Obj VarChar(255)

SET @NM_Obj = '%'

DECLARE @Temp TABLE (
   Nome VarChar(255),
   TIPO VarChar(3),
   [SQL_AC] VarChar(max),
   [SQL_AL] VarChar(max),
   [SQL_AM] VarChar(max),
   [SQL_AP] VarChar(max),
   [SQL_DN] VarChar(max),
   [SQL_ES] VarChar(max),
   [SQL_MA] VarChar(max),
   [SQL_PA] VarChar(max),
   [SQL_PE] VarChar(max),
   [SQL_RN] VarChar(max),
   [SQL_RO] VarChar(max),
   [SQL_RR] VarChar(max),
   [SQL_TO] VarChar(max))
   
INSERT INTO @Temp
SELECT * 
 FROM (SELECT 
       --OBJECT_ID, 
       NAME, 
       type, 
        (SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAAC].SYS.OBJECTS O 
        INNER JOIN [DBMIRAAC].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAAC].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_AC]
          
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAAL].SYS.OBJECTS O 
        INNER JOIN [DBMIRAAL].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAAL].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_AL]
          
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAAM].SYS.OBJECTS O 
        INNER JOIN [DBMIRAAM].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAAM].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_AM]

       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAAP].SYS.OBJECTS O 
        INNER JOIN [DBMIRAAP].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAAP].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_AP]

       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRADN].SYS.OBJECTS O 
        INNER JOIN [DBMIRADN].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRADN].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_DN]

       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAES].SYS.OBJECTS O 
        INNER JOIN [DBMIRAES].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAES].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_ES]

       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAMA].SYS.OBJECTS O 
        INNER JOIN [DBMIRAMA].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAMA].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_MA]
        
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAPA].SYS.OBJECTS O 
        INNER JOIN [DBMIRAPA].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAPA].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_PA]
        
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRAPE].SYS.OBJECTS O 
        INNER JOIN [DBMIRAPE].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRAPE].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_PE]
        
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRARN].SYS.OBJECTS O 
        INNER JOIN [DBMIRARN].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRARN].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_RN]

       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRARO].SYS.OBJECTS O 
        INNER JOIN [DBMIRARO].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRARO].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_RO]
        
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRARR].SYS.OBJECTS O 
        INNER JOIN [DBMIRARR].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRARR].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_RR]
        
       ,(SELECT TOP 1
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(M.DEFINITION, ' ', ''),CHAR(13),''), CHAR(10), ''),'[dbo].',''),'dbo.',''),'[',''),']','')
        FROM [DBMIRATO].SYS.OBJECTS O 
        INNER JOIN [DBMIRATO].SYS.SQL_MODULES M ON O.OBJECT_ID = M.OBJECT_ID 
        INNER JOIN [DBMIRATO].SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
        WHERE O.name = o1.name) [SQL_TO]
        
        FROM [DBMIRAAC].SYS.OBJECTS o1
        WHERE O1.NAME NOT LIKE '%AUDIT%'
        AND O1.type in ('P', 'IF', 'FN', 'TF', 'VW') 
        AND O1.name like @NM_Obj
        ) T1

       ORDER BY 2

DECLARE @Temp2 TABLE (
   Nome VarChar(255),
   [SQL_AC] VarChar(max),
   [SQL_AL] VarChar(max),
   [SQL_AM] VarChar(max),
   [SQL_AP] VarChar(max),
   [SQL_DN] VarChar(max),
   [SQL_ES] VarChar(max),
   [SQL_MA] VarChar(max),
   [SQL_PA] VarChar(max),
   [SQL_PE] VarChar(max),
   [SQL_RN] VarChar(max),
   [SQL_RO] VarChar(max),
   [SQL_RR] VarChar(max),
   [SQL_TO] VarChar(max))

INSERT INTO @Temp2 
SELECT Nome,
       [SQL_AC],
       CASE WHEN [SQL_AC] <> [SQL_AL] THEN [SQL_AL] ELSE '' END [SQL_AL], 
       CASE WHEN [SQL_AC] <> [SQL_AM] THEN [SQL_AM] ELSE '' END [SQL_AM], 
       CASE WHEN [SQL_AC] <> [SQL_AP] THEN [SQL_AP] ELSE '' END [SQL_AP], 
       CASE WHEN [SQL_AC] <> [SQL_DN] THEN [SQL_DN] ELSE '' END [SQL_DN], 
       CASE WHEN [SQL_AC] <> [SQL_ES] THEN [SQL_ES] ELSE '' END [SQL_ES], 
       CASE WHEN [SQL_AC] <> [SQL_MA] THEN [SQL_MA] ELSE '' END [SQL_MA], 
       CASE WHEN [SQL_AC] <> [SQL_PA] THEN [SQL_PA] ELSE '' END [SQL_PA], 
       CASE WHEN [SQL_AC] <> [SQL_PE] THEN [SQL_PE] ELSE '' END [SQL_PE], 
       CASE WHEN [SQL_AC] <> [SQL_RN] THEN [SQL_RN] ELSE '' END [SQL_RN], 
       CASE WHEN [SQL_AC] <> [SQL_RO] THEN [SQL_RO] ELSE '' END [SQL_RO], 
       CASE WHEN [SQL_AC] <> [SQL_RR] THEN [SQL_RR] ELSE '' END [SQL_RR], 
       CASE WHEN [SQL_AC] <> [SQL_TO] THEN [SQL_TO] ELSE '' END [SQL_TO] 
FROM @Temp Temp

SELECT * 
FROM @Temp2 Temp
WHERE [SQL_AL] <> ''
 or [SQL_AM] <> ''
 or [SQL_AP] <> ''
 or [SQL_DN] <> ''
 or [SQL_ES] <> ''
 or [SQL_MA] <> ''
 or [SQL_PA] <> ''
 or [SQL_PE] <> ''
 or [SQL_RN] <> ''
 or [SQL_RO] <> ''
 or [SQL_RR] <> ''
 or [SQL_TO] <> ''