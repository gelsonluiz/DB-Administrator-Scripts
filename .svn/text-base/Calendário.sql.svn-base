/*

SELECT *  FROM dbo.CALENDAR('2017-06-01', '2017-06-30')

-- ULTIMO DIA DO MES
SELECT  DISTINCT MAX([Date]) OVER (PARTITION BY [Year],[MonthName]) AS [Date]
FROM    dbo.CALENDAR('01/01/2014','12/31/2014')
ORDER BY [Date]
*/

ALTER FUNCTION dbo.Calendar 
(
    @StartDate DATETIME
,   @EndDate DATETIME
) 
RETURNS TABLE
AS
----====================================
---- Name: CALENDAR
---- Created: Chris Kutsch 12/29/2014
---- Usage: Returns a dynamic calendar for date manipulation
----====================================
RETURN  
(
--declare
-- @StartDate DATETIME = '2017-06-01'
--,@EndDate DATETIME = '2017-06-30'


    SELECT  tt.RID
        ,   DATEADD(DAY,tt.RID-1,@StartDate) AS [Date]
        ,   DATEPART(quarter,DATEADD(DAY,tt.RID-1,@StartDate)) AS [Quarter]
        ,   DATEPART(dayofyear,DATEADD(DAY,tt.RID-1,@StartDate)) AS [DayofYear]
        ,   DATEPART(WEEK,DATEADD(DAY,tt.RID-1,@StartDate)) AS [WeekofYear]
        ,   DATEPART(YEAR,DATEADD(DAY,tt.RID-1,@StartDate)) AS [Year]    
        ,   DATEPART(MONTH,DATEADD(DAY,tt.RID-1,@StartDate)) AS [Month]
        ,   DATEPART(DAY,DATEADD(DAY,tt.RID-1,@StartDate)) AS [Day]    
        ,   DATEPART(weekday,DATEADD(DAY,tt.RID-1,@StartDate)) AS [Weekday]
        ,   DATENAME(MONTH,DATEADD(DAY,tt.RID-1,@StartDate)) AS [MonthName]
        ,   DATENAME(weekday,DATEADD(DAY,tt.RID-1,@StartDate)) AS [WeekdayName]
        --,   CASE WHEN rh.[CALENDER_DATE] IS NULL THEN 1 ELSE 0 END AS [IsBusinessDay]
        ,   (RIGHT( 
                REPLICATE('0',(4)) +
                CONVERT([VARCHAR],DATEPART(YEAR,DATEADD(DAY,tt.RID-1,@StartDate)),0)
                ,(4)
             )+
             RIGHT(
                REPLICATE('0',(2)) +
                CONVERT([VARCHAR],DATEPART(MONTH,DATEADD(DAY,tt.RID-1,@StartDate)),0)
                ,(2)
             )+
             RIGHT(
                REPLICATE('0',(2)) +
                CONVERT([VARCHAR],DATEPART(DAY,DATEADD(DAY,tt.RID-1,@StartDate)),0)
                ,(2)
             )
            ) AS [Vintage]
        
    FROM    ( SELECT ROW_NUMBER() OVER (ORDER BY [object_id]) AS [RID]
              FROM sys.all_objects WITH (NOLOCK)
            ) tt
            -- tt LEFT OUTER JOIN dbo.HOLIDAYS rh WITH (NOLOCK) ON DATEADD(DAY,tt.RID-1,@StartDate) = rh.[CALENDER_DATE]
            
    WHERE   DATEADD(DAY,tt.RID-1,@StartDate) <= @EndDate
    
)
 
GO