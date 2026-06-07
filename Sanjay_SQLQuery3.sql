create database joinsParactice
use joinsParactice

CREATE TABLE Customers (
    customer_id INT,
    customer_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_amount INT
);


CREATE TABLE Payments (
    order_id INT,
    payment_status VARCHAR(20)
);

select * from Customers
select * from Orders
select * from Payments

INSERT INTO Customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Orders VALUES
(101, 1, 250),
(102, 2, 450),
(103, 1, 300),
(104, 3, 150);

INSERT INTO Payments VALUES
(101, 'success'),
(102, 'failed'),
(103, 'success'),
(104, 'success');

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN p.payment_status = 'success' THEN 1 ELSE 0 END) AS successful_payments
FROM Customers c
LEFT JOIN Orders o 
    ON c.customer_id = o.customer_id
LEFT JOIN Payments p 
    ON o.order_id = p.order_id
GROUP BY c.customer_id, c.customer_name;