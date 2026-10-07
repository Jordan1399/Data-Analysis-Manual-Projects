-- Phase 4: Joins (Combining Related Data)
-- INNER JOINs

-- Show each order with customer name and order details: Order ID & Customer ID from Orders | customer name from customers "name"

select o.order_id, c.name, o.order_date, o.delivery_date, o.order_status, o.total_amount
from orders o 
inner join customers c 
on o.customer_id = c.customer_id

-- Show each order item with product name and price:

Select oi.item_id, o.order_id, p.name, oi.quantity, oi.unit_price, oi.line_total
from order_items oi
inner join orders o on oi.order_id = o.order_id
inner join products p on oi.product_id = p.product_id
group by oi.item_id;

-- Find which customers have left reviews (INNER JOIN means only customers with reviews):
select distinct c.customer_id, c.name, count(r.review_id) as review_count 
from customers c
inner join reviews r on c.customer_id = r.customer_id
group by c.customer_id;

select c.customer_id, c.name, r.review_text 
from customers c
left join reviews r on r.customer_id = c.customer_id

### 4B — LEFT JOINs (Find unmatched data):
-- Find all customers who have NEVER placed an order:

select distinct c.customer_id, c.name
from customers c
left join orders o
on o.customer_id = c.customer_id
where o.order_id is null;

select * from customers;
-- A: 79 Customers with no orders placed. 

-- Find all products that have NEVER been ordered:
select p.product_id, p.name
from products p
left join order_items oi on p.product_id = oi.product_id
where oi.item_id is null;

-- There are no products that have not been ordered 

-- Show all orders with customer details, including those with missing customer references:
select * from orders;

select o.order_id, c.name, o.order_date, o.total_amount
from orders o
left join customers c
on c.customer_id = o.customer_id
order by o.order_id asc;

-- 4C — Multiple JOINs
-- Show a customer's full order history with product details:
select c.customer_id, c.name, o.order_id, p.name, o.order_date, o.delivery_date, o.total_amount
from customers c
left join orders o on c.customer_id = o.customer_id
left join order_items oi on o.order_id = oi.order_id
left join products p on oi.product_id = p.product_id
order by c.customer_id, o.order_date asc;






