# Revenue-Trend-Analysis-in-PostgreSQL
Revenue Trend Analysis in PostgreSQL
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/e5048e99-f755-41ed-904f-3939a1711e2e)


Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods - Showing total revenue on all aggregation levels – 1
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/74d4f3dd-d76f-4d36-b563-6cb3408f9f24)

Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods- Showing total revenue on all aggregation levels – 2
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/7b3f63f2-b761-40e7-a423-54231b91e89d)

Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods - Showing total revenue for a previous period - LAG() – explanation
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/7d2083b3-1a26-4ab3-a650-96d69b874811)

Overview

1-6. Getting to know the database

7-14 Basic revenue metrics

    - Revenue to date - sum(amt),     - given a category / ship_country use WHERE
    - Revenue to date by group
    - Time constraints in revenue reports - 
        - WHERE o.order_date >= '2017-03-01' AND o.order_date < '2017-04-01'
        - based on orders from **March 2017**
        - date format that we used: YYYY-MM-DD.
	
    - Another WAY: **date::DATE + INTERVAL 'number' interval**
        - where: interval – the interval we want to add, such as year, month or day.
        - number – the amount of that interval to add.
        - date – the date to be modified.
            - eg: WHERE o.order_date >= '2017-03-01'  AND o.order_date < '2017-03-01'::DATE + INTERVAL '1' month
        - Quarter
            - '2018-01-01'::DATE + INTERVAL '3' month	
            - where order_date >= '2018-01-01'    and order_date <= '2018-01-01'::DATE + INTERVAL '3' month
	    
    - Calculating the beginning of the current period (e.g. the current day, month, year, etc.). 
    This will help us create revenue reports for the current year, month, quarter, etc. 
	    - In PostgreSQL there is a function named DATE_TRUNC(). 
        - SELECT DATE_TRUNC('month', CURRENT_TIMESTAMP) AS current_month_start;
            -  CURRENT_TIMESTAMP returns the current date and time.
            - The DATE_TRUNC() function has two arguments: 
                - the text defining precision, e.g., 'minute', 'hour', 'day', 'month', 'quarter', or 'year'.
                - the date that is to be rounded down with a precision defined in the first argument.
                    -The DATE_TRUNC() function returns a timestamp with unwanted details removed, 
                    - e.g., the result of: SELECT DATE_TRUNC('day', '2019-09-09 12:31:08.5'::timestamp)
                    - is 2019-09-09 00:00:00.0 
                    - and the result of: SELECT DATE_TRUNC('year', '2018-07-10'::timestamp)
                    - is 2018-01-01 00:00:00.0.
		    
    - **revenue reports for the current year, month**, etc. 
	- They're another frequent financial report, and they show how much the company earned so far in the given current period. 
	    - Commonly used report types are:
        - year-to-date (YTD) – refers to the period beginning the first day of the current calendar year up to the current date.
        - month-to-date (MTD) – refers to the period of time between the 1st of the current month and the current date.
        - quarter-to-date (QTD) – refers to the period of time between the beginning of the current quarter and the current date.
        - YTD, MTD, and QTD reports are used by business owners, investors, and individuals to analyze their revenue, income, 
	business earnings, and investment returns for the current period of time.
            - For example, if we want to show the month-to-date revenue:
            - **WHERE order_date >= DATE_TRUNC('month', CURRENT_TIMESTAMP)**

15 Summary

    - To find rows for three months starting from March 20, 2017, use:
    	- SELECT ... FROM ...
     	WHERE column_name >= '2017-03-20'
     	AND column_name < '2017-03-20'::DATE + INTERVAL '3' month
    - To find rows for the current month, use:
    	- SELECT ... FROM ...
     	- WHERE column_name >= DATE_TRUNC('month', CURRENT_TIMESTAMP)

--------------------------------------------------------------------------
Comparing revenue across different periods
---------------------------------------------------------------------------
19. we'll talk about reports with total revenue for multiple periods of time - year 1, year 2, year 3.....Calculating Delta..,delta %
20. Total revenue for multiple periods
    
