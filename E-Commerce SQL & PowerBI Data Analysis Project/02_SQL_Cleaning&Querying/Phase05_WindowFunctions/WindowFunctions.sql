-- Phase 5: Window Functions (Ranking, Partitioning, Lag/Lead)
-- 5A: Ranking Functions

-- Ranked customers by 'total spent':
select c.customer_id, c.name, sum(o.total_amount) as Total_Spent,
rank() over (order by sum(o.total_amount) desc) as spend_rnk 
from customers c 
left join orders o 
on c.customer_id = o.customer_id
group by c.customer_id;

-- Top 3 best-selling products per category:
select * from order_items;

select * from (
select p.category, p.name, sum(oi.quantity) as Units_Sold,
sum(oi.quantity * oi.unit_price) as Total_Sales,
rank() over (partition by p.category order by sum(oi.quantity) desc) as Category_Rank
from order_items oi
join products p on oi.product_id = p.product_id
group by p.product_id
) as ranked 
where category_rank <= 3;

### 5B — Lag/Lead (Compare rows)
-- Show month-over-month order totals (compare each month to the previous):

SELECT DATE_FORMAT(order_date, '%Y-%m-01 00:00:00') as Month,
sum(total_amount) as Monthly_Revenue,
lag(sum(total_amount)) over (order by DATE_FORMAT(order_date, '%Y-%m-01 00:00:00')) as Previous_Month_Revenue
from orders
group by DATE_FORMAT(order_date, '%Y-%m-01 00:00:00');

--  5C — Running Totals
-- Show cumulative revenue over time:
select * from orders;
select order_date, total_amount,
sum(total_amount) over (order by order_date) as "cumulative_revenue"
from orders
order by order_date;









 

