-- 1) ENTIRE US MASS SHOOTINGS TABLE 

SELECT * 
FROM USMassShootings$



-- 2) TOTAL SHOOTING EPISODES

SELECT COUNT(Date) AS TotalShootings 
FROM USMassShootings$ 



-- 3) RANKING OF HIGHEST ANNUAL SHOOTING EPISODES 

SELECT Year, COUNT(CAST(Year AS INT)) AS AnnualCount,
DENSE_RANK () OVER (ORDER BY COUNT(CAST(Year AS INT)) DESC) AS AnnualRanking --,
-- ROW_NUMBER () OVER (ORDER BY COUNT(CAST(Year AS INT)) DESC) Annual_Numbering
FROM USMassShootings$
WHERE Year IS NOT NULL
GROUP BY Year



-- 4) ANNUAL AGGREGATES OF THE US MASS SHOOTINGS TABLE

WITH YearAgg AS(
SELECT Year, COUNT(CAST(Year AS INT)) AS AnnualCount,
DENSE_RANK() OVER (ORDER BY COUNT(CAST(Year AS INT)) DESC) AS AnnualRanking --,
-- ROW_NUMBER () OVER (ORDER BY COUNT(CAST(Year AS INT)) DESC) AnnualNumbering
FROM USMassShootings$
WHERE Year IS NOT NULL
GROUP BY Year
)
SELECT SUM(AnnualCount) AS YearTotal, ROUND(AVG(AnnualCount),2) AS YearAvg, MIN(AnnualCount) AS YearMin, MAX(AnnualCount) AS YearMax --,
FROM YearAgg



-- 5) RANKING OF HIGHEST SAME-DATE MASS SHOOTING EPISODES

SELECT Date, COUNT(Date) AS Datecount, 
DENSE_RANK () OVER (ORDER BY COUNT(Date) DESC) AS DateRanking
-- ROW_NUMBER () OVER (ORDER BY COUNT(CAST(Date AS date)) DESC) AS DateNumbering
FROM USMassShootings$
WHERE Date IS NOT NULL
GROUP BY Date



-- 6) FINDING THE AGGREGATES OF THE MASS SHOOTINGS DATES

WITH DateAgg AS (
(SELECT Date, COUNT(Date) AS DateCount, 
DENSE_RANK () OVER (ORDER BY COUNT(Date) DESC) AS DateRanking
-- ROW_NUMBER () OVER (ORDER BY COUNT(Date) DESC) AS DateNumbering
FROM USMassShootings$
WHERE Date IS NOT NULL
GROUP BY Date)
)
SELECT SUM(DateCount) AS DateTotal, ROUND(AVG(DateCount),2) AS DateAvg, MIN(DateCount) AS DateMin, MAX(DateCount) AS DateMax 
FROM DateAgg



-- 7) RANKING OF MONTHLY MASS SHOOTING EPISODES (DESC)