-  Showing the total revenue for each year
- we'll compare revenue values between consecutive years, months, or any other time periods.
		- Such reports are commonly called **year-to-year, quarter-to-quarter, and month-to-month** reports.
		
  		SELECT
 			DATE_TRUNC('year', order_date) AS revenue_year,
 			SUM(amount) AS total_revenue
 		FROM orders
 		GROUP BY revenue_year
		ORDER BY revenue_year;
 - 21 Showing total revenue for each month and quarter

    		Select
  			DATE_TRUNC('month', order_date) AS month_in_2016,
 			SUM()
		FROM
  		WHERE order_date >= '2016-01-01'   AND order_date < '2017-01-01'
  		GROUP BY month_in_2016
  		ORDER BY month_in_2016
  			month_in_2016	total_revenue
    			...		...
    			2016-08-01 00:00:00+00	25485.28
    			2016-09-01 00:00:00+00	26381.40
    			2016-10-01 00:00:00+00	37515.73
  - 22 THe EXTRACT() function
     
    	SELECT
    	  EXTRACT(year FROM order_date) AS revenue_year,
    	  SUM(amount) AS total_revenue
    	FROM orders
    	GROUP BY EXTRACT(year FROM order_date)
    	ORDER BY EXTRACT(year FROM order_date);
			revenue_year	total_revenue
			...		...
    			2016	208083.98
    			2017	617085.21
    			2018	440623.90
  - 23  To show the monthly revenue in each year we must use the EXTRACT() function twice.

         SELECT
    	  	EXTRACT(year FROM order_date) AS revenue_year,
     		EXTRACT(month FROM order_date) AS revenue_month,
    	  	SUM(amount) AS total_revenue
    	 FROM orders
    	 GROUP BY EXTRACT(year FROM order_date)
    		EXTRACT(month FROM order_date)
    	 ORDER BY EXTRACT(year FROM order_date)
     		EXTRACT(month FROM order_date);
			revenue_year	revenue_month	total_revenue
			...		...		...
    			2016		4		128355.40
     			2017		1		138288.95
     			2017		2		143177.03
     	- Note two things:
		- months are shown as integers from 1 to 12.
		- months don't contain any information about the year.
  - 
    		- If you only grouped by the month, you'd get monthly revenue values summed across all years.
    		- In other words, the January revenue would show the sum of January 2016, January 2017, and January 2018.
    		- To avoid that, we used EXTRACT() twice, with either year or month as the first argument. We also group all rows by both the year and month columns.

 - 24 Using the EXTRACT() function in PostgreSQL to generate revenue in period report is tricky, because you have to use it twice to tell apart years and months.

    - However, there is one scenario when EXTRACT() is useful. 
	- Let’s say we want a report containing:
   		- quarterly revenue values.
   		- annual revenue values.
     q		-  the grand total revenue value.
		- Here's an example of the result we'd like to achieve:  SEE PIC 2 IN rollup – result example
  - ![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/74d4f3dd-d76f-4d36-b563-6cb3408f9f24)

				 SELECT
					  EXTRACT(year FROM order_date) AS revenue_year,
					  EXTRACT(quarter FROM order_date) AS revenue_quarter,
					  SUM(amount) AS total_revenue
				FROM orders
				GROUP BY ROLLUP(
					  EXTRACT(year FROM order_date),
					  EXTRACT(quarter FROM order_date)
    				)
				ORDER BY
				  EXTRACT(year FROM order_date), 
				  EXTRACT(quarter FROM order_date);
    
    		- As you can see, we've got rows showing three aggregation levels: 
		the grand total revenue, annual revenues, and the quarterly revenues for each year.
		
		In other words, now you can see:
		
		the grand total revenue – the total sum for all years (revenue_year and revenue_quarter being NULL).
		the annual revenues – the sums for each year (revenue_quarter being NULL).
		the sums for each year and quarter (being the results of the query from the pevious exercise).
