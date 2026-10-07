-- Phase 7: Indexes (Performance Optimization)
-- 7A — Create Strategic Indexes
-- Index the most commonly filtered columns:
create index idx_customer_email on customers(email);
select * from customers where email like "S%";

create index idx_reg_date on customers(registration_date asc);
select * from customers where month(registration_date) = 02;

create index idx_orders_status on orders(order_status);
select * from orders where order_status = "SHIPPED";
select * from orders where order_status = "PENDING";
select * from orders where order_status = "DELIVERED";
select * from orders where order_status = '';

create index idx_customer_id on customers(customer_id);
select * from customers where customer_id <= 10;

create index idx_order_id on orders(order_id);
select * from orders where order_id between 5 and 10 and order_status != '';

create index idx_product_id on products(product_id);
select * from products where product_id = 6;

create index idx_review_id on reviews(review_id);
select * from reviews where review_id = 22;

create index idx_product_category on products(category);
select * from products where category = "Mobile";

create index idx_order_date on orders(order_date);
select * from orders where order_date = '2024-05-25';
select * from orders where year(order_date) = '2024';

-- 7B — Test Performance (Before & After)
select order_id, sum(quantity) from order_items group by order_id;
-- Fetch time: 0.0035 sec
create index idx_order_items_quantity on order_items(quantity);
select order_id, sum(quantity) from order_items group by order_id;
-- Fetch time: 0.0019 sec 

-- Composite Indexes:
create index idx_customerID_OrderDate on orders(customer_id, order_date);
select * from orders where customer_id = 100 and year(order_date) = '2024';

select * from reviews where rating >= 3 and year(review_date) = '2024';
-- Fetch time: 0.012 sec
create index idx_reviews_rating_date on reviews(rating, review_date);
select * from reviews where rating >= 3 and year(review_date) = '2024';
-- Fetch time: 0.00074 sec 

-- 7C — View All Indexes: 
show index from customers;
show index from order_items;
show index from orders;
show index from products;
show index from reviews;