-- Phase 8: Views (Simplified Access & Reusability)
-- 8A — Create Business Views:
-- Customer Summary view:

create view customer_summary02 as 
select distinct c.customer_id, c.name, c.state, sum(o.total_amount) as "Customer_Spend", count(r.rating) as "Rating_Count", p.category as "Popular_Category"
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
join reviews r on c.customer_id = r.customer_id
group by c.customer_id, p.category having Rating_Count > 3
order by Customer_Spend desc;

select * from customer_summary02;

drop view customer_summary;
drop view customer_summary01;

-- Product Performance view:

Create view product_performance as
select p.product_id, p.name, p.category, p.brand, sum(oi.quantity) as Units_Sold, sum(oi.Line_total) as Total_Revenue, count(r.review_id) as Review_Count, avg(r.rating) as Average_Rating
from products p 
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
join reviews r on p.product_id = r.product_id
group by p.product_id;

select * from product_performance;

-- Daily sales view:

create view daily_sales_view as 
select o.order_date,
count(distinct o.order_id) as order_count,
sum(o.total_amount) as Daily_Revenue,
avg(o.total_amount) as Average_Revenue
from orders o 
group by o.order_date;

select * from daily_sales_view;

-- 8B — Query Views Above: 
select * from customer_summary02 where Customer_Spend > 15000;
select * from product_performance where Total_Revenue > 50000;
select * from daily_sales_view where Average_Revenue between 3000 and 5000;