- 25 In PostgreSQL, ROLLUP() is an extension of GROUP BY.
  
		Inside the brackets, we provide all the columns that we want to group the rows by. 
		ROLLUP() first groups the rows by both columns (in this case, year and quarter) to compute quarterly sums. 
		Then, it groups all rows by the first column inside the parentheses (year) to compute the annual sums. 
		Finally, it computes a grand total, i.e. as if we didn't group the rows by anything.
		
		As a general rule, ROLLUP() always creates new grouping combinations by removing columns one by one,
  		starting from the right:
		
		GROUP BY ROLLUP (A, B, C) =
		GROUP BY (A, B, C) +
		GROUP BY (A, B) +
		GROUP BY (A) +
		GROUP BY ()
		The diagram below explains where the resulting rows come from:
    ![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/7b3f63f2-b761-40e7-a423-54231b91e89d)
  
--------------Calculating Deltas -----------------------------
- 26,27 Showing total revenue for a previous period
		
		SELECT
		  DATE_TRUNC('year', order_date) AS revenue_year, 
		  SUM(amount) AS total_revenue,			----------> each year  
		  LAG(SUM(amount), 1) OVER(ORDER BY DATE_TRUNC('year', order_date))
  					AS previous_year_revenue------->Prev yr
		FROM orders
		GROUP BY DATE_TRUNC('year', order_date)
		ORDER BY DATE_TRUNC('year', order_date);
		We used DATE_TRUNC() function as a more efficient way in PostgreSQL than EXTRACT().
  
- 28 Calculating revenue deltas

		 SELECT
		  DATE_TRUNC('year', order_date) AS revenue_year, 
		  SUM(amount) AS total_revenue,
		  SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS delta
		FROM orders
		GROUP BY DATE_TRUNC('year', order_date)
		ORDER BY DATE_TRUNC('year', order_date);

  	Result:
		
		revenue_year	 	total_revenue	delta
		2016-01-01 00:00:00+00	208083.99	null
		2017-01-01 00:00:00+00	617085.35	409001.36
		2018-01-01 00:00:00+00	193637.42	-423447.93

  	- In the delta column, we simply subtracted the revenue generated in the previous year from the revenue generated in the current year. 
	- Once again, we used the LAG() function pattern from the previous exercise.
-29 Exercise -
   - Calculate the total monthly revenue for each month of 2017, along with the revenue change as compared to the previous month. 	- Show three columns: revenue_month, total_revenue, and delta.
	- In the first row, leave the delta value as NULL. Order the rows by month.

			SELECT
				DATE_TRUNC('month', order_date)  as revenue_month, .....................................................DATE_TRUNC('month', order_date) gives 2017-01-01 00:00:00+00
			    sum(amount) as total_revenue,
			     sum(amount) - LAG(sum(amount) ,1) OVER(ORDER BY DATE_TRUNC('month', order_date)) delta
			FROM orders
			WHERE EXTRACT(YEAR FROM order_date) = 2017 .................................................................EXTRACT( YEAR FROM date) GIVES ONLY YEAR PART ie 2017
			GROUP BY DATE_TRUNC('month', order_date)
			ORDER BY DATE_TRUNC('month', order_date)
- 30 Calculating revenue deltas as percentages
	- Here’s the expression we want to calculate:
	- ** 100.0⋅ (total_revenue − previous_year_total_revenue) / previous_year_total_revenue**
	- To avoid integer division we multiply the numerator by 100.0:
		- 100.0 * ((SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))
		- We round the percentage to two decimal places using the ROUND(value, 2) function.	

				SELECT
				  DATE_TRUNC('year', order_date) AS revenue_year, 
				  SUM(amount) AS total_revenue,
				  ROUND(
				    100.0 *
				    (SUM(amount) - LAG(SUM(amount), 1)
				      OVER (ORDER BY DATE_TRUNC('year', order_date)))
				      / (LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date))), ------------difference/prev value *100 rounded to 2 dgt
				    2) AS delta_percentage
				FROM orders
				GROUP BY DATE_TRUNC('year', order_date)
				ORDER BY DATE_TRUNC('year', order_date);
				Here is the result:
				
				revenue_year	total_revenue	delta_percentage
				2016-01-01 00:00:00+00	208083.99	NULL
				2017-01-01 00:00:00+00	617085.35	196.56
				2018-01-01 00:00:00+00	193637.42	-68.62
    
--------------------Creating "revenue in quarters" reports-----------------------------------

