-- Exploratory Data Analysis (SELECT, WHERE, Basic Aggregations)
-- Basic Queries
-- Find all customers from California:
select * from customers where state = "California";

-- Find all orders placed in 2024:
select * from orders where year(order_date) = 2024;

-- Find all products priced between $100 and $500:
select * from products where price between 100 and 500;

-- Find all products with "laptop" in the name (case-insensitive):
select * from products where name like "%laptop%";

-- Counting & Aggregations
-- Count orders per customer (who ordered the most?):
select customer_id, count(customer_id) as order_occurrence from orders group by customer_id order by order_occurrence desc limit 1;
select * from customers where customer_id = 18;

-- Find average order value:
select * from orders;
select avg(total_amount) from orders;

-- Find total revenue by product:
select * from order_items;
select product_id, sum(line_total) as Total_Revenue from order_items group by product_id;

-- or: 
select o.product_id, p.name, sum(o.line_total) as Total_Revenue 
from order_items o
join products p 
on o.product_id = p.product_id
group by o.product_id
order by Total_Revenue desc;

-- Or:
 SELECT p.name, SUM(oi.line_total) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_id
    ORDER BY total_revenue DESC;
    
-- Count reviews per product, only products with 3+ reviews:
select * from reviews;
select r.product_id, p.name, count(order_id) as Number_of_Reviews 
from reviews r 
join products p 
on r.product_id = p.product_id
group by r.product_id
having count(order_id) >= 3
order by Number_of_Reviews asc;



