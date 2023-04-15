-- STEP1 CREATE Database of your Data.
CREATE DATABASE facebook;

-- Activate SCHEMA by using key "USE
USE FACEBOOK

-- SELECT all data for understanding what data is ok.
SELECT * FROM data; -- 226 ROWS return

SELECT count(*) FROM data;

-- Use some Aggregated fuction for numeric column.
SELECT 
    Name,
    AVG(Users) AS avg_users,
    ROUND(AVG(Facebook_Users), 2) AS max_users_countrywise,
    Date_of_Data
FROM
    data
GROUP BY Name , Date_of_Data
ORDER BY avg_users DESC; -- Use of "DESC" sort values by largest to smallest. 
-- Country user "CYPRUS" have 78% users of facebook in 2020.

-- NOW we use here some mathematical expression to extract max information from these small data.
-- Calculate the 70% no users population and and remaining users of population.
SELECT 
    Name,
    Population / 70 * 100 AS no_of_seventy_percent_nonusers,
    ROUND(Population / Users * 100, 2) AS percentage_users
FROM
    data
 
--   usage of facbook max.
with use_facebook as(
select  Name,Users,max(Facebook_Users)AS max_users FROM data
GROUP BY Name,Users
ORDER BY max_users DESC
)
SELECT * FROM use_facebook;
-- Kuwait have 98% Facbook users

-- In which year have max facebook users.
-- SELECT TOP 3 COUNTRY WHICH MAX USERS IN RECENT YEAR.
SELECT 
    Name, Date_of_Data, MAX(Users) AS max_user
FROM
    data
GROUP BY Name , Date_of_Data;
-- Instead USING of RANK use "MAX"
-- INDIA,USA,Indonesia Top 3 Country.

-- Actual population of users from total population.
WITH actual_population AS(
SELECT Name,Users,sum(Population)/71*100 AS no_users
FROM data
WHERE Name="India"
GROUP BY Name,Users
ORDER BY no_users,Name DESC
)
SELECT * FROM actual_population; 

-- minimum users in 2020 is 
WITH users_incline AS 
(SELECT Name,users,Date_of_Data,round(percent_rank()OVER(ORDER BY Users DESC )*1000,2)AS percentage_users
FROM data
WHERE Date_of_Data
)
SELECT * FROM users_incline

-- Slovenia ,jamaica,tazakistan,and botswana has low icrement of fACEBOok users in 2020. 

-- Which country have lead in Facebook_Users by Percent.
SELECT Name,Users,Facebook_Users,
LEAD(Facebook_Users)OVER(ORDER BY Users DESC) AS leader
FROM data
ORDER BY leader DESC ;
-- Lebonon have max leading country in Facebook_users by user
-- Tajikistann has lowest country in world have lowest facbook users

-- FiNAL to find leading country max_users by year
SELECT Name,LEAD(Facebook_Users)OVER(ORDER BY Facebook_Users DESC)  AS lead_users,
Date_of_Data,Population
FROM data
ORDER BY Users,Name DESC;

-- BY pupulation wise tajakistan  have top  position with low population 


-- CONCLUSION -- 1. IS Overall Facebook users are are incresimg by year 2020 to 2021
--               2. with low population have some country awarness bout Facebook
--		         3. Country Tajiikistan have the max lead_users in year 2021
--               4. slovinia have low  populatiuon but 50%  population is on Facebook
--               5. INDIA HAD placed top position
--               6. Cyprus have maximum 78% Facebook Users over the Population 2020
-- FINALISE  FROM 2020 FACEBOOK USERS  IN ALL OVER THE WORLD ARE INCREASING.







