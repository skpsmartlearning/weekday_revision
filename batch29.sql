Create database batch29

use batch29

create schema b29

create table b29.student
(
	roll int,
	sname varchar(20),
	addr varchar(30),
	age int
)

create table student
(
	roll int,
	sname varchar(20),
	addr varchar(30),
	age int
)

select * from student

--1st Method
insert into student values(101,'Sam','Delhi',10);

--2nd Method
insert into student(roll,sname,addr,age) values(102,'Ram','Delhi',10);
insert into student(roll,addr,sname,age) values(103,'Delhi','Ram',10);

--3rd Method (Null)
insert into student(roll,sname,addr) values(104,'Ram','Delhi');
insert into student(roll,sname,age) values(105,'Jam',10);

--4th Method
insert into student(roll,sname,addr,age) values(106,'Tam','Delhi','');
insert into student(roll,sname,addr,age) values(107,'Ham','',10);


select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'dbo';
EXEC sp_help 'student'

--Update
update student set age=15 where roll = 101;

select * from student

--Delete
delete from student where roll = 107
delete student where roll = 107

--Truncate
truncate table student

--Drop
Drop table studen

select * from student

---Alter
--Add Column
alter table student
add email varchar(20)

--Add multiple Column
alter table student
add email1 varchar(20), email2 varchar(20)

--Drop Existing Column
alter table student
drop column email

--Drop Multiple Existing Column
alter table student
drop column email1,email2

--Alter Existing Column
alter table student
alter column addr varchar(300)

--Rename Column
exec sp_rename 'student.sname','studen_name','column'

--Rename Table
exec sp_rename 'student','student_new'

--Distinct
select * from student
select distinct * from student ---Row level
select distinct(roll), * from student
select distinct(roll) from student ---Column level
select count(distinct(roll)) from student

---Alias
select count(distinct(roll)) as unique_count from student
select count(distinct(roll)) unique_count from student
select count(distinct(roll)) 'unique count' from student

------------------------------------------------------------------------------------------------------
--OR
select * from customers
select * from customers where Country = 'USA'
select * from customers where Country = 'USA' Or Country = 'France' Or Country = 'UK' Or Country = 'Germany'

--IN
select * from customers where Country in ('USA','France','UK','Germany')

--AND
select * from customers where Country = 'USA' and City = 'portland'

--Not
select * from customers where not country = 'USA'
select * from customers where country != 'USA'
select * from customers where country <> 'USA'
select * from customers where Country not in ('USA')

---Order By

select * from customers order by customerName
select * from customers order by customerName asc
select * from customers order by customerName desc
select * from customers order by Country desc, CustomerName asc
select country,CustomerName from customers order by Country desc, CustomerName asc
select country,city,CustomerName from customers order by Country desc, city asc, CustomerName desc

---Top
select * from products order by price desc
select top(5) * from products order by price desc
select top(5) * from products order by price asc

---Between (>= and <=)
select * from products where price >= 10 and price <= 20
select * from products where price between 10 and 20

---Wildcard
select * from customers where CustomerName like 'A%'
select * from customers where CustomerName like '%n'
select * from customers where CustomerName like '_s%'
select * from customers where CustomerName like '__s%'
select * from customers where CustomerName like '%super%'
select * from customers where CustomerName like '_a_i%'


---Aggregate (Count/Sum/Min/Max/Avg)
select * from products
select sum(price) as SumOfPrice from products
select min(price) as minOfPrice from products
select max(price) as maxOfPrice from products
select avg(price) as avgOfPrice from products
select count(price) as countOfPrice from products

---Group By
select * from customers
--select distinct(country) from customers
select country from customers group by country
select country,count(*) as countrycount from customers group by country
select country,count(country) as countrycount from customers group by country

select country,count(country) as countrycount from customers
group by country
order by countrycount desc

select top(5) country,count(country) as countrycount from customers
group by country
order by countrycount desc

---Having
select country,count(country) as countrycount from customers
group by country
having count(country) > 5
order by countrycount desc

select country,count(country) as countrycount from customers
where country = 'USA'
group by country
having count(country) > 5
order by countrycount desc

--Join
create table student2(ID int, Name varchar (20), Address varchar(50))
create table class(ID int, class varchar (20), section varchar(20))
insert into student2 values (1,'a','patna')
insert into student2 values(2,'b','delhi')
insert into student2 values(3,'c','bombay')
insert into student2 values(4,'d','punjab')
insert into student2 values(5,'e','patna')

