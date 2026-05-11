--10-10-2025

--create database learning

use learning

create table student
(
roll int,
sname varchar(20),
age int,
addr varchar(60)
)
drop table student
select * from student


-- Insert into
-- 1st method
insert into student (roll, sname, age, addr) values (101, 'Arun', 30, 'cbe')
--order change
insert into student (addr, sname, age, roll) values ('mum', 'Arun', 30, 102)
--Null
insert into student (roll, sname, age) values (103, 'Saara', 4)
--Blank
insert into student (roll, sname, age, addr) values (107, 'AbiA', 30, '')
insert into student (roll, sname, age, addr) values (105, 'Abi', '', 'mum')
--2nd method
insert into student values (102, 'Abi', 29, 'cbe')


---11-10-2025
--Truncate
Truncate table student
select * from student

--Delete 
Delete from student where roll=107
Delete from student
--Drop
Drop table student
select * from student

--update
update student
set addr='MUM' where roll=107
update student
set addr = 'mum' where roll=105


--ER diagram - Entity relationship diagram- relaationship b/w each tables.
--Each table - entity
--cols - attributes

--"OR' and "IN" both are same
--OR
Select * from customers where country = 'UK' or country = 'USA' or country = 'Mexico'

--In
Select * from customers where country in ('UK', 'USA', 'Mexico')

--And

Select * from customers where country = 'UK' and city = 'London'

--Not
Select * from customers where not country = 'UK' 
Select * from customers where country != 'UK' 
Select * from customers where country <> 'UK' 
Select * from customers where country not in ('UK' )

--Distinct
select * from student

select DISTINCT * from student -- unique Col level
select DISTINCT roll from student -- unique row level
select DISTINCT(roll) from student -- unique row level
select count(DISTINCT(roll)) from student -- count of unique row level
select count(DISTINCT roll) from student -- count of unique row level

--Alias
select count(DISTINCT roll) as countofroll from student -- count of unique row level and given name as countofroll
select count(DISTINCT roll) as count_of_roll from student -- count of unique row level and given name as countofroll(using _)
select count(DISTINCT roll) as 'count of roll' from student -- count of unique row level and given name as countofroll(with space using '')

select count(DISTINCT roll) countofroll from student -- count of unique row level and given name as countofroll - w/o using "AS"
select count(DISTINCT roll) count_of_roll from student -- count of unique row level and given name as countofroll(using _) - w/o using "AS"
select count(DISTINCT roll) 'count of roll' from student -- count of unique row level and given name as countofroll(with space using '') - w/o using "AS"



--Order by - Sorting
Select * from customers order by customername --default asecenting
Select * from customers order by customername asc -- asecenting
Select * from customers order by customername desc -- -- desecenting

Select * from customers order by country asc, customername desc  --nested sorting
Select country,customername from customers order by country asc, customername desc--nested sorting

--Top
Select * from products order by Price  --default asecenting
Select top(1) * from products order by Price  --default Top asecenting
Select top(1) * from products order by Price desc --Top descending


--Between (10 to 20) (it will take >= and <=)
Select * from products where price between 10 and 20 order by Price
Select * from products where price >=10 and price <=20 order by Price



---12-10-2025
--Wildcard

select * from customers where customername like 'A%'
select * from customers where customername like '%A'
select * from customers where customername like '%a'
select * from customers where customername like '_S%'
select * from customers where customername like '_I_S%'
select * from customers where customername like '_A_I%'
select * from customers where customername like '%super%'

---Aggregate function (sum/min/max/avg/count) - while appliyng filter"where" condition will not work

select * from products

select sum(price) from products --sum
select sum(price) as sumofprice from products -- sum with col name
select min(price) as minofprice from products -- min with col name
select max(price) as maxofprice from products -- max with col name
select avg(price) as avgofprice from products -- avg with col name
select count(price) as countofprice from products -- count with col name


--Group by
select * from customers

select country, count(*) as countrycount from customers group by country order by countrycount desc 


--Group by - Applying filter. while using Aggregate function "where, Alias(Not workin having)" condition will not work. We have to use "HAVING".
select country, count(*) as countrycount from customers 
group by country 
having count(*) >5
order by countrycount desc 


select country, customername from customers group by country, customername

--Alter
select * from student

--Add col
alter table student
add moblie int

--Add multi col
alter table student
add mail varchar(10), mail2 varchar(20)


--drop/delete col
alter table student
drop column moblie

--drop/delete multi col
alter table student
drop column mail, mail2

--update exciting col 
alter table student
alter column addr varchar(30)

--Rename col
exec sp_rename 'student.sname','stuname','column'
--Rename Table
exec sp_rename 'student','student_New'


--Join

create table student
(
id int,
Name varchar(20),
addr varchar(60)
)

create table Class
(
id int,
Class int,
Section varchar(5)
)



insert into student values (1,'a','Patna'),(2,'b','delhi'),(3,'c','bombay'),(4,'d','punjab'),(5,'e','Patna')
insert into class values (4,5,'c'),(5,2,'a'),(6,6,'a'),(7,7,'b'),(8,1,'a')

select * from student
select * from class


--inner Join

select * from student
inner join class
on student.id = class.id

--left Join
select * from student
left join class
on student.id = class.id

--Right Join
select * from student
Right join class
on student.id = class.id

--Full Join
select * from student
full join class
on student.id = class.id


