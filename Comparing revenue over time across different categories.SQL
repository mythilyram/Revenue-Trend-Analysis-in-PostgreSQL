Welcome
Hello and welcome to the last part of our course.
Previously, we learned to create reports showing revenue values across different periods. 
-----------------------------------------
In this part, we'll extend that knowledge by learning how we can compare revenue for various categories. 
Comparing multiple categories is just an example – this part aims to teach you how you can compare various segments of your business. 
The same rules apply to comparing revenue from multiple departments or cities.
------------------------------------------------------------
In this part we'll learn how to extend the revenue reports we discussed in previous parts to show revenue across multiple categories. 
First, we'll create reports showing total revenue in a given period of time in multiple categories:

category	revenue
Seafood	131261.75
Meat/Poultry	163022.37
Condiments	106047.11
We can also extend this report to show what percentage of the total revenue is made by each category. An example report can look like this:

category	revenue	%
Seafood	131261.75	33
Meat/Poultry	163022.37	41
Condiments	106047.11	26
Next, we'll learn how to compare revenue in multiple periods of time across multiple categories. 
This example report shows the revenue in 2016, 2017, and 2018: the total revenue and revenue for the beverages and seafood categories:

year	total	beverages	seafood
2016-01-01 00:00:00	208083.98	47919.00	19391.23
2017-01-01 00:00:00	617085.27	103924.32	66959.22
2018-01-01 00:00:00	440623.93	116024.88	44911.30
As we did often, we'll learn how to show the delta (difference) between the periods instead of the revenue:

year	total_delta	beverages_delta	sea_food_delta
2016-01-01 00:00:00	null	null	null
2017-01-01 00:00:00	409001.29	56005.32	47567.99
2018-01-01 00:00:00	-176461.34	12100.56	-22047.92
If we want to show revenue for many categories, it's convenient to "flip" the report to show time periods as columns and the categories as rows:

category	total	2016	2017	2018
Confections	167357.26	29685.56	82657.75	55013.95
Meat/Poultry	163022.37	28813.66	80975.12	53233.59
Produce	99984.57	13885.78	54940.76	31158.03
Are you ready?

=================================================================================

Getting information from the right tables
Before we start creating reports that use product categories, let's get comfortable with joining tables. 
Look at the following query:

SELECT
  p.product_name,
  c.category_name,
  oi.amount
FROM order_items oi
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE order_id = 10480;
The query returns some basic order info by selecting columns from three tables: the product name from products, 
the category name from categories, and the amount paid from order_items. 
Notice the JOINs we use here; we'll have to join these three tables quite often in this part.

Exercise
For all order items from the order with the ID of 10498, show the following columns:

product_id
category_name
product_name
amount

SELECT
  p.product_id,
  c.category_name,
  P.product_name,
  oi.amount
FROM order_items oi
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE order_id = 10498;

product_id	category_name	product_name	amount
24	Beverages	Guaraná Fantástica	63.00
40	Seafood	Boston Crab Meat	92.00
42	Grains/Cereals	Singaporean Hokkien Fried Mee	420.00

-----------------------------------

History-to-date revenue in categories
Good! Let's get started. There are two queries which we can use for total revenue as follows:

SELECT SUM(amount) AS total_revenue
FROM orders;
or:

SELECT SUM(amount) AS total_revenue
FROM order_items;
Now, let's say we want to show the history-to-date revenue for various categories:

category_name	total_revenue
Seafood	131261.75
Meat/Poultry	163022.37
Condiments	106047.11

Such a report can help us discover which product categories are more profitable. 
In this case, we can only use the second query (the one with the order_items table). 
Take a look:

SELECT 
  category_name,
  SUM(amount) AS total_revenue 
FROM order_items oi
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
GROUP BY category_name;

This query is a bit more complicated because we had to join order_items with 
products and categories to get the category names used in the report.

Exercise
Run the template query and see how it generates a row with the history-to-date revenue for each category.
category_name	total_revenue
Grains/Cereals	95744.60
Seafood	131261.77
Meat/Poultry	163022.38
Beverages	267868.20
Dairy Products	234507.32
Produce	99984.58
Condiments	106047.15
Confections	167357.29
-----------------------------------------------------------------
History-to-date revenue in categories with filtering
Nice! We can also use additional filters when we calculate the total revenue in each category. 
For instance, if we wanted to show the total revenue in each category for orders placed in 2016,
we could use the following query:

