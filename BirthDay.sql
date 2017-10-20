

-- It's your BirthDay!!

-- Calculating age can be a tricky thing. Usually,  a year has 365 days. But as we all know, not always. Sometimes there’s 366. And there lies the challenge in calculating age.
-- Most of the times, we see either a function that uses 365,25 days, which is a close estimate, but not 100% accurate. So when we want to congratulate our premium customers, being a day off is kind of amateuristic.
-- So, we want to be accurate 100% of the time. That complicates things. 
-- Often used is logic that uses IF – THEN – ELSE reasoning. So if the current month > then month Date of birth OR (current month = month Date of birth AND DAY current month > then DAY Date of birth) THEN … ELSE …

-- Sounds like a lot of rules. What if there could be some magic that would solve this issue? Giving credit here to ‘dotjoe’ for his contribution on StackOverflow. Check out the following: 
-- Basically, we will display both date columns as numbers. Without going into details, it looks like this: 


USE MyDataBase


SELECT LEFT (CAST (CONVERT (VARCHAR, GETDATE(), 112) AS INT) - CAST (CONVERT (VARCHAR, PERS_DoB, 112) AS INT), 2) AS Age

-- So, let’s say we have a table T_Person and we would like to find all people aged over 24.
-- Comparing an scalar function, using logic mentioned above to the inline select statement, would give this:

SET STATISTICS TIME ON


SELECT LEFT (CAST (CONVERT (VARCHAR, GETDATE(), 112) AS INT) - CAST (CONVERT (VARCHAR, PERS_DoB, 112) AS INT), 2) AS Age
FROM T_Person
WHERE LEFT (CAST (CONVERT (VARCHAR, GETDATE(), 112) AS INT) - CAST (CONVERT (VARCHAR, PERS_DoB, 112) AS INT), 2) > 24

-- CPU time = 5850 ms,  elapsed time = 7855 ms.


SELECT DM.dbo.F_Age (PERS_DoB, GETDATE())
FROM T_Person
WHERE DM.dbo.F_Age (PERS_DoB, GETDATE()) > 24

-- CPU time = 30092 ms,  elapsed time = 31624 ms.


-- In conclusion: Not only is this alternative way to calculate an age an elegant solution, it performs much, much better to conventional ways.
