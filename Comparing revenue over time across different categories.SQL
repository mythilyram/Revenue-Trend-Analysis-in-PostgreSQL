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

WITH all_categories AS (
  SELECT SUM(amount) AS total_sum
  FROM orders
  WHERE order_date >= '2017-01-01'
)
SELECT 
  category_name,
  SUM(oi.amount) AS category_revenue,
  round(100.0 * SUM(oi.amount) / ac.total_sum,2) AS total_revenue_percentage
FROM all_categories ac, order_items oi
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE EXTRACT(YEAR FROM Order_date) >= 2017
  GROUP BY 
  category_name,
  ac.total_sum
  ;
----------------------
Category revenue with revenue ratio – exercise
Well done! It's time for an additional exercise.

Exercise
Create a report of the category revenue for orders shipped to Germany. 
Show three columns: category_name, category_revenue, and total_revenue_ratio. 
The last column should show the ratio of category revenue to total revenue generated by orders shipped to Germany.
--------------where condn changed  - to germany-----------
WITH all_categories AS (
  SELECT
   SUM(amount) as total_sum
   FROM ORDERS
   WHERE ship_country = 'Germany'
  )
  SELECT category_name,
  SUM(oi.amount) AS category_revenue,
  (1.0 * SUM(oi.amount) / ac.total_sum) AS total_revenue_ratio
FROM all_categories ac, order_items oi
JOIN orders o
  ON o.order_id = oi.order_id
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
WHERE ship_country = 'Germany'
  GROUP BY 
  category_name,
  ac.total_sum
  ;
=-----------------
Revenue for all time periods for selected categories:

Perfect! Next, we'd like to compare revenue values in selected categories year-to-year, quarter-to-quarter, etc. 
This way, we can analyze whether the category revenue increases or decreases over time.

The report should look like this:

revenue_year	    total_revenue	beverages_revenue	seafood_revenue
2016-01-01 00:00:00+00	208083.99	47919.00	19391.23
2017-01-01 00:00:00+00	617085.35	103924.32	66959.24
2018-01-01 00:00:00+00	193637.42	61844.55	25079.36

We could use the following query:

SELECT 
  DATE_TRUNC('year', order_date) AS revenue_year,
  SUM(oi.amount) AS total_revenue, 
  SUM(CASE
    WHEN c.category_name = 'Beverages'
      THEN oi.amount
    ELSE 0.0
  END) AS beverages_revenue,
  SUM(CASE
    WHEN c.category_name = 'Seafood'
      THEN oi.amount
    ELSE 0.0
  END) AS seafood_revenue 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
As you can see, the second column contains the total revenue, which is a simple SUM() of all the values in the amount column.
However, we also added two columns that use the SUM(CASE WHEN...) construction.
These will select only the amount values for specific categories.

This type of report is typically used when there are few categories to compare over many reporting periods.

Exercise
For each year and quarter, calculate the revenue for the 'Condiments' and 'Confections' categories. 
Show the following columns: revenue_quarter, total_revenue, condiments_revenue, and confections_revenue. Order the results by year and quarter.

SELECT 
  DATE_TRUNC('quarter', order_date) AS revenue_quarter,
  SUM(oi.amount) AS total_revenue, 
  SUM(CASE
    WHEN c.category_name = 'Condiments'
      THEN oi.amount
    ELSE 0.0
  END) AS condiments_revenue,
  SUM(CASE
    WHEN c.category_name = 'Confections'
      THEN oi.amount
    ELSE 0.0
  END) AS confections_revenue 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY DATE_TRUNC('quarter', order_date) 
ORDER BY DATE_TRUNC('quarter', order_date);

------------
Revenue for all time periods for selected categories – exercise
Good job! Let's try another exercise before we move on.

Exercise
For each month of 2017, calculate the total revenue, and the revenue for the 'Dairy Products' and 'Seafood' categories.
Show the following columns: revenue_month, total_revenue, dairy_revenue, and seafood_revenue.
Use 0.0 for the ELSE case of CASE WHEN. Order the results by month.

SELECT 
  DATE_TRUNC('month', order_date) AS revenue_month,
  SUM(oi.amount) AS total_revenue, 
  SUM(CASE
    WHEN c.category_name = 'Dairy Products'
      THEN oi.amount
    ELSE 0.0
  END) AS dairy_revenue,
  SUM(CASE
    WHEN c.category_name = 'Seafood'
      THEN oi.amount
    ELSE 0.0
  END) AS seafood_revenue 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