SELECT 
  category_name,
  SUM(oi.amount) AS total_revenue 
FROM order_items oi
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE order_date >= '2016-01-01'
  AND order_date < '2017-01-01'
GROUP BY category_name;

Note that to filter the order_date column, we joined the order_items and orders tables.

Exercise
Generate a history-to-date category revenue report based on orders shipped to the United States. 
The names of the columns should be category_name and total_revenue.
SELECT 
  category_name,
  SUM(oi.amount) AS total_revenue 
FROM order_items oi
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE ship_country = 'USA'
GROUP BY category_name;
---------------------------------------------JUST Changed where condn---------------
Revenue in categories – exercise
Perfect! Let's try an additional exercise.

Exercise
For all orders placed in the first six months of 2017, 
calculate the total revenue for all categories. 
Show two columns: category_name and total_revenue.
SELECT
	category_name,
    SUM(oi.amount) as total_revenue
FROM order_items oi
JOIN products p
USING (product_id)
JOIN categories
USING (category_id)
JOIN orders o
USING (order_id)
WHERE -- order_date >= '2017-01-01'AND order_date < '2017-07-01' -----------both condn works-----
  EXTRACT(YEAR FROM order_date) = 2017 AND EXTRACT(MONTH FROM order_date) < 7
GROUP BY category_name
ORDER BY category_name
-------
category_name	total_revenue
Beverages	61368.91
Condiments	25878.78
Confections	40720.26
Dairy Products	49047.12
Grains/Cereals	27566.60
Meat/Poultry	32334.80
Produce	23878.48
Seafood	20671.07
---------------------------

Category revenue with total revenue
Excellent! Now, we want to show the total revenue (as a reference point) next to the revenue of each category. We can use the following trick:

WITH all_categories AS (
  SELECT SUM(amount) AS total_sum
  FROM orders
)
SELECT 
  category_name,
  SUM(oi.amount) AS category_revenue,
  ac.total_sum
FROM all_categories ac, order_items oi =================NOTE:========= CTE_tbl , tbl1 and then only used JOIN other tbls. it works....see below for explanation-------
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
GROUP BY
  category_name,
  ac.total_sum;
-----o/p---------
category_name	category_revenue	total_sum
Dairy Products	234507.32	1265793.29
Meat/Poultry	163022.38	1265793.29
Seafood	131261.77	1265793.29
Condiments	106047.15	1265793.29
Grains/Cereals	95744.60	1265793.29
Beverages	267868.20	1265793.29
Produce	99984.58	1265793.29
Confections	167357.29	1265793.29

The new construction you can see is called a Common Table Expression (CTE). 
It creates a temporary table named all_categories that has a single column named total_sum.
In the outer query, we add this temporary table to the FROM clause. 
We don't need a JOIN because we're separating all_categories from order_items with a comma. ---------------------------------explanation ----------------------------
This indicates they are two different tables and they cannot be joined for a given column. 
Separating two tables with a comma means that each row from the first table will be joined with each row from the second table. ----------cross join?---------
In our case, all_categories contains only a single row, so that row will be added to each row of order_items before any other joins are made.

We can then add the total_sum column from all_categories as the third column in the SELECT clause. 
We also add total_sum in the GROUP BY clause.

Exercise
Create a report that shows the category revenue values for all orders placed in 2017. 
Show three columns: category_name, category_revenue, and total_sum. 
The last column should show the total revenue from 2017 for all rows.

Category revenue with revenue ratio
Good job! Now that we know how to add total_revenue as the last column, we can calculate the ratio between a category's revenue and total revenue. Such a report can help us quickly identify which categories generate the most revenue. Here's the query:

WITH all_categories AS (
  SELECT SUM(amount) AS total_sum
  FROM orders
)
SELECT 
  category_name,
  SUM(oi.amount) AS category_revenue,
  1.0 * SUM(oi.amount) / ac.total_sum AS total_revenue_ratio
FROM all_categories ac, order_items oi
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
GROUP BY 
  category_name,
  ac.total_sum;
In the third column, we now divide category revenue by total revenue and get the correct ratio. 
We multiply the numerator by 1.0 to avoid integer division.

Exercise
Create a report of the category revenue for all orders placed in 2017 or later. 
Show three columns: category_name, category_revenue, and total_revenue_percentage. 
The last column should show the rounded to two decimal places percentage of the total revenue generated by that category.
