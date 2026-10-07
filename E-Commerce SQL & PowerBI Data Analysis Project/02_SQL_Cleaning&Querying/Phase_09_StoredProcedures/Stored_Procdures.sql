-- Phase 9: Stored Procedures (Reusable Business Logic)
-- 9A — Simple Procedures
-- Create a procedure to get customer statistics:
/*
CREATE PROCEDURE `retrieve_customer_stats`(in cust_id INT)
BEGIN
select c.customer_id, c.name,
count(o.order_id) as total_orders,
sum(o.total_amount) as lifetime_value,
avg(o.total_amount) as average_order_value
from customers c
left join orders o 
on c.customer_id = o.customer_id 
where c.customer_id = cust_id
group by c.customer_id;
END
*/

CALL retrieve_customer_stats(56);
CALL retrieve_customer_stats(25);
CALL retrieve_customer_stats(24);

-- Create a procedure that returns monthly revenue:
/*
CREATE PROCEDURE `get_monthly_revenue`(in report_year INT, report_month INT, OUT revenue_total DECIMAL(12,2))
BEGIN
select sum(total_amount) into revenue_total
from orders
where year(order_date) = report_year
   and month(order_date) = report_month;
END
*/

call get_monthly_revenue(2023, 02, @total);
select @total as february_2023_revenue;

-- 9C — Procedures with Business Logic: 
-- Create a procedure to flag high-value customers for special treatment:

/*
CREATE PROCEDURE `Flag_VIP_Customers`(in spending_threshold DECIMAL(10,2))
BEGIN
SELECT c.customer_id, c.name,
sum(o.total_amount) as customer_spend,
'VIP' as customer_tier
from customers c 
join orders o on c.customer_id = o.customer_id 
group by c.customer_id
having sum(o.total_amount) > spending_threshold
order by customer_spend desc;
END
*/

call Flag_VIP_Customers(10000);


