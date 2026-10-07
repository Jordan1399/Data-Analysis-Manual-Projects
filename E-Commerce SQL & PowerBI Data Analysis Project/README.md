# E-Commerce SQL & PowerBI Data Analysis Project

An end-to-end e-commerce data analysis exercise using MySQL scripts and Power BI artifacts. The project includes both uncleaned input CSVs and CSV exports of transformed SQL tables/views.

> **Public-data privacy note:** Customer names in the published copies are replaced with stable `Customer NNN` labels, email addresses use the reserved `.invalid` domain, and phone values are blanked, and customer-specific contact literals in the public SQL copy are replaced with safe placeholders. The original source files were not changed. The Power Query customer preview and customer-summary preview screenshots were excluded because they expose customer records; other dashboard, model, and type-audit screenshots are retained.

## Repository contents

- [`01_Uncleaned_Data/`](01_Uncleaned_Data/) — uncleaned CSV inputs for customers, products, orders, order items, and reviews.
- [`02_SQL_Cleaning&Querying/`](02_SQL_Cleaning%26Querying/) — phased MySQL scripts covering data auditing, cleaning and transformation, exploratory analysis, related-table joins, window functions, aggregations/business insights, additional business questions, indexes, views, and stored procedures.
- [`03_Exported_sql_Tables/`](03_Exported_sql_Tables/) — CSV exports for customers, products, orders, order items, reviews, and the customer summary, daily sales, and product performance views.
- [`04_PowerBI_Visualisations&ETL/`](04_PowerBI_Visualisations%26ETL/) — dashboard screenshots for product performance, revenue by state, and reviews/ratings; Power Query type-audit screenshots; view type checks; and a data-model screenshot. The Power BI report file itself is not included.

## Analysis coverage evidenced in the files

The SQL phases include checks for missing or inconsistent data, cleaning and transformation queries, exploratory queries, joins across the relational entities, ranking and time-based window calculations, aggregations, and additional business questions. Separate scripts define indexes, reusable views, and stored procedures. The named output views are a customer summary, daily sales, and product performance.

The Power BI evidence includes Power Query type checks for orders, products, order items, reviews, and the exported views, a data-model relationship check, and dashboards for product performance, revenue by state, and reviews/ratings.

## Using the project

The scripts use **MySQL** syntax (including `LIMIT`, `DESCRIBE`, `DATE_FORMAT`, and MySQL procedure definitions). They operate on tables such as `customers`, `products`, `orders`, `order_items`, and `reviews`; review each phase script before running it against a database. The repository includes no database creation/schema script, so load or create the expected tables before running the analysis scripts.

For Power BI, import the relevant exported CSVs or connect to a database containing the expected tables/views, then use the screenshots as evidence of the documented model and visuals. No `.pbix` file is present in the source project.
