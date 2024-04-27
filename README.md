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

=========================================================================
Comparing revenue across different periods
==========================================================================
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
		
		As a general rule, ROLLUP() always creates new grouping combinations by removing columns one by one, starting from the right:
		
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
		  LAG(SUM(amount), 1) OVER(ORDER BY DATE_TRUNC('year', order_date)) AS previous_year_revenue------->Prev yr
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
	-** 100.0⋅ (total_revenue − previous_year_total_revenue) / previous_year_total_revenue**
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

