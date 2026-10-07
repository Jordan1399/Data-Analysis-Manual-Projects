-- Phase 10: Advanced Business Questions (Integration Challenge):
-- Which customers have not placed an order in the last 90 days, and how much did they spend previously?
select c.customer_id, c.name, sum(o.total_amount) as Lifetime_Spend, max(o.order_date) as last_order
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id
having datediff(curdate(), MAX(o.order_date)) > 90 
order by Lifetime_Spend desc;

-- For each product, show its sales trend (month 1 vs month 2 vs month 3) as separate columns: 
select p.product_id, p.name, 
sum(case when month(o.order_date) = 1 then oi.quantity else 0 end) as month01_qty,
sum(case when month(o.order_date) = 2 then oi.quantity else 0 end) as month02_qty,
sum(case when month(o.order_date) = 3 then oi.quantity else 0 end) as month03_qty,
(select sum(case when month(o.order_date) = 1 then oi.quantity else 0 end)+sum(case when month(o.order_date) = 2 then oi.quantity else 0 end)+sum(case when month(o.order_date) = 3 then oi.quantity else 0 end)) as Q3_Total_QTY
from products p 
left join order_items oi on p.product_id = oi.product_id 
left join orders o on oi.order_id = o.order_id
group by p.product_id;

show tables;



