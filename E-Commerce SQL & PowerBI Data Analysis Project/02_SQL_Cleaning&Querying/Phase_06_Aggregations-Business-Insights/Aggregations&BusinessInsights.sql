-- Aggregations & Business Insights: 
-- 6A — Revenue Analysis

-- Find top 10 customers by total spending:
select * from orders;

select rank() over (order by sum(total_amount) desc) as "RANK", 
customer_id, sum(total_amount) as "Total_Spending"
from orders group by customer_id order by Total_Spending desc limit 10;

-- With names: 
select rank() over (order by sum(total_amount) desc) as "Spend_Rank", 
o.customer_id, c.name, sum(o.total_amount) as "Total_Spending"
from orders o
left join customers c
on o.customer_id = c.customer_id
group by o.customer_id
order by Total_Spending desc 
limit 10;

-- Average order value by customer city:
select c.city, avg(o.total_amount) as "Average_Order_Value", count(o.order_id) as "Order_Count"
from customers c 
left join orders o 
on c.customer_id = o.customer_id
group by c.city;

-- Total revenue per category per month: Orders, Products, Order Items Tables 
select * from orders;
select * from order_items;
select * from products;

select YEAR(o.order_date) as Year, MONTH(o.order_date) as Month, p.category, sum(oi.line_total) as Total_Revenue
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
group by Year, Month, p.category
order by Year, Month, Total_Revenue desc;

-- Customer Insights
-- Identify high-value customers (spent more than company average):

select avg(total_amount) from orders;

select c.customer_id, c.name, sum(o.total_amount) as Customer_Spend
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id having sum(o.total_amount) != '' and sum(o.total_amount) > 2391.201825
order by Customer_Spend desc;

-- Find customers with increasing order value (recent orders larger than earlier ones):
select c.customer_id, c.name, 
min(o.total_amount) as smallest_order,
max(o.total_amount) as largest_order,
max(o.total_amount) - min(o.total_amount) as order_value_range
from customers c 
join orders o 
on c.customer_id = o.customer_id
group by c.customer_id 
having order_value_range > 100 
order by order_value_range desc;

-- 6C — Product Insights
-- Find the average rating per product:

select p.name, avg(r.rating) as Average_Rating
from reviews r
join products p 
on r.product_id = p.product_id
group by p.name
order by Average_Rating desc;

-- Find top 5 brands by total quantity sold:
select * from orders;
select * from products;
select * from order_items;

select p.brand, sum(oi.quantity) as total_units_sold
from products p
join order_items oi 
on p.product_id = oi.product_id
group by p.brand
order by total_units_sold desc
limit 5; 