WHERE order_date >= '2017-01-01'
  AND order_date < '2018-01-01'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

-------------
Revenue delta in all time periods for selected categories
Great work! We can also create another version of this report by changing revenue values into revenue deltas. The end result should look like this:

revenue_year	total_revenue_delta	beverages_revenue_delta	seafood_revenue_delta
2016-01-01 00:00:00+00	null	null	null
2017-01-01 00:00:00+00	409001.36	56005.32	47568.01
2018-01-01 00:00:00+00	-423447.93	-42079.77	-41879.88
We can use the following query:

SELECT 
  DATE_TRUNC('year', order_date) AS revenue_year,
  SUM(oi.amount) - LAG(SUM(oi.amount)) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS total_revenue_delta, 
  SUM(CASE WHEN c.category_name = 'Beverages' THEN oi.amount ELSE 0.0 END)
  - LAG(SUM(CASE WHEN c.category_name = 'Beverages' THEN oi.amount ELSE 0.0 END)) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS beverages_revenue_delta,
  SUM(CASE WHEN c.category_name = 'Seafood' THEN oi.amount ELSE 0.0 END)
  - LAG(SUM(CASE WHEN c.category_name = 'Seafood' THEN oi.amount ELSE 0.0 END)) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS seafood_revenue_delta 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
We now calculate each column as the sum from the current year (SUM(oi.amount)) minus the sum from the previous year:

LAG(SUM(oi.amount)) OVER (ORDER BY DATE_TRUNC('year', order_date))
To that end, we used the LAG() OVER() pattern we learned in the previous part.

Exercise
Create a report similar to the one shown in the explanation. 
This time, however, show the revenue changes in the four quarters of 2017 for the 'Produce' and 'Confections' categories. 
Show the following columns: revenue_quarter, total_revenue_delta, produce_revenue_delta, and confections_revenue_delta.

51. SELECT 
  DATE_TRUNC('quarter', order_date) AS revenue_quarter,
  SUM(oi.amount) - LAG(SUM(oi.amount)) OVER (ORDER BY DATE_TRUNC('quarter', order_date)) AS total_revenue_delta, 
  SUM(CASE WHEN c.category_name='Produce' THEN oi.amount ELSE 0.0 END) - 
  LAG(SUM(CASE WHEN c.category_name='Produce' THEN oi.amount ELSE 0.0 END)) OVER(
    ORDER BY DATE_TRUNC('quarter', order_date)) AS produce_revenue_delta,
  SUM(CASE WHEN c.category_name='Confections' THEN oi.amount ELSE 0.0 END) - LAG(SUM(
    CASE WHEN c.category_name='Confections' THEN oi.amount ELSE 0.0 END)) OVER(
      ORDER BY DATE_TRUNC('quarter', order_date)) AS confections_revenue_delta 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
WHERE order_date >= '2017-01-01'
  AND order_date < '2018-01-01' 
GROUP BY DATE_TRUNC('quarter', order_date)
ORDER BY DATE_TRUNC('quarter', order_date);

--------------------
============================================================================================================
ROWS -> COLUMNS
=================================================================================================================
Revenue in all categories for selected periods
Very well done! Now, our previous report showed the categories as columns and the time periods as rows. We can switch this, showing the time periods as columns and the categories as rows. The report will look like this:

category_name	overall_category_revenue	revenue_2016	revenue_2017	revenue_2018
Confections	167357.26	29685.56	82657.75	55013.95
Meat/Poultry	163022.37	28813.66	80975.12	53233.59
Produce	99984.57	13885.78	54940.76	31158.03
Take a look at the query:

SELECT
  category_name,
  SUM(oi.amount) AS overall_category_revenue,
  SUM(CASE WHEN order_date >= '2016-01-01' AND order_date < '2017-01-01' THEN oi.amount ELSE 0.0 END) AS revenue_2016,
  SUM(CASE WHEN order_date >= '2017-01-01' AND order_date < '2018-01-01' THEN oi.amount ELSE 0.0 END) AS revenue_2017,
  SUM(CASE WHEN order_date >= '2018-01-01' AND order_date < '2019-01-01' THEN oi.amount ELSE 0.0 END) AS revenue_2018
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY
  c.category_id,
  category_name;
