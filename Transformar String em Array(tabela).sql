Declare @String VARCHAR(1000)
--
set @String = '3,16,1'
--
DECLARE @Int INT
--
Declare @Regionais TABLE
(
RegionalId Int
)
--
IF PATINDEX ('%,%', @String) = 0
   INSERT INTO @Regionais VALUES (@String)
ELSE BEGIN
   WHILE PATINDEX ('%,%', @String) > 0
   BEGIN
      INSERT INTO @Regionais VALUES (CONVERT (Int, SUBSTRING (@String, 1, PATINDEX ('%,%', @String) - 1)))
      SET @String = SUBSTRING (@String, PATINDEX ('%,%', @String) + 1, LEN(@String))
   END
   INSERT INTO @Regionais VALUES (@String)
END
--
select * from @Regionais
