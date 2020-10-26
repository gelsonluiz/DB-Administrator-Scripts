/*
Name: SearchForString
Author: Wes Henriksen
What this Script Does: 

* Iterate through every text based column of every table of every schema in a database
* The message tab provides useful progress updates while the script is running
* Identifies which columns contain the specified string with a count of rows containing the string
* Change the grouping in the last select statement to see the full data.


How to Use this Script:
1. Configure search variables, see specific instructions with the variables
2. Run the script.
3. The results are stored in temporary table #Results.  You can query this table from within the same session to further refine your results or remove the GROUP BY to see detailed data.


WARNING -- READ BEFORE RUNNING THIS SCRIPT!

* Since this script can iterate through every table and column of a database, it may take a VERY long time to process. 
* Run your initial tests on a single table or column to see how your system handles the load.

*/
DECLARE @MaxRows INT;
DECLARE @MinRows INT;
DECLARE @FilterSchema NVARCHAR(255);
DECLARE @FilterTable NVARCHAR(255);
DECLARE @FilterColumn NVARCHAR(255);
DECLARE @Characters NVARCHAR(MAX);

--Filter the tables by a minimum and maximum number of rows, use this to target data tables or lookup tables
--	a. MinRows = 0 to search all tables, 1 to search any tables containing data.
--	b. MaxRows = null to search all tables, > 0 to search tables containing fewer rows than this number.
SET @MaxRows = 1000;
SET @MinRows = 1;

--Configure any schema, table or column name filters in the variables section.  
--	Names are compared using Like %Name%
SET @FilterSchema = NULL;
SET @FilterTable = NULL;
SET @Filtercolumn = NULL;

--Input the text you want to search for.  The search term will be searched as a whole, and will not look for individual occurrences of
--	multiple words in one search term.
SET @Characters = 'SAÚDE'

--******Script begins.  do not change anything below this point****
--***************************************************************
DECLARE @SchemaT TABLE
  ( RowID INT IDENTITY(1 , 1),
    SchemaName NVARCHAR(MAX),
    TableName NVARCHAR(MAX),
    ColumnName NVARCHAR(MAX)
  )
IF OBJECT_ID('tempdb..#Results') IS NOT NULL 
  BEGIN
    DROP TABLE #Results
  END
CREATE TABLE #Results
  ( RowID INT IDENTITY(1 , 1),
    RSchemaName NVARCHAR(MAX) DEFAULT '',
    RTableName NVARCHAR(MAX) DEFAULT '',
    RColumnName NVARCHAR(MAX) DEFAULT '',
    Value NTEXT DEFAULT ''
  )

DECLARE @LoopNo INT,
  @TotalRows INT,
  @Schema NVARCHAR(MAX),
  @Table NVARCHAR(MAX),
  @Column NVARCHAR(MAX),
  @SQL NVARCHAR(MAX),
  @ParamDef NVARCHAR(MAX),
  @DataExists BIT
DECLARE @ReturnValue NVARCHAR(MAX)
DECLARE @ParmDefinition NVARCHAR(MAX)

--****************************************************************************************************
--Gather list of columns to search.  Schema, table and column name and table size filters are applied
--****************************************************************************************************
INSERT  INTO @SchemaT
        ( SchemaName,
          TableName,
          ColumnName
        )
        SELECT  Sch = t.Sch,
                Tbl = REPLACE(REPLACE(t.Tbl , '[' , '[[') , ']' , ']]'),
                Col = c.name
        FROM    ( SELECT  s.Name AS Sch,
                          t.name AS Tbl,
                          t.object_id,
                          SUM(p.rows) AS NumCount
                  FROM    sys.schemas s
                  LEFT JOIN sys.tables t
                          ON s.schema_id = t.schema_id
                  LEFT JOIN sys.partitions p
                          ON t.object_id = p.object_id
                  LEFT JOIN sys.allocation_units a
                          ON p.partition_id = a.container_id
                  WHERE   p.index_id IN ( 0 , 1 ) -- 0 heap table , 1 table with clustered index
                          AND p.rows IS NOT NULL
                          AND a.type = 1  -- row-data only , not LOB
                          AND ( s.name LIKE '%' + @FilterSchema + '%'
                                OR @FilterSchema IS NULL
                              )
                          AND ( t.name LIKE '%' + @FilterTable + '%'
                                OR @FilterTable IS NULL
                              )
                  GROUP BY s.Name,
                          t.name,
                          t.object_id
                  HAVING  ( SUM(p.rows) >= @MinRows
                            AND ( SUM(p.rows) <= @MaxRows
                                  OR @MaxRows IS NULL
                                )
                          )
                ) T
        INNER JOIN sys.columns C
                ON T.object_id = c.object_id
        INNER JOIN sys.types P
                ON C.system_type_id = p.system_type_id
        WHERE   ( p.name LIKE '%char%'
                  OR p.name LIKE '%text%'
                )
                AND ( c.name LIKE '%' + @FilterColumn + '%'
                      OR @FilterColumn IS NULL
                    )
        ORDER BY Sch,
                Tbl,
                Col
--**********************************************************************************
--Build and execute search strings and input the results into #Results
--**********************************************************************************
SELECT  @LoopNo = 1,
        @TotalRows = MAX(RowID)
FROM    @SchemaT
PRINT 'Total Rows = ' + CAST(@TotalRows AS NCHAR(5))
WHILE @LoopNo <= @TotalRows 
  BEGIN
    SELECT  @Schema = SchemaName,
            @Table = TableName,
            @Column = ColumnName
    FROM    @SchemaT
    WHERE   RowID = @LoopNo  
    SET @SQL = 'SELECT [' + @Column + '] FROM [' + @Schema + '].[' + @Table + '] where charINDEX(''' + @Characters + ''',[' + @Column + ']) > 0'
--*********************************
--Show progress on the message tab
--*********************************
    PRINT @Schema + '.' + @Table + '.' + @Column
    PRINT @SQL
    PRINT 'Row ' + CAST(@LoopNo AS NCHAR(5)) + ' @ ' + CAST(CAST(CURRENT_TIMESTAMP AS DATETIME) AS NVARCHAR(12))
--*********************************
	
    SET @ParmDefinition = '@ReturnValueOUT NVARCHAR(MAX) OUTPUT'
    INSERT  INTO #Results
            ( Value
            )
            EXECUTE sp_executesql 
              @SQL,
              @ParmDefinition,
              @ReturnValueOUT = @ReturnValue OUTPUT
    UPDATE  #Results
    SET     RTableName = @Table,
            RColumnName = @Column,
            RSchemaName = @Schema
    WHERE   RTableName = ''
    SET @LoopNo = @LoopNo + 1  
  END

--**********************************************************************************
--Display the results, aggregated by column.  
--**********************************************************************************

SELECT  COUNT(*) AS Occurrences,
        RSchemaName,
        RTableName,
        RColumnName
FROM    #Results
GROUP BY RSchemaName,
        RTableName,
        RColumnName


drop table #Results