32 Creating new columns with custom values - CASE WHEN THEN END
	
	 SELECT
	  order_id,
	  CASE WHEN ship_country IN ('USA', 'Canada', 'Mexico') THEN 'North America' 
	    ELSE 'Elsewhere'
	  END AS continent
	FROM orders;
	We'll obtain the following result:
	
	order_id	continent
	...	...
	10258	Elsewhere
	10259	North America
	10260	Elsewhere
	...	...

 33 Creating columns with custom sums
	-  we want to create two columns that show different order sums based on the ship_country column. 

	SELECT
	  SUM(CASE
	    WHEN ship_country IN ('USA', 'Canada', 'Mexico')
	      THEN amount
	    ELSE 0.0
	  END) AS sum_north_america,
	  SUM(CASE
	    WHEN ship_country NOT IN ('USA', 'Canada', 'Mexico')
	      THEN amount
	    ELSE 0.0
	  END) AS sum_elsewhere
	FROM orders;

	Above, we twice used the CASE WHEN along with the SUM() function. 
	For each row, CASE WHEN checks the value in the ship_country column. 
	The order's amount is only added if the ship_country value matches the given condition. 
	Otherwise, 0.0 is added. 
 	As a result, we'll get the total sum from orders shipped to the USA, Canada, and Mexico 
	in the first column and the total sum from orders shipped to all other countries in the second column.
 34 Creating a "revenue in quarters" report
 	We can now create a new report type. It should look like this:

	year			Q1		Q2		Q3		Q4
	2016-01-01 00:00:00+00	0.00		0.00		79728.58	128355.40
	2017-01-01 00:00:00+00	138288.95	143177.03	153937.83	181681.50
	2018-01-01 00:00:00+00	193637.42	0.00		0.00	0.00
	
	 In other words, we want to see quarterly revenue values in the form of a table, with rows representing years and columns representing quarters. 
  	Such reports can help us see seasonal trends in revenue values. 
   	For instance, Q4 revenues are typically higher because of holiday shopping. 
    	It would be much harder to spot such trends when quarters are shown below each other.

	SELECT
	  DATE_TRUNC('year', order_date) AS year, 
	  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1
	  THEN amount ELSE 0 END) AS Q1,
	  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 2
	  THEN amount ELSE 0 END) AS Q2,
	  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 3
	  THEN amount ELSE 0 END) AS Q3,
	  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 4
	  THEN amount ELSE 0 END) AS Q4
	FROM orders
	GROUP BY DATE_TRUNC('year', order_date)
	ORDER BY DATE_TRUNC('year', order_date);

	In the query above, we grouped all rows by the DATE_TRUNC('year', order_date) value. 
 	We also used SUM(CASE WHEN...) expressions in the SELECT clause. 
  
	  In this case, the SUM(CASE WHEN...) expression first checks the quarter of the given order 
	  (EXTRACT(quarter FROM order_date) = X). 
	  If the quarter value matches the value for the given column, the order's amount is added.   Otherwise, we add 0. 
	  This way, Q1 will only sum orders from the first quarter, Q2 will only sum orders from the second quarter, etc.

35 Creating a "revenue in quarters" report – exercise

Create a "revenue in quarters" report showing the number of orders placed in each quarter of each year.
The final report should look like this:

	year	Q1	Q2	Q3	Q4
	2016	0	0	70	82
	2017	92	93	103	120
	2018	182	88	0	0
	Order the rows by year.
 Query:

	SELECT
		DATE_TRUNC('year', order_date) AS year, 
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=1
	          THEN 1 END) AS Q1,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=2
	          THEN 1 END) AS Q2,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=3
	          THEN 1 END) AS Q3,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=4
	          THEN 1 END) AS Q4
	FROM ORDERS
	GROUP BY DATE_TRUNC('year', order_date)  
	ORDER BY DATE_TRUNC('year', order_date) 
output

	year	q1	q2	q3	q4
	2016-01-01 00:00:00+00	0	0	70	82
	2017-01-01 00:00:00+00	92	93	103	120
	2018-01-01 00:00:00+00	109	0	0	0
	2020-01-01 00:00:00+00	0	8	7	8
	2021-01-01 00:00:00+00	9	7	9	10
	2022-01-01 00:00:00+00	11	13	11	10
	2023-01-01 00:00:00+00	8	12	11	8
	2024-01-01 00:00:00+00	13	6	0	0
