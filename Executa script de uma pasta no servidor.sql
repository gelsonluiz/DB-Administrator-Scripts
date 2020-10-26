-- Script to Build Procedures, Tables, etc in mi
CREATE TABLE ##SQLFiles ( SQLFileName VARCHAR(2000))
GO

INSERT INTO ##SQLFiles
EXECUTE master.dbo.xp_cmdshell 'dir /b C:\TempSQL\IntMiraMXM\*.sql'
GO

select * from ##SQLFiles
--DROP TABLE ##SQLFiles

DECLARE cFiles CURSOR LOCAL FOR
    SELECT DISTINCT [SQLFileName]
    FROM ##SQLFiles
    WHERE [SQLFileName] IS NOT NULL AND
          [SQLFileName] != 'NULL'
    ORDER BY [SQLFileName]

DECLARE @NM_BANCO     VarChar(255) = DB_NAME()
DECLARE @vFileName    VARCHAR(200)
DECLARE @vSQLStmt     VARCHAR(4000)
DECLARE @OutPutFolder VARCHAR(4000) = 'C:\TempSQL\OutPut';
DECLARE @inputFolder  VARCHAR(4000) = 'C:\TempSQL\IntMiraMXM';

OPEN cFiles
FETCH NEXT FROM cFiles INTO @vFileName
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @vSQLStmt = 'master.dbo.xp_cmdshell ''osql -S 200.189.102.131 -E -d '+@NM_BANCO+' -i "' + @inputFolder + '\'+ @vFileName + '" -o "' + @OutPutFolder +'\Folder\' + @vFileName +'_output.txt"'''
    EXECUTE (@vSQLStmt)
--	 Print @vSQLStmt

    FETCH NEXT FROM cFiles INTO @vFileName
END

CLOSE cFiles
DEALLOCATE cFiles
GO

DROP TABLE ##SQLFiles
GO