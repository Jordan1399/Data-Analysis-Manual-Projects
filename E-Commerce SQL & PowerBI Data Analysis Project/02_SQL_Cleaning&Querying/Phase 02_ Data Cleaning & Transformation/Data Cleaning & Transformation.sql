-- How many customers are missing emails?
select count(*) from customers where email = '';
-- 43 Empty String Rows for Email 

-- How many products have negative prices or NULL prices:
SELECT * FROM PRODUCTS;
select count(*) from products where price is NUll;
-- NO products with empty price data
select * from products where price like "-%";
select * from products where price <= 0 or null;
-- There is 1 product (ID 23) with negative pricing 

-- Find all orders where delivery_date is before order_date (data entry error):
select * from orders;
select * from orders where delivery_date < order_date;
-- there are 18 orders with a data entry error (the delivery date is logged before the order date) 

-- Check Reviews with ratings outside the valid 1–5 range:
select * from reviews; 
select * from reviews where rating < 1 or rating > 5 or rating is null;
-- there are 7 reviews with ratings outside the valid range or 0 

-- Find duplicate customers (same email):
select email, count(*) from customers where email is not null group by email having count(*) > 1;
-- There are 26 emails with multiple duplicates and 43 rows with blank email 

-- Clean & Standardize Data (UPDATE, REPLACE)
set sql_safe_updates = 0;
-- Replace negative prices with the product category average:
select * from products;
update products
set category = "Computers" 
where product_name = "ProTech Keyboard";

select round(avg(price),2) from products where category = "Computers";
-- 648.97 Category average for Computers

update products 
set price = "648.97"
where price = "-34.33";

-- Check Negative Price:
select count(*) from products where price like "-%";

-- Standardize state names (convert abbreviations to full names):
select * from customers;
update customers
set state = "New York"
where state = "NY";

update customers
set state = "California"
where state = "CA";

update customers
set state = "Texas"
where state = "TX";

update customers
set state = "Texas" 
where city = "Houston";

update customers
set state = "Illinois" 
where city = "Chicago";

update customers
set state = "New York" 
where state = "New York City";

update customers
set city = "New York City" 
where city = "New York";

update customers
set state = "Texas"
where city = "San Antonio";

update customers
set state = "Arizona"
where city = "Phoenix";

update customers
set state = "California"
where city = "Los Angeles";

update customers
set state = "Pennsylvania"
where city = "Philadelphia";

update customers
set state = "New York"
where city = "New York City";

update customers
set state = "California" 
where city = "San Diego";

select * from customers where city is null or city = '';
select count(*) from customers where state = '';
select count(*) from customers where city = '';

-- Contact-data cleanup examples use synthetic customer IDs and a reserved test number.
UPDATE customers
SET phone = "+1-202-555-0100"
WHERE customer_id = 1;

-- Remove leading/trailing spaces and standardize phone-number formatting:
UPDATE customers
SET phone = REPLACE(REPLACE(phone, '-', ''), ' ', '');
UPDATE customers
SET phone = TRIM(phone);
UPDATE customers
SET phone = REPLACE(REPLACE(phone, '(', ''), ' ', '');
UPDATE customers
SET phone = REPLACE(REPLACE(phone, ')', ''), ' ', '');

select email, count(*) as occurrences from customers group by email having count(*) >1 and email not in('');
select * from customers where email = '';

-- Correct selected blank emails using safe placeholders for the published sample.
UPDATE customers
SET email = "customer009@example.invalid"
WHERE customer_id = 9;

UPDATE customers
SET email = "customer012@example.invalid"
WHERE customer_id = 12;

UPDATE customers
SET email = "customer300@example.invalid"
WHERE customer_id = 300;

-- Fix order statuses (standardize capitalization):
select * from orders;
update orders
set order_status = upper(order_status);

-- Replace out-of-range review ratings with NULL (mark as invalid):
select * from reviews;
update reviews
set rating = NULL
WHERE rating < 1 or rating > 5;

-- Delete orders with negative total_amount (data corruption):
select * from orders where total_amount < 0;
-- order id: 36, 55, 160, 203, 430, 432, 449

delete from reviews
where order_id in(36, 55, 160, 203, 430, 432, 449);

delete from orders where order_id in(36, 55, 160, 203, 430, 432, 449);
select count(*) from orders where order_id < 0;
select * from orders;

-- Structural Changes (ALTER TABLE):
-- Add a new column `age_days` to customers (time since registration):
alter table customers
add column age_days int;
select * from customers;
UPDATE customers 
SET age_days = DATEDIFF(CURDATE(), registration_date);
-- Add a calculated column `line_total` to order_items (quantity × unit_price):
select * from order_items;
alter table order_items add column line_total decimal(10,2);
update order_items
set line_total = quantity * unit_price;
-- Rename `product_name` to `name` in products table for consistency:
alter table products
rename column product_name to name;
select * from products;
-- Change `price` column type from DECIMAL to ensure 2 decimal places:
describe products;
alter table products
modify column price decimal(12,2);
-- Add a column `is_verified` to reviews (default FALSE):
select * from reviews;
alter table reviews
add column is_verified boolean default FALSE;

-- Remove the `description` column from products (no longer needed):
select * from products;
alter table products
drop column description;

select * from products where category = '';
-- Accessories / Peripherals /Computers / Mobile
update products
set category = "Mobile"
where product_id in(28, 60, 66);
select * from products;
update products
set category = "Accessories"
where product_id in(8, 17, 19, 20, 38, 58, 68, 82, 94, 95);

update products
set category = "Peripherals"
where product_id = 40;

update products
set category = "Mobile"
where product_id in(5, 54, 88);