WITH MonthlyMassShootings AS(

(SELECT 'Jan' AS Months, COUNT(Date) AS ShootingCounts 
FROM USMassShootings$
WHERE Date LIKE '%Jan%') 
UNION
(SELECT 'Feb', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%Feb%')
UNION
(SELECT 'Mar', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%Mar%')
UNION
(SELECT 'Apr', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%Apr%')
UNION
(SELECT 'May', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%May%')
UNION
(SELECT 'Jun', COUNT(Date)
FROM USMassShootings$
WHERE Date LIKE '%Jun%')
UNION
(SELECT 'Jul', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%Jul%')
UNION
(SELECT 'Aug', COUNT(Date)
FROM USMassShootings$
WHERE Date LIKE '%Aug%')
UNION
(SELECT 'Sep', COUNT(Date) 
FROM USMassShootings$
WHERE Date LIKE '%Sep%')
UNION
(SELECT 'Oct', COUNT(Date)
FROM USMassShootings$
WHERE Date LIKE '%Oct%')
UNION
(SELECT 'Nov', COUNT(Date)
FROM USMassShootings$
WHERE Date LIKE '%Nov%')
UNION
(SELECT 'Dec', COUNT(Date)
FROM USMassShootings$
WHERE Date LIKE '%Dec%')
)
SELECT *, DENSE_RANK() OVER (ORDER BY ShootingCounts DESC) AS MonthRankings
FROM MonthlyMassShootings




-- 8) CREATE TABLE OF MONTHLY COUNTS TO OBSERVE SEASONAL AGGREGATES (SUM, AVG, MIN, MAX)
-- SEPARATE THE MONTHS INTO SETS OF 3 FOR EACH SEASON 

-- DROP TABLE IF EXISTS
CREATE TABLE SeasonalMassShootings_ (
Month NVARCHAR (255) PRIMARY KEY,
Jan FLOAT,
Feb FLOAT,
Mar FLOAT,
Apr FLOAT,
May FLOAT,
Jun FLOAT,
Jul FLOAT,
Aug FLOAT,
Sep FLOAT,
Oct FLOAT, 
Nov FLOAT,
Dec FLOAT 
);
INSERT INTO SeasonalMassShootings_ VALUES('Monthlyshootings', 7, 14, 12, 11, 10, 14, 10, 8, 10, 11, 12, 11)

SELECT *
FROM SeasonalMassShootings_



-- 9) FIND THE SUM PER ANNUAL SEASON

SELECT
(Dec + Jan + Feb) AS Winter_shootings,
(Mar + Apr + May) AS Spring_shootings,
(Jun + Jul + Aug) AS Summer_shootings,
(Sep + Oct + Nov) AS Fall_shootings
FROM SeasonalMassShootings_


SELECT (Dec + Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov) MonthSum
FROM SeasonalMassShootings_


-- SELECT ROUND(((Dec + Jan + Feb)/MonthSum)*100, 2) winperc
-- FROM (SELECT (Dec + Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov) MonthSum
-- FROM SeasonalMassShootings_)



-- 10) CREATE TABLE OF YEAR COUNTS TO OBSERVE DECADE AGGREGATES (SUM, AVG, MIN, MAX)
-- SEPARATE THE YEARS INTO SETS OF 10 FOR EACH DECADE

-- DROP TABLE IF EXISTS
CREATE TABLE AnnualMassShootings__(
Years NVARCHAR (255) PRIMARY KEY,
"1982" FLOAT,
"1984" FLOAT,
"1986" FLOAT,
"1987" FLOAT,
"1988" FLOAT,
"1989" FLOAT,
"1990" FLOAT,
"1991" FLOAT,
"1992" FLOAT,
"1993" FLOAT,
"1994" FLOAT,
"1995" FLOAT,
"1996" FLOAT,
"1997" FLOAT,
"1998" FLOAT,
"1999" FLOAT,
"2000" FLOAT,
"2001" FLOAT,
"2003" FLOAT,
"2004" FLOAT,
"2005" FLOAT,
"2006" FLOAT,
"2007" FLOAT,
"2008" FLOAT,
"2009" FLOAT,
"2010" FLOAT,
"2011" FLOAT,
"2012" FLOAT,
"2013" FLOAT,
"2014" FLOAT,
"2015" FLOAT,
"2016" FLOAT,
"2017" FLOAT,
"2018" FLOAT,
"2019" FLOAT,
"2020" FLOAT,
"2021" FLOAT,
"2022" FLOAT,
TotalShootings FLOAT 
);
INSERT INTO AnnualMassShootings__ VALUES('TotalYearlyShootings', 1, 2, 1, 1, 1, 2, 1, 3, 2, 4, 1, 1, 1, 2, 3, 5, 1, 1, 1, 1, 2, 3, 4, 3, 4, 1, 3, 7, 5, 4, 7, 6, 11, 12, 10, 2, 6, 5, 130) 

SELECT *
FROM AnnualMassShootings__



-- 11) PERCENTAGES PER DECADE


SELECT
ROUND((("1982" + "1984" + "1986" + "1987" + "1988" + "1989" + "1990" + "1991" + "1992")/TotalShootings)*100, 2) FirstDecadePercent,
ROUND((("1993" + "1994" + "1995" + "1996" + "1997" + "1998" + "1999" + "2000" + "2001")/TotalShootings)*100, 2) SecondDecadePercent,
ROUND((("2003" + "2004" + "2005" + "2006" + "2007" + "2008" + "2009" + "2010" + "2011" + "2012")/TotalShootings)*100, 2) ThirdDecadePercent,
ROUND((("2013" + "2014" + "2015" + "2016" + "2017" + "2018" + "2019" + "2020" + "2021" + "2022")/TotalShootings)*100, 2) FourthDecadePercent
FROM AnnualMassShootings__



-- 11) FIRST DECADE ANNUAL SHOOTINGS

-- (
SELECT Year, COUNT(Year) AS FirstDecadeShootings
FROM USMassShootings$
WHERE Year BETWEEN 1982 AND 1992
GROUP BY Year
-- )
-- UNION
 
-- 12) SECOND DECADE ANNUAL SHOOTINGS