---union - combine of multi tables, it will take unique key only from all table
--union_all - combine of multi tables, it will take all data including dublicates from all table


---Union
drop table tab1
drop table tab2
drop table tab3

create table tab1(ID int, sname varchar(20), mno varchar(10), mailid varchar(30))
create table tab2(ID int, sname varchar(20), mno varchar(10))
create table tab3(ID int, sname varchar(20))

select * from tab1

insert into tab1 values (101, 'Abi', '215478935', 'adve@gmail.com'), (102, 'Abi1', '2154789315', 'adve1@gmail.com'), (103, 'Abi3', '2154789353', 'adve3@gmail.com')
insert into tab2 values (101, 'Abi', '215478935'), (102, 'Abi1', '2154789315'), (103, 'Abi3', '2154789353')
insert into tab3 values (101, 'Abi'), (102, 'Abi1'), (103, 'Abi3')


t1 = c1,c2,c3,c4
t2 = c1,c2,c3
t3 = c1,c2

select ID,sname,mno from tab1
union all
select ID,sname,mno from tab2

select ID,sname from tab1
union all
select ID,sname from tab2
union all
select ID,sname from tab3

---Union All

select c1,c2,c3 from t1
union all
select c1,c2,c3 from t2

select c1,c2 from t1
union all
select c1,c2 from t2
union all
select c1,c2 from t3

---Case Statement
select * from products

select *,
case
	when price >= 1 and price <=10 then 'Low'
	when price >= 11 and price <=20 then 'Medium'
	when price >= 21 and price <=100 then 'High'
	else 'NA'
End as rating 
from products

---Select Into
product ==> product_new
select * from product_new
drop table product_new

select * into product_new from products

select *,
case
	when price >= 1 and price <=10 then 'Low'
	when price >= 11 and price <=20 then 'Medium'
	when price >= 21 and price <=100 then 'High'
	else 'NA'
End as rating
into product_new from products

---Select Insert Into
select * into product_new from products where 1=0


insert into product_new select * from products


---Auto Increment
select * from student

create table student
(
  roll int identity(101,1),
  sname varchar(20),
  addr varchar(50)
)

insert into student values('SKP','HYD')
insert into student values('Sam','Del')
insert into student values('John','Mum')

---Index
select * from customers

create index custindex
on customers(customerid)

create index custindex_multi_col_index
on customers(customername,contactname)

select * from customers where country = 'USA'

drop index customers.custindex
drop index customers.custindex_multi_col_index
drop index customers.PK__customer__A4AE64B85CD39E9C

---View
SourceT1(1TB)=>Landing(1TB)=>Staging(1TB)=>Destination(1TB)

select * from customers

create view vw_USCustomer
as
select * from customers  where country ='USA'

select * from vw_USCustomer

----Stored Procedure
create procedure sp_US_Customer
as 
select * from customers  where country ='USA'

execute sp_US_Customer

-----------------------------------
create proc sp_rating_product
as
select *,
case
	when price >= 1 and price <=10 then 'Low'
	when price >= 11 and price <=20 then 'Medium'
	when price >= 21 and price <=100 then 'High'
	else 'NA'
End as rating 
from products

exec sp_rating_product

--------------------------Single Parameter--------------------------------
create proc sp_country_cust @countryname varchar(20)
as
select * from customers  where country = @countryname

exec sp_country_cust USA

--------------------------Multi Parameter--------------------------------
create proc sp_country_city_cust @countryname varchar(20), @cityname varchar(20)
as
select * from customers  where country = @countryname and city = @cityname

exec sp_country_city_cust USA, Portland

----Constraint
---1) Not Null
---2) Unique
---3) Primary Key
---4) Foreign Key
---5) check
---6) default


---1) Not Null
select * from student
drop table student
create table student
(
  roll int not null,
  sname varchar(20),
  addr varchar(50)
)

insert into student(sname,addr) values('Sam','Mum')
insert into student(roll,sname,addr) values('','Sam','Mum')
insert into student(roll,sname,addr) values(NULL,'Sam','Mum')

---2) Unique
select * from student
drop table student
create table student
(
  roll int unique,
  sname varchar(20),
  addr varchar(50)
)


insert into student(sname,addr) values('Sam','Mum')
insert into student(roll,sname,addr) values('','Sam','Mum')
insert into student(roll,sname,addr) values(NULL,'Sam','Mum')


---3) Primary Key (Not Null + Unique)
select * from student
drop table student

create table student
(
  roll int primary key,
  sname varchar(20),
  addr varchar(50)
)

insert into student values(104,'Sam','Del')
insert into student(roll,sname,addr) values('','Sam','Mum')

---4) Foreign Key
select * from class
drop table class
create table class
(
classid int primary key,
rollid int foreign key references student(roll),
section varchar(1)
)

insert into class values(10001,101,'A')
insert into class values(10002,101,'A')
insert into class values(10003,NULL,'A')
insert into class values(10004,'','A')

---Check
select * from student
drop table student

create table student
(
  roll int,
  sname varchar(20),
  addr varchar(50),
  age int check(age>5)
)

insert into student values(104,'Sam','Del',6)

---Default
select * from student
drop table student

create table student
(
  roll int,
  sname varchar(20),
  addr varchar(50) default 'Delhi',
  age int
)

insert into student(roll,sname,age) values(101,'SKP',10)
insert into student values(101,'SKP','HYD',10)