------------alternate---------using extract instead of datetrunc --lookat date o/p-----

	SELECT
		EXTRACT(YEAR FROM order_date) AS year,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=1
	          THEN 1 END) AS Q1,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=2
	          THEN 1 END) AS Q2,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=3
	          THEN 1 END) AS Q3,
	    COUNT(CASE WHEN EXTRACT(quarter FROM order_date)=4
	          THEN 1 END) AS Q4
	FROM ORDERS
	GROUP BY EXTRACT(YEAR FROM order_date)
	ORDER BY YEAR
	year	q1	q2	q3	q4
	2016	0	0	70	82
	2017	92	93	103	120
	2018	109	0	0	0
	2020	0	8	7	8
	2021	9	7	9	10
	2022	11	13	11	10
	2023	8	12	11	8
	2024	13	6	0	0
--------------------------------------------------------------          
RECAP
---------------------------------------------------------------
1. To show the total revenue for each year, month or quarter, use DATE_TRUNC():
	
	 	SELECT
		  DATE_TRUNC('year', order_date) AS revenue_year,
		  SUM(amount) AS total_revenue 
		FROM orders
		GROUP BY DATE_TRUNC('year', order_date)
		ORDER BY DATE_TRUNC('year', order_date);

2. To show the total revenue on all aggregation levels, add ROLLUP():
		   
		...
		GROUP BY ROLLUP(
		  EXTRACT(year FROM order_date),
		  EXTRACT(quarter FROM order_date)
		)
		...

3. To show the revenue from the previous year, use LAG():
   
		LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date))

5. To calculate the difference between the current period and the previous period, use:

		SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS delta

7. To calculate the difference between the current period and the previous period as a percentage, use:

		ROUND(100 * (
		  (SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))
		  / (LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))::float
		  ), 2) AS delta_percentage

8. To create a revenue in quarters report, use:

		SELECT
		  DATE_TRUNC('year', order_date) AS year, 
		  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN amount ELSE 0 END) AS Q1,
		  ...
		FROM orders
		GROUP BY DATE_TRUNC('year', order_date)
		ORDER BY DATE_TRUNC('year', order_date);
--------------------------------------------------------------
Comparing revenue over time across different categories
--------------------------------------------------------------

45. Revenue in categories  - // Join, where condn, group by//
46. For all orders placed in the first six months of 2017, calculate the total revenue for all categories. 
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

46. Category revenue with total revenue: /CTE for total sum, 

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
		We don't need a JOIN because we're separating all_categories from order_items with a comma.
  ---------------------------------explanation ----------------------------
		This indicates they are two different tables and they cannot be joined for a given column. 
Separating two tables with a comma means that each row from the first table will be joined with each row from the second table.
----------cross join?---------
	In our case, all_categories contains only a single row, so that row will be added to each row of order_items before any other joins are made.

We can then add the total_sum column from all_categories as the third column in the SELECT clause. 
We also add total_sum in the GROUP BY clause.

47.Category revenue with revenue ratio 
//CTE for tot sum with where clause, category, sum, sum/total sum from cte ,tbl join where condn, gp by     //

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
 category_name	category_revenue	total_revenue_ratio
Beverages	54634.12	0.23724599320953555358
Condiments	16736.55	0.07267764956497976483
Confections	35878.62	0.15580115204358570255
Dairy Products	49640.96	0.21556344019222467633
Grains/Cereals	13639.81	0.05923020761823115553
Meat/Poultry	21455.80	0.09317076180791697442
Produce	16013.11	0.06953614675817137474
Seafood	22285.72	0.09677464880535479801

=----------------------------------------------------------
Revenue for all time periods for selected categories:
-------------------------------------------------------

49. to compare revenue values in selected categories year-to-year, quarter-to-quarter, etc. 
This way, we can analyze whether the category revenue increases or decreases over time.

		The report should look like this:
		
		revenue_year	    total_revenue	beverages_revenue	seafood_revenue
		2016-01-01 00:00:00+00	208083.99	47919.00	19391.23
		2017-01-01 00:00:00+00	617085.35	103924.32	66959.24
		2018-01-01 00:00:00+00	193637.42	61844.55	25079.36

