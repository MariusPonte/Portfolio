
-- In this section I want to demonstrate how easy we can improve performance in SQL by rewriting a function.
---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Step 1: Lets create some test data in a temp table.


DECLARE @FromDate DATE = '2010-01-01';
DECLARE @ToDate DATE = '2016-12-31';

SELECT TOP 10000000 CAST (DATEADD(DAY, RAND(CHECKSUM(NEWID())) * (1 + DATEDIFF(DAY, @FromDate, @ToDate)), @FromDate) AS DATETIME) AS DATE_1,
	  NEWID() AS ID,
	  'TestingPerformane' AS VARCHAR_COL 
INTO #T
FROM SYS.SYSOBJECTS 
CROSS JOIN SYS.SYSOBJECTS AS S2
CROSS JOIN SYS.SYSOBJECTS AS S3

---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Step 1a: say we have a scalar funtion that output a period from a datetime field. 
-- Example: 2017-01-01 00:00:00.000 --> 201701. Function is defined as follows:


CREATE FUNCTION Dbo.F_Md(@Date DATETIME)
RETURNS INT
AS
     BEGIN

         IF @Datum IS NULL
             RETURN NULL;    
         RETURN YEAR(@Date) * 100 + MONTH(@Date);
     END;


---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Step 1b: lets use our scalar function and measure the performance.
---------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT TOP 1000000 dbo.F_m (DATE_1), *
FROM #T
WHERE dbo.F_m (DATE_1) > 201405


-- Step 2a: Create a function, this time Table Valued function: Result outputs a table, setbased in stead of singular.

CREATE FUNCTION dbo.TVF_MND (@Date DATETIME) RETURNS TABLE

AS RETURN
SELECT YEAR (@date)*100 + MONTH (@date) AS Periode

-- Step 2b: Same request, different syntax: (again measuring performance)

SELECT TOP 1000000 Periode, *
FROM #T
CROSS APPLY TVF_M (DATE_1)
WHERE Periode > 201405  -- 5 sec


-- Conclusion: by a simple modification to the function we call in our query, our request runs 4 times faster!!
