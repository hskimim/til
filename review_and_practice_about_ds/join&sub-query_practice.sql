-- quiz3__1
-- 1. 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순하세요.

-- select Name,Population from country
-- where Population > 98881000
-- order by Population DESC
-- 
-- quiz3__2
-- 2. 국가별 몇개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순하세요.
-- select (country.Name) as country, count(city.Name) as city from country
-- inner join city
-- on country.Code = city.CountryCode
-- group by country.Name
-- order by city DESC
-- limit 10

-- quiz3__3
-- 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순하세요.
-- select (countrylanguage.Language) as Language , sum(country.Population) as Population from country
-- inner join countrylanguage
-- on country.Code = countrylanguage.CountryCode
-- group by countrylanguage.Language
-- order by Population DESC
-- limit 10

-- quiz3__4
-- 4. 나라 전체 인구의 10%이상인 도시에서 도시인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
-- 
-- select over_10.Name as Name ,over_10.Countrycode as CountryCode , city.Name as name , over_10.Percentage as Percentage 
-- from (select country.Name ,city.CountryCode, round((city.Population / country.Population)*100,2) as Percentage from country
-- inner join city 
-- on country.Code = city.CountryCode	
-- where round((city.Population / country.Population)*100,2) > 10) as over_10
-- inner join city
-- on over_10.CountryCode = city.CountryCode
-- where city.Population > 5000000

-- quiz3__5
-- 5. 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 인구밀도가 200이상인
-- 국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회 하세요

-- select (density_table.Code) as Code , (density_table.Name) as Name , (density_table.density) as density , (language_count_table.language) as language 
-- from
-- (select distinct(country.Code) as Code , country.Name as Name , (country.Population / country.SurfaceArea) as density from country
-- inner join city
-- on country.Code = city.CountryCode
-- where (country.SurfaceArea > 10000) and (country.Population / country.SurfaceArea) > 200
-- order by density DESC
-- ) as density_table
-- inner join
-- (
-- select CountryCode , count(Language) as language from countrylanguage
-- group by CountryCode
-- having language > 5) as language_count_table
-- on density_table.Code = language_count_table.CountryCode
-- order by language DESC
-- 

-- quiz3__6
-- 6. 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
-- * GROUP_CONCAT(LANGUAGE) 을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
-- * VIEW를 이용해서 query를 깔끔하게 수정하세요.

-- select table1.Code , table2.city_name, table2.population, table1.country, table1.language,table1.languages
-- from(
-- select (country.Code) as Code ,country.Name as country, count(countrylanguage.language) as language ,group_concat(language) as languages from country
-- inner join countrylanguage
-- on country.Code = countrylanguage.CountryCode
-- group by Code
-- having language < 4) as table1
-- inner join (
-- select city.CountryCode , (city.Name) as city_name, (city.Population) as population from city
-- where city.Population > 3000000) as table2
-- on table1.Code = table2.CountryCode
-- 

-- 인구가 3000000이 넘는 도시의 코드와 이름 
-- select city.CountryCode , (city.Name) as city_name, (city.Population) as population from city
-- where city.Population > 3000000

-- 사용하는 언어가 3개 이하인 국가와 사용되는 언어들 
-- select (country.Code) as Code ,country.Name as country, count(countrylanguage.language) as language ,group_concat(language) as languages from country
-- inner join countrylanguage
-- on country.Code = countrylanguage.CountryCode
-- group by Code
-- having language < 4

-- create view table1 as 
-- select city.CountryCode , (city.Name) as city_name, (city.Population) as population from city
-- where city.Population > 3000000

-- create view table2 as 
-- select (country.Code) as Code ,country.Name as country, count(countrylanguage.language) as language ,group_concat(language) as languages from country
-- inner join countrylanguage
-- on country.Code = countrylanguage.CountryCode
-- group by Code
-- having language < 4

-- select table2.Code , table1.city_name, table1.population, table2.country, table2.language,table2.languages
-- from table2
-- inner join table1
-- on table2.Code = table1.CountryCode

