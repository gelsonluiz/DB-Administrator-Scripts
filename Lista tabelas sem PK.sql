SELECT Name
FROM sys.tables
WHERE OBJECTPROPERTY(OBJECT_ID,'TableHasPrimaryKey') = 0
order by 1