This time we don't group by time periods. Instead, we group by product categories. On the other hand, we have to define separate columns, using SUM(CASE WHEN...) for each period we want to compare.

This report format is useful when we have many categories to compare but few time periods.

Exercise
Show the category revenue for each quarter of 2017. Show the following columns: category_name, overall_category_revenue, revenue_Q1, revenue_Q2, revenue_Q3, and revenue_Q4.
/*SELECT
	category_name,
  SUM(oi.amount) AS overall_category_revenue,
  SUM(CASE WHEN order_date >= '2017-01-01' AND order_date < '2017-04-01' THEN oi.amount ELSE 0.0 END) AS revenue_Q1,
  SUM(CASE WHEN order_date >= '2017-04-01' AND order_date < '2017-07-01' THEN oi.amount ELSE 0.0 END) AS revenue_Q2,
  SUM(CASE WHEN order_date >= '2017-07-01' AND order_date < '2017-10-01' THEN oi.amount ELSE 0.0 END) AS revenue_Q3,
  SUM(CASE WHEN order_date >= '2017-10-01' AND order_date < '2018-01-01' THEN oi.amount ELSE 0.0 END) AS revenue_Q4
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY
  c.category_id,
  category_name;*/
--------------1st is my solution . did not work----------below is from the site----------
SELECT
  category_name,
  SUM(oi.amount) AS overall_category_revenue,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN oi.amount ELSE 0.0 END) AS revenue_Q1,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 2 THEN oi.amount ELSE 0.0 END) AS revenue_Q2,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 3 THEN oi.amount ELSE 0.0 END) AS revenue_Q3,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 4 THEN oi.amount ELSE 0.0 END) AS revenue_Q4
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
WHERE order_date >= '2017-01-01'
  AND order_date < '2018-01-01'
GROUP BY
  c.category_id,
  category_name;
-----------------------
Revenue in all categories for selected periods – exercise
Excellent! Let's try a similar exercise.

Exercise
Compare the category revenues for orders placed in December 2016 and December 2017. Show the following columns: category_name, december_2016, and december_2017.

-------- changed only dates--------
SELECT
	category_name,
  SUM(CASE WHEN order_date >= '2016-12-01' AND order_date < '2017-01-01' THEN oi.amount ELSE 0.0 END) AS december_2016,
  SUM(CASE WHEN order_date >= '2017-12-01' AND order_date < '2018-01-01' THEN oi.amount ELSE 0.0 END) AS december_2017
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY
  c.category_id,
  category_name;
=------------------------
Revenue change in all categories for selected periods
Well done! We can create another version of the same report, this one showing revenue deltas. We'd like to get a report like this:

category_name	overall_category_revenue	revenue_2016	change_2017	change_2018
Confections	167357.26	29685.56	52972.19	-27643.80
Meat/Poultry	163022.37	28813.66	52161.46	-27741.53
To that end, we can use the query below:

SELECT
  category_name,
  SUM(oi.amount) AS overall_category_revenue,

  SUM(CASE WHEN order_date >= '2016-01-01' AND order_date < '2017-01-01' THEN oi.amount ELSE 0.0 END) AS revenue_2016,

  SUM(CASE WHEN order_date >= '2017-01-01' AND order_date < '2018-01-01' THEN oi.amount ELSE 0.0 END)
    - SUM(CASE WHEN order_date >= '2016-01-01' AND order_date < '2017-01-01' THEN oi.amount ELSE 0.0 END) AS change_2017,

  SUM(CASE WHEN order_date >= '2018-01-01' AND order_date < '2019-01-01' THEN oi.amount ELSE 0.0 END)
    - SUM(CASE WHEN order_date >= '2017-01-01' AND order_date < '2018-01-01' THEN oi.amount ELSE 0.0 END) AS change_2018

FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY
  c.category_id,
  category_name;
As you can see, the last two columns subtract the previous year's sum from the current year's sum.

Exercise
Create a report similar to the one shown in the explanation.
This time, however, show the revenue in the first quarter of 2017 and the revenue changes in the next three quarters of 2017.
Show the following columns: category_name, overall_category_revenue_2017, revenue_2017_Q1, change_Q2, change_Q3, and change_Q4.