insert into class values(4,5,'c')
insert into class values(5,2,'a')
insert into class values(6,6,'a')
insert into class values(7,7,'b')
insert into class values(8,1,'a')

--If you don't pass type of join then by default it will be Inner join
--Inner Join
select * from student2
inner join class
on student2.id = class.id

--left Join
select * from student2
left join class
on student2.id = class.id

--Right Join
select * from student2
right join class
on student2.id = class.id

--Full Join
select * from student2
full join class
on student2.id = class.id

select student2.id, student2.name, student2.address, class.id, class.class, class.section from student2
full join class
on student2.id = class.id

select s.id, s.name, s.address, c.id, c.class, c.section from student2 as s
full join class as c
on s.id = c.id

select s.id, s.name, s.address,  c.class, c.section from student2 as s
full join class as c
on s.id = c.id


---Union/Union All
--1) Number of column should be same
--2) Order of the column should be same
--3) Data type of the column should be same

--Union
t1 = c1,c2,c3,c4
t2 = c1,c2,c3
t3 = c1,c2

select c1,c2,c3 from t1
union
select c1,c2,c3 from t2

select c1,c2 from t1
union
select c1,c2 from t2
union
select c1,c2 from t3

---Union All
select c1,c2,c3 from t1
union all
select c1,c2,c3 from t2

select c1,c2 from t1
union all
select c1,c2 from t2
union all
select c1,c2 from t3

---CASE
select * , 
Case
	when price >=1 and price <=10 then 'Low'
	when price >=11 and price <=20 then 'Medium'
	when price >=21 and price <=100 then 'High'
	else 'NA'
End as rating from products

--- Select Into
select * from products
select * from products_new
drop table products_new

select * into products_new from products

select * , 
Case
	when price >=1 and price <=10 then 'Low'
	when price >=11 and price <=20 then 'Medium'
	when price >=21 and price <=100 then 'High'
	else 'NA'
End as rating into products_new from products

---Select Insert Into
select * into products_new from products where 1=2
insert into products_new select * from products


---Auto Increment (Surrogate Key)
create table student3
(
	roll int identity(1,1),
	sname varchar(20),
	addr varchar(50)
)
select * from student3
insert into student3(sname,addr) values('Sam1','Pune')
insert into student3(sname,addr) values('Raj','Pune')

---Index (Clustered / Non Clustered)
select * from customers

----Single Column Index
create index custindex
on customers(customerid)

----Multi Column Index
create index custindexmulti
on customers(customername,address)

drop index customers.custindex
drop index customers.custindexmulti

---View
Source(1TB)->SQL landing(1TB) - SQL Staging (1TB) - Final Clean (1TB)

create view vw_usa_customer
as
select * from customers where country = 'USA'

select * from usa_customer

---Stored Procedure
create procedure sp_usa_customer
as
select * from customers where country = 'USA'

execute sp_usa_customer


create proc sp_uk_customer
as
select * from customers where country = 'UK'

exec sp_uk_customer

create proc sp_rating_product_price
as
select * , 
Case
	when price >=1 and price <=10 then 'Low'
	when price >=11 and price <=20 then 'Medium'
	when price >=21 and price <=100 then 'High'
	else 'NA'
End as rating from products

exec sp_rating_product_price


-------------------------------Single Parameter-------------------------------------

create proc sp_uk_customer_dym @countryname varchar(20)
as
select * from customers where country = @countryname

exec sp_uk_customer_dym 'Mexico'

-------------------------------Multiple Parameter-------------------------------------

create proc sp_uk_customer_dym2 @countryname varchar(20), @cityname varchar(20)
as
select * from customers where country = @countryname and city = @cityname

exec sp_uk_customer_dym2 'USA' , 'Portland'


----Constraint
--1) Not Null
--2) Unique
--3) Primary Key
--4) Foreign Key
--5) check
--6) Default

select * from student
drop table student

--1) Not Null
create table student
(
 roll int Not Null,
 sname varchar(20) Not Null,
 addr varchar(30),
 age int
)

insert into student values(101,'Sam','Hyd',10)
insert into student values(101,'','Hyd',10)
insert into student values('','Sam','Hyd',10)
insert into student values(NULL,'Sam','Hyd',10)

--2) Unique
create table student
(
 roll int Unique,
 sname varchar(20),
 addr varchar(30),
 age int
)