// Date_trunc('' ,date),sum as total,sum(case when categotry = '' then sum else 0.0 end)as colm_name,
	sum as total,sum(case when categotry = '' then sum else 0.0 end)as colm_name
- JOIN
- GROUPBY

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
revenue_quarter	total_revenue	condiments_revenue	confections_revenue
2016-07-01 00:00:00+00	79728.58	5988.40	17118.93
2016-10-01 00:00:00+00	128355.41	11911.99	12566.63
2017-01-01 00:00:00+00	138288.95	13026.08	19316.93
2017-04-01 00:00:00+00	143177.07	12852.70	21403.33
2017-07-01 00:00:00+00	153937.83	13315.05	20276.83
2017-10-01 00:00:00+00	181681.50	16174.80	21660.69
2018-01-01 00:00:00+00	193637.42	11031.87	20908.63
2020-04-01 00:00:00+00	6004.69	1756.00	1144.80
2020-07-01 00:00:00+00	7941.80	195.00	2574.40
2020-10-01 00:00:00+00	5728.73	1355.00	1092.33
2021-01-01 00:00:00+00	11689.96	782.58	2419.25
2021-04-01 00:00:00+00	14145.01	790.00	7367.06
2021-07-01 00:00:00+00	8396.10	427.00	253.00
2021-10-01 00:00:00+00	8691.72	0.0	1413.26
2022-01-01 00:00:00+00	27781.75	4272.70	2098.15
2022-04-01 00:00:00+00	30605.82	2793.85	5164.93
2022-07-01 00:00:00+00	8904.87	1261.35	187.38
2022-10-01 00:00:00+00	22378.13	1684.00	462.00
2023-01-01 00:00:00+00	13183.45	442.05	3919.25
2023-04-01 00:00:00+00	35514.28	2425.70	911.48
2023-07-01 00:00:00+00	11141.13	2203.13	2516.60
2023-10-01 00:00:00+00	11324.10	228.00	210.00
2024-01-01 00:00:00+00	12783.85	553.40	1156.25
2024-04-01 00:00:00+00	10771.14	576.50	1215.18

51. Revenue delta in all time periods for selected categories
We can also create another version of this report by changing revenue values into revenue deltas.
The end result should look like this:

		revenue_year		total_revenue_delta	beverages_revenue_delta		seafood_revenue_delta
		2016-01-01 00:00:00+00	null			null					null
		2017-01-01 00:00:00+00	409001.36		56005.32			47568.01
		2018-01-01 00:00:00+00	-423447.93		-42079.77			-41879.88

We can use the following query: //DATE_TRUNC, SUM-LAG AS TOTAL, SUM(CASE )-LAG(CASE) FOR EACH CATEGORY COLM

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

revenue_month	total_revenue	dairy_revenue	seafood_revenue
2017-01-01 00:00:00+00	61258.08	9066.40	1811.75
2017-02-01 00:00:00+00	38483.64	5584.84	2010.90
2017-03-01 00:00:00+00	38547.23	9728.90	3483.50
2017-04-01 00:00:00+00	53032.95	5775.60	4048.29
2017-05-01 00:00:00+00	53781.30	10435.58	6018.26
2017-06-01 00:00:00+00	36362.82	8455.80	3298.37
2017-07-01 00:00:00+00	51020.88	12387.36	7847.75
2017-08-01 00:00:00+00	47287.68	6826.55	8711.05
2017-09-01 00:00:00+00	55629.27	11420.30	9053.76
2017-10-01 00:00:00+00	66749.24	12869.00	6886.68
2017-11-01 00:00:00+00	43533.81	12992.48	7881.75
2017-12-01 00:00:00+00	71398.45	9844.85	5907.18

We now calculate each column as the sum from the current year (SUM(oi.amount)) minus the sum from the previous year:

LAG(SUM(oi.amount)) OVER (ORDER BY DATE_TRUNC('year', order_date))
To that end, we used the LAG() OVER() pattern we learned in the previous part.

52 - 54 LOOK INSIDE
========================================================Summary ======================================================
Summary

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


