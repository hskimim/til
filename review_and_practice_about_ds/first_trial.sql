-- show databases;
-- drop database test;
-- create database test;
-- use test;
-- select database()
-- show tables;
-- create table user(name char(20),agae int(3));
-- show tables;
-- desc user;
-- rename table user to dss;
-- show tables;
-- insert into dss(name,age)values('hskimim',23);
-- insert into dss(name,age)values('hskimim1im',22);
-- show tables;
-- show tables; 
-- desc dss; 
-- select * from dss;
-- drop table dss;
-- show tables;
-- show databases;
-- drop database test;

-- create database test;
-- use test;
-- select database()
-- create table user1(user_id int, name varchar(20), email varchar(30), age int(3), rdate date)
-- create table user2(user_id int PRIMARY KEY AUTO_INCREMENT, name varchar(20) not null, email varchar(30)unique not null, age int(3) default '30', rdate timestamp)
-- show tables; 




-- goupby,having
-- count, min, max, sum, avg..
-- city table에서 countycode 를 groupby 나라마다 도시가 몇개인지를 확인해본다.alter
-- 대륙별로 한 국가의 최대 인구수와 GNP 최대값을 조회

-- 
-- select count(distinct(countrycode))
-- from city
-- group by countrycode

-- select continent,min(population),min(gnp)
-- from country
-- where population !=0 and gnp !=0
-- group by continent

select continent,sum(population) as population,sum(gnp),sum(gnp)/sum(population)
from country
group by continent
having population > 500000000
order by population desc







