-- Data Audit/Sanity Check: 
SELECT * FROM customers LIMIT 10;
 DESCRIBE customers;
   SELECT COUNT(*) FROM customers;
--  >Missing data 

SELECT * FROM order_items LIMIT 10;
 DESCRIBE order_items;
SELECT COUNT(*) FROM order_items;
-- Missing Entire Table Data & Foreign Keys for orders & products 

SELECT * FROM orders LIMIT 10;
DESCRIBE orders;
SELECT COUNT(*) FROM orders;
-- Order_id missing #8 row / order status is missing/ order dates & delivery dates are not in chronological order/ letter casing is Capitalized in some categories
-- Missign Foreign key on customer_id 

SELECT * FROM products limit 10;
DESCRIBE products;
SELECT COUNT(*) FROM products;
-- Missing data from category field, letter casing on Brand column, Missing Descriptions 

SELECT * FROM reviews limit 10;
DESCRIBE reviews;
SELECT COUNT(*) from reviews;
-- Foreign Keys for Order Id, product ID, customer ID
-- Review Date is not chronological 
-- Review ID order need to correspond to Review Date 
-- Review Text field is empty - can fill with "no comment"


   