SELECT
  category_name,
  SUM(oi.amount) AS overall_category_revenue_2017,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN oi.amount ELSE 0.0 END) AS revenue_2017_Q1,
  
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 2 THEN oi.amount ELSE 0.0 END) -
  	SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN oi.amount ELSE 0.0 END)AS change_Q2,
    
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 3 THEN oi.amount ELSE 0.0 END)-
  	SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 2 THEN oi.amount ELSE 0.0 END) AS change_Q3,
    
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 4 THEN oi.amount ELSE 0.0 END) -
  	SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 3 THEN oi.amount ELSE 0.0 END) AS change_Q4
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
WHERE order_date >= '2017-01-01'
  AND order_date < '2018-01-01'
GROUP BY
  c.category_id,
  category_name;

========================================================Summary ======================================================
Summary
Good job! Before we move on to the final quiz for this course, let's review what we've learned:

To create a report with history-to-date category revenue values:
SELECT 
  category_name,
  SUM(amount) AS total_revenue 
FROM order_items oi
JOIN products p
  ON oi.product_id = p.product_id
JOIN categories c
  ON p.category_id = c.category_id
GROUP BY category_name;
To show category revenue values and their relation to the total revenue, use:
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
To show the category revenue for selected categories for each time period or category revenue for each category and selected time periods, use SUM(CASE WHEN) along with GROUP BY. For instance:
SELECT 
  DATE_TRUNC('year', order_date) AS revenue_year,
  SUM(oi.amount) AS total_revenue, 
  SUM(CASE WHEN c.category_name = 'Beverages' THEN oi.amount ELSE 0.0 END) AS beverages_revenue,
  SUM(CASE WHEN c.category_name = 'Seafood' THEN oi.amount ELSE 0.0 END) AS seafood_revenue 
FROM order_items oi 
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN categories c
  ON c.category_id = p.category_id
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);




Question 1
Okay, let's start with Question 1.

Exercise
For all orders placed in the first three months of 2017, show the total revenue for all categories. Show the following columns: category_name and total_revenue.

SELECT
	category_name,
	SUM(oi.amount) as total_revenue
FROM order_items oi
JOIN products p
USING (product_id)
JOIN categories c
USING(category_id)
JOIN orders o
USING(order_id)
WHERE order_date >= '2017-01-01' AND order_date < '2017-04-01'
GROUP BY category_name

Question 2
Very good! Let's move on to Question 2.

Exercise
For each category, find the December 2016 revenue and show it alongside the ratio of that category's revenue to the total revenue for December 2016. 
Show the following columns: category_name, category_revenue, and total_revenue_ratio. Round the total_revenue_ratio to 2 decimal places.

WITH TOT_DEC_2016_REVENUE AS(
  SELECT 
  	SUM(O.amount) as total_revenue_dec2017
  FROM orders O
  WHERE order_date >= '2016-12-01' AND order_date < '2017-01-01'
  )
SELECT
	category_name,
    SUM(oi.amount) as category_revenue,:::::::::::::::::::::::::::::::::::::::::::::::::o.amount gives wrong answer:::::::::::::::::::::
    ROUND(1.0*SUM(oi.amount)/total_revenue_dec2017,2) as total_revenue_ratio
FROM TOT_DEC_2016_REVENUE, order_items oi
JOIN products p
USING (product_id)
JOIN categories c
USING(category_id)
JOIN orders o
USING(order_id)
WHERE order_date >= '2016-12-01' AND order_date < '2017-01-01'
GROUP BY category_name,total_revenue_dec2017
---------------
Question 3
Well done! Are you ready to tackle the third and final problem?

Exercise
For each year, find the revenue for the 'Grains/Cereals' and 'Meat/Poultry' categories, based on orders shipped to France, Germany, and Italy. 
Show the following columns: revenue_year, total_revenue, grains_revenue, and meat_revenue. Use 0.0 for the ELSE case of CASE WHEN. Order the results by year.

SELECT
	DATE_TRUNC('year', order_date) AS revenue_year,
    SUM(oi.amount) as total_revenue,
    SUM(CASE WHEN category_name='Grains/Cereals' THEN oi.amount ELSE 0.0 END) AS grains_revenue,
    SUM(CASE WHEN category_name='Meat/Poultry' THEN oi.amount ELSE 0.0 END) AS meat_revenue
FROM orders o
JOIN order_items oi
USING(order_id)
JOIN products p
USING (product_id)
JOIN categories c
USING(category_id)
WHERE ship_country IN ('France', 'Germany', 'Italy')
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date)
