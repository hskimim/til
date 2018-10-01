-- show databases; 
-- use world;
-- select database();
-- show tables;
-- desc country;


-- Quiz_01_01
-- select distinct(Continent)
-- from country


-- Quiz_01_02
-- SELECT*
-- FROM city
-- WHERE CountryCode = 'KOR' and Population >=1000000
 
-- Quiz_01_03 
-- select *
-- from city
-- where 8000000<=Population and Population <=10000000
-- ORDER BY Population DESC

-- Quiz_01_04
-- SELECT Code,CONCAT(Name,'(',IndepYear,')') AS 'NameIndep' , Continent, Population
-- FROM country
-- WHERE IndepYear >1940 AND IndepYear <1950
-- ORDER BY IndepYear ASC

-- Quiz_01_05
-- SELECT *
-- FROM countrylanguage
-- WHERE Language IN (' English','Spanish','Korean') and Percentage >= 95
-- ORDER BY Percentage DESC

-- Quiz_01_06
-- SELECT Code, Name, Continent, GovernmentForm, Population
-- FROM country
-- WHERE Code LIKE 'A%' and GovernmentForm LIKE '%Republic%'




-----------------------------------------------------------------------------------------------

-- Quiz_02_01
-- SELECT count(distinct(Continent))
-- FROM country

-- Quiz_02_02
-- SELECT Continent, COUNT(Continent)
-- FROM country
-- GROUP BY Continent

-- Quiz_02_03
-- SELECT CountryCode, SUM(Population) as Population
-- FROM city
-- GROUP BY CountryCode
-- ORDER BY Population DESC

-- Quiz_02_04
-- SELECT Language ,COUNT(Language) as count
-- FROM countrylanguage
-- GROUP BY Language
-- ORDER BY count DESC
-- LIMIT 4,6

-- Quiz_02_05
-- SELECT Language, COUNT(Language) as count
-- FROM countrylanguage 
-- GROUP BY Language
-- ORDER BY count DESC

-- Quiz_02_06
-- SELECT Continent, SUM(SurfaceArea) as SurfaceArea
-- FROM country
-- GROUP BY Continent
-- ORDER BY SurfaceArea DESC

-------------------------------------------------------------------------------------------------
-- Quiz_03_01
-- SELECT Name,SUM(Population) AS Population
-- FROM country
-- GROUP BY Name
-- HAVING  Population > 98881000
-- -- Dont know way how to command larger than Mexico Population not integar command. 
-- ORDER BY Population DESC

-- Quiz_03_02
-- ALTER TABLE country CHANGE COLUMN name Name_country VARCHAR(255) NOT NULL;
-- change(alter) the col name for distinguish Name in table of city
-- select CountryCode, count(Name) as count
-- from city
-- group by CountryCode
-- order by count DESC
-- limit 10

-- Quiz_03_03
-- SELECT Language, sum(Population) as count
-- from countrylanguage,country
-- GROUP BY Language
-- ORDER BY count DESC
-- LIMIT 10

-- Quiz_03_04
-- select city.Name as city_name , country.Code as Country_code, country.Name as country_name, (city.Population/country.Population) as percentage from country
-- inner join city	on country.Code = city.CountryCode
-- where (city.Population/country.Population) > 0.1 and city.Population > 5000000
-- order by percentage DESC

-- Quiz_03_05
-- select distinct(country.Code) as Country_code, country.Name as country_name, (country.Population/country.SurfaceArea) as density , count(countrylanguage.language) as language from country
-- inner join countrylanguage on country.Code = countrylanguage.CountryCode
-- where country.SurfaceArea > 10000 and country.Population/country.SurfaceArea > 200
-- group by country.Code
-- having language > 5
-- order by language DESC

-- Quiz_03_06
-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- create new_view as 
-- select country.Code as countrycode , city.Name as city_name , city.Population as population, country.Name as name ,count(countrylanguage.Language) as language, group_concat(countrylanguage.language) as languages from country
-- inner join countrylanguage on country.Code = countrylanguage.CountryCode 
-- inner join city on countrylanguage.CountryCode = city.CountryCode 
-- group by country.Code 
-- having language < 3

-- Quiz_03_06_with_view
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `new_view` AS
    SELECT 
        `country`.`Code` AS `countrycode`,
        `city`.`Name` AS `city_name`,
        `city`.`Population` AS `population`,
        `country`.`Name` AS `name`,
        COUNT(`countrylanguage`.`Language`) AS `language`,
        GROUP_CONCAT(`countrylanguage`.`Language`
            SEPARATOR ',') AS `languages`
    FROM
        ((`country`
        JOIN `countrylanguage` ON ((`country`.`Code` = `countrylanguage`.`CountryCode`)))
        JOIN `city` ON ((`countrylanguage`.`CountryCode` = `city`.`CountryCode`)))
    GROUP BY `country`.`Code`
    HAVING (`language` < 3)