insert into student values(101,'Sam','Hyd',10)
insert into student values('','Sam','Hyd',10)
insert into student values(NULL,'Sam','Hyd',10)


--3) Primary Key (Not Null + Unique)
create table student
(
 roll int primary key,
 sname varchar(20),
 addr varchar(30),
 age int
)

insert into student values(101,'Sam','Hyd',10)
insert into student values(102,'Sam','Hyd',10)
insert into student values(103,'Sam','Hyd',10)
insert into student values(104,'Sam','Hyd',10)
insert into student values(105,'Sam','Hyd',10)
insert into student values(106,'Sam','Hyd',10)
insert into student values('','Sam','Hyd',10)
insert into student values(NULL,'Sam','Hyd',10)

--3) Foreign Key

create table classes
(
 classid int primary key,
 rollid int foreign key references student(roll),
 section varchar(2)

)
select * from classes
insert into classes values(201,101,'A')
insert into classes values(202,101,'A')
insert into classes values(206,105,'A')

insert into classes values(207,106,'A')

drop table student
drop table classes

--5) check
create table student
(
 roll int,
 sname varchar(20),
 addr varchar(30),
 age int check(age>=5)
)

insert into student values(101,'Sam','Hyd',4)
insert into student values(101,'Sam','Hyd',5)


--6) Default

create table student
(
 roll int,
 sname varchar(20),
 addr varchar(30) default 'Delhi',
 age int
)

select * from student
insert into student values(101,'Sam','Mumbai',6)
insert into student(roll,sname,age) values(102,'Sam',6)

---------Bulk Data Load Directly From External File---------------------

create table actor
(
	id int,
	lastname varchar(20),
	firstname varchar(20),
	middlename varchar(20),
	suffix varchar(5)
)

select * from actor

bulk insert actor from 'C:\Users\Admin\Desktop\Batch28\actor.csv'
with
(
	format = 'csv',
	firstrow = 2
)

---Coalesce
select * from actor

update actor
set suffix = 'Sr.' where suffix is Null

select id,lastname,firstname,middlename,coalesce(suffix,'Sr.') as suffix from actor

-------------------Window Function (Row Number / Rank / Dense Rank / Lead / Lag)----------------------

create table officedata
(
 employee_id int,
 employee_name varchar(50),
 department varchar(30),
 state varchar(10),
 salary int,
 age int,
 bonus int
)

bulk insert officedata from 'C:\Users\Admin\Desktop\Batch28\OfficeDataProject (1).csv'
with
(
	format = 'CSV',
	firstrow = 2
)

select * from officedata

select department,employee_name,max(salary) as deptcount from 
officedata group by department,employee_name
order by department,deptcount desc

select department,count(department) as deptcount,
min(salary) as minsal,
max(salary) as maxsal
from officedata
group by department

---Over Clause
select * ,
min(salary) over(partition by department) as minsal,
max(salary) over(partition by department) as maxsal
from officedata

---Row Number
select *,
row_number() over(partition by department order by salary) as rwno from officedata

select *,
row_number() over(partition by department order by salary desc) as rwno from officedata

------------Find Second Highest Salary from each Department-------------------

select * from 
(select *,
row_number() over(partition by department order by salary desc) as rwno from officedata) as subdata
where rwno =2

------------Find Second and fourth Highest Salary from each Department-------------------
select * from 
(select *,
row_number() over(partition by department order by salary desc) as rwno from officedata) as subdata
where rwno in (2,4)


---Rank
P-2000-1
A-3000-2
B-3000-2
S-3000-2
C-4000-5

select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk 
from officedata


---Dense Rank
P-2000-1
A-3000-2
B-3000-2
S-3000-2
C-4000-3

select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as drnk 
from officedata

---Lead
select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as drnk,
lead(salary,1) over(partition by department order by salary asc) as ld
from officedata

select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as drnk,
lead(salary,2) over(partition by department order by salary asc) as ld
from officedata


---lag
select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as drnk,
lead(salary,1) over(partition by department order by salary asc) as ld,
lag(salary,1) over(partition by department order by salary asc) as lg
from officedata

select *,
row_number() over(partition by department order by salary desc) as rwno, 
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as drnk,
lead(salary,2) over(partition by department order by salary asc) as ld,
lag(salary,2) over(partition by department order by salary asc) as lg
from officedata



-------------------------------THE END-------------------------------------