-- (
SELECT Year, COUNT(Year) AS SecondDecadeShootings
FROM USMassShootings$
WHERE Year BETWEEN 1993 AND 2002
GROUP BY Year
-- )
-- UNION


-- 13) THIRD DECADE ANNUAL SHOOTINGS

-- (
SELECT Year, COUNT(Year) AS ThirdDecadeShootings
FROM USMassShootings$
WHERE Year BETWEEN 2003 AND 2012
GROUP BY Year
ORDER BY Year ASC
-- )
-- UNION


-- 14) FOURTH DECADE ANNUAL SHOOTINGS

-- (
SELECT Year, COUNT(Year) AS FourthDecadeShootings
FROM USMassShootings$
WHERE Year BETWEEN 2013 AND 2022
GROUP BY Year
-- )



-- 15) DECADES PERCENTAGES

--DROP TABLE IF EXISTS
CREATE TABLE  DecadePercent (
Decade NVARCHAR (255),
Shootings FLOAT
);
INSERT INTO DecadePercent VALUES ('DecadeOne', 14)
INSERT INTO DecadePercent VALUES ('DecadeTwo', 19)
INSERT INTO DecadePercent VALUES ('DecadeThree', 29)
INSERT INTO DecadePercent VALUES ('DecadeFour', 68)

SELECT *
FROM DecadePercent



-- 16) RUNNING COUNT OF MASS SHOOTING EPISODES PER DECADE 

SELECT Decade, Shootings, SUM(Shootings) OVER (ORDER BY Decade) AS ShootingsRunningCount
FROM DecadePercent
GROUP BY Decade, Shootings 



-- 17) TOTALS FOR FATALITIES, INJURED and TOTALVICTIMS

WITH AllSums AS (
(SELECT Fatalities,  Injured,  TotalVictims 
FROM USMassShootings$)
)
SELECT SUM(Fatalities) AS SumFatalities, SUM(Injured)  AS SumInjured, SUM(TotalVictims)  AS SumTotalVictims 
FROM AllSums



-- 18) RUNNNING COUNTS FOR FATALITIES, INJURED and TOTALVICTIMS

SELECT Year, Date, State, Fatalities, SUM(Fatalities) OVER (ORDER BY Year) AS RunningFatalities, ROW_NUMBER () OVER (ORDER BY Year) AS Numbering, Injured, SUM(Injured) OVER (ORDER BY Year) AS RunningInjured,  ROW_NUMBER () OVER (ORDER BY Year)  AS Numbering, TotalVictims, SUM(TotalVictims) OVER (ORDER BY Year) AS RunningTotalVictims,  ROW_NUMBER () OVER (ORDER BY Year)  AS Numbering 
FROM USMassShootings$
WHERE Year IS NOT NULL
ORDER BY Year, Date, State ASC



-- 19) TOTAL SHOOTING EPISODES & VICTIMS PER WEAPON TYPE (UnDisclosed- U/D)

(SELECT 'U/D' WeaponType, COUNT(WeaponType) WeaponUD, SUM(Fatalities) FatalitiesUD, SUM(Injured) InjuredUD, SUM(TotalVictims) TotVictimsUD
FROM USMassShootings$
WHERE WeaponType LIKE '%U/D%')
UNION
(SELECT 'Semi-Auto' 'Semi-Auto', COUNT(WeaponType) WeaponUD, SUM(Fatalities) FatalitiesUD, SUM(Injured) InjuredUD, SUM(TotalVictims) TotVictimsUD
FROM USMassShootings$
WHERE WeaponType LIKE '%Semi-automatic%')
UNION
(SELECT 'Non-Semi' 'Non-Semi', COUNT(WeaponType) WeaponNonSemi, SUM(Fatalities) FatalitiesNonSemi, SUM(Injured) InjuredNonSemi, SUM(TotalVictims) TotVictimsSemi
FROM USMassShootings$
WHERE WeaponType NOT LIKE '%Semi-automatic%' AND WeaponType NOT LIKE '%U/D%')



-- 22) COUNTS OF SHOOTERS WITH LEGAL WEAPONS

(SELECT 'U/D' LegalWeapons, COUNT(LegalWeapons) AS Counts
FROM USMassShootings$
WHERE LegalWeapons LIKE '%U/D%' 
GROUP BY LegalWeapons)
UNION
(SELECT 'No' 'No', COUNT(LegalWeapons) AS CountsNo
FROM USMassShootings$
WHERE LegalWeapons LIKE '%No%')
UNION
(SELECT 'Yes' 'Yes', COUNT(LegalWeapons) AS CountsYes
FROM USMassShootings$
WHERE LegalWeapons LIKE '%Yes%')

