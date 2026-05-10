use skptempdb
select * from sys.tables
---1
select * from customers c, orders o
where c.CustomerID=o.customerID

----2
select * from customers c
where c.CustomerID not in (select o.customerid from orders o)

---3
select c.customername, count(o.orderid) as 'Total Order' from customers c, orders o
where c.CustomerID=o.CustomerID
group by c.customername
order by count(o.OrderID) desc

-----4
select top (5) c.customername,  count(o.orderid) as 'TotalOrder' from customers c, orders o
where c.CustomerID=o.CustomerID
group by c.customername
order by count(o.OrderID) desc

------5
select * from order_details

select orderid, sum(quantity) as 'Total Quantity' from order_details group by OrderID

----6
select ct.categoryid, ct.categoryname, pr.productname from products pr, categories ct
where ct.CategoryID=pr.CategoryID
order by ct.categoryname

-----7
select ct.categoryname, count(pr.productname) 'Total Product' from products pr, categories ct
where ct.CategoryID=pr.CategoryID
group by ct.categoryname

----8
select e.firstname, o.orderid from employees e, orders o
where e.EmployeeID=o.EmployeeID


-----9
select * from customers

SELECT CustomerName, COUNT(*)
FROM customers
GROUP BY CustomerName
HAVING COUNT(*) > 1;

-----10

select customerid, max(orderdate) as 'Latest Order',  min(orderdate) from orders
group by CustomerID

---11

select orderid, customerid,orderdate,
rank() over (order by orderdate desc) as rank from orders

----12

select customerid, orderid,
ROW_NUMBER() over (partition by customerid order by orderdate desc) as 'Row Number' from orders

----13

select * from order_details

select orderdetailid,orderid,quantity,
sum(quantity) over (partition by orderid order by orderdetailid) as 'Running Total' 
from order_details

----14

select * from products order by price desc

select productid, productname from(
	select * , DENSE_RANK() over (order by price desc) as rn from products
) as stable
where stable.rn=2


----15
select orderid, orderdate from orders
where YEAR(orderdate)='1997'

----16
select country, count(country) as 'Total Customer' from customers group by Country

----17

select * from order_details order by Quantity desc

select o.orderid, max(o.quantity) as 'Highestorder' , p.productname from order_details o, products p
where o.ProductID=p.ProductID
group by o.OrderID, p.ProductName
order by Highestorder desc

SELECT *
FROM (
    SELECT OrderID, ProductID, Quantity,
    ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY Quantity DESC) rn
    FROM order_details
) t
WHERE rn = 1;

-----18

select o.quantity, p.price, (o.quantity * p.price) as 'Total Revenue' from order_details o, products p
where
o.ProductID=p.ProductID

select sum(o.quantity * p.price) as 'Total Revenue' from order_details o, products p
where
o.ProductID=p.ProductID

----19

select count(*) as 'Orders', MONTH(orderdate) as 'Month' , employeeid from orders
group by EmployeeID, MONTH(OrderDate)

---20

select c.CustomerName,count(o.OrderID) as 'Orders'  from customers c, orders o
where c.CustomerID=o.CustomerID 
group by c.CustomerName
having count(o.OrderID)>5
order by count(o.OrderID) desc

-----21

SELECT TOP 3 c.customername, SUM(p.Price * od.Quantity) AS Revenue
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON od.ProductID = p.ProductID
GROUP BY c.customername
ORDER BY Revenue DESC;

select c.customerid, c.customername, od.Quantity,p.price,(od.Quantity*p.price) as 'Revenue' from customers c, products p, orders o, order_details od
where c.CustomerID=o.CustomerID and
o.OrderID=od.OrderID and
od.ProductID=p.ProductID
order by Revenue desc








