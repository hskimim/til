-- 올림 , 반올림 , 내림 함수
-- 조건문 : if, ifnull, case when then else end
-- date_format : 
-- join (merge like in Python) : inner , left, right 
--  union : full outer 
-- sub-query 
-- index : explain -- 이 쿼리는 빠르겠구나, 느리겠구나를 판단할 수 있다. 자주 사용되는 쿼리는 index를 사용한다. index는 따로 저장공간을 따로 차지하게 된다.
-- 이에 따라 index가 너무 많으면 저장 공간이 차게 되고, insert속도가 느려지게 된다. 하지만 select 속도가 많이 빨라지게 된다.
-- view

-- select ceil(12.345) -- 소수점 첫 번째 자리에서 올림이 되서 정수가 나온다.
-- select ceil(12.345*10)*0.1 -- 편법을 써서 소수점 첫 번째 자리에서 올림을 해야 한다.

-- select ceil(Percentage)
-- from countrylanguage

-- select round(12.345,2) -- 소수점 2째 자리에서 반올림한다.

-- select Percentage , round(Percentage,2)
-- from countrylanguage

-- select truncate(12.345,1) -- 소수점 첫 째자리에서 버림한다.

-- select truncate(Percentage,0)
-- from countrylanguage

-- 조건문  
-- if : IF(조건,참,거짓)
# 도시의 인구가 100만이 넘으면 big city 그렇지 않으면 small city 를 scale column 출력

-- select name,population, if(population>1000000,'big city','small city') as scale
-- from city
-- having sclae = 'small city'
-- order by population DESC

-- ifnull : ifnull(컬럼명,디폴트_데이터)
#독립 연도가 없는 데이터를 0으로 출력
-- select indepyear , ifnull(indepyear,123) as imputed_indepyear
-- from country

-- case when then else end
#나라별로 인구가 10억 이상,10억 ~ 1억 이상, 1억 이하  - "b,m,s"
-- select name,population 
-- , case
-- 	when population > 1000000000 then 'b'
--     when population > 100000000 then 'm'
--     else 's'
-- end as scale 
-- from country
-- having scale = 'm'
-- order by population DESC

-- date_format
-- select date_format(payment_date,'%Y-%m') as monthly, sum(amount)
-- from payment
-- group by monthly
-- 
-- join
-- inner : intersectionpayment
-- left : left of ben-diagram
-- right : right of ben-diagrm
-- full outer : union

-- CREATE TABLE user (
-- 
-- 	 user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
-- 
-- 	 name varchar(30) DEFAULT NULL,
-- 
-- 	 PRIMARY KEY (user_id)
-- 
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- CREATE TABLE addr (
-- 
-- 	 id int(11) unsigned NOT NULL AUTO_INCREMENT,
-- 
-- 	 addr varchar(30) DEFAULT NULL,
-- 
-- 	
-- user_id int(11) DEFAULT NULL,
-- 
-- 	
-- PRIMARY KEY (id)
-- 
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- INSERT INTO user(name)
-- 
-- VALUES ("jin"),
-- 
-- ("po"),
-- 
-- ("alice"),
-- 
-- ("petter");
-- -- 
-- INSERT INTO addr(addr, user_id)
-- 
-- VALUES ("seoul", 1),
-- 
-- ("pusan", 2),
-- 
-- ("deajeon", 3),
-- 
-- ("deagu", 5),
-- 
-- ("seoul", 6); 

-- select user.user_id , user.name , addr.addr
-- from user
-- left join addr
-- on user.user_id = addr.user_id

-- union
-- select name
-- from user
-- union
-- select addr
-- from addr

-- full-outer-join
-- select user.name , addr.addr
-- from user
-- left join addr
-- on user.user_id = addr.user_id
-- union
-- select user.name , addr.addr
-- from user
-- right join addr
-- on user.user_id = addr.user_id

-- sub-query : select , from , where 절 등에서 사용이 가능합니다. (query in query in query....)
# 전체 나라 수 , 도시 수 ,언어 수를 하나의 row로 출력
#select 구문에서 사용하는 sub-query
-- select
-- (select count(*) from country) as country_count,
-- (select count(*) from city) as city_count,
-- (select count(distinct(language)) from countrylanguage) as language_count

-- from 구문에서 사용하는 sub-query
#800만 이상이 되는 도시의 국가코드 국가 이름, 도식 인구수를 출력
-- <with sub-query>
-- select city.countrycode, city.name,country.name, city.population
-- from
-- (
-- select CountryCode , Name , population
-- from city 
-- where population > 8000000
-- ) as city
-- join country
-- on city.countrycode  = country.code
-- from 절 안에 sub-query를 넣고 연산을 끝내놓고 이후에 join을 하면 query performance(velocity)에 훨씬 좋다.

-- <without sub-query>
-- select city.CountryCode , city.name,country.name,city.population
-- from city
-- join country
-- on city.countrycode = country.code
-- having city.population > 8000000
-- join 하면 두 테이블 row 갯수의 multiply case 만큼의 연산을 해야 한다.

-- where clause 에서 사용하는 sub-query
#800만 이상 도시의 국가코드, 국가이름, 대통령 이름을 출력
-- select code,name,headofstate
-- from country
-- where code in (
--  select countrycode from city where population > 8000000
-- )

-- index -- 저장 공간 높아진다. 속도는 빨라진다. insert 속도가 늦어진다.
-- without index
-- explain
-- select * from salaries
-- where salary> 6000 and from_date > '2000-01-01'
-- order by salary
-- limit 1000

-- create index salaries
-- on salaries(salary)

-- view : 가상의 테이블 - 컬럼의 수정이나, 인덱스 설정 같은 명령을 할 수 없다.

-- select *
-- from countrylanguage
-- join(
-- select country.code,country.name as country_name,city.name as city_name
-- from country
-- join city
-- on country.code = city.countrycode
-- ) as s1
-- on s1.code = countrylanguage.countrycode
-- 
-- create view code_name as 
-- select country.code,country.name as country_name,city.name as city_name
-- from country
-- join city
-- on country.code = city.countrycode
-- 
-- select *
-- from countrylanguage
-- join code_name
-- on code_name.code = countrylanguage.countrycode
