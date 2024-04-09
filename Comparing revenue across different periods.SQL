Part 2 

In the previous part, we learned how to calculate the total revenue in a given period.
Today, we're going to take a look at different ways to compare revenue values across different periods.

In this part, we'll learn how to create three types of revenue reports.

First, we'll talk about reports with total revenue for multiple periods of time, for example total revenue in each month of each year:

month	revenue
...	...
2016-12-01 00:00:00	128355.40
2017-01-01 00:00:00	138288.95
2017-02-01 00:00:00	143177.03
...	...
This report allows you to see trends in the revenue: if it's generally increasing, decreasing or staying at the same level.

Next, we'll learn how to extend these reports with information about the change (delta) between consecutive periods:

month	revenue	delta (%)
...	...	...
2016-12-01 00:00:00	128355.40	-2.15
2017-01-01 00:00:00	138288.95	7.74
2017-02-01 00:00:00	143177.03	3.53
...	...	...
This report gives you quantitative information about the change rate between periods.

Finally, we'll learn how to create a revenue-in-quarters report. quarters are three-month periods of time, the first quarter is a period from January to March, the second quarter is a period from April to June, etc. quarterly analysis is a commonly used financial analysis. The report looks like this, with rows representing years and columns representing quarters:

year	Q1	Q2	Q3	Q4
2016	0.00	0.00	79728.58	128355.40
2017	138288.95	143177.03	153937.78	181681.45
2018	298491.57	142132.33	0.00	0.00
Such reports can help us see seasonal trends in revenue values. For instance, Q4 revenues are typically higher because of holiday shopping. It would be much harder to spot such trends when quarters are shown below each other.

Are you ready to learn more about analyzing revenue trends?

------------------------------------------------------------------------------
Showing the total revenue for each year
First, let's see how our revenue has changed over time. To do so, we'll compare revenue values between consecutive years, months, or any other time periods. Such reports are commonly called year-to-year, quarter-to-quarter, and month-to-month reports. In SQL, we can use the DATE_TRUNC() function we've seen in Part 1 to create such reports. Take a look:

SELECT
  DATE_TRUNC('year', order_date) AS revenue_year,
  SUM(amount) AS total_revenue 
FROM orders
GROUP BY revenue_year
ORDER BY revenue_year;
And the result:

revenue_year	total_revenue
2016-01-01 00:00:00+00	208083.98
2017-01-01 00:00:00+00	617085.21
2018-01-01 00:00:00+00	193637.42
As you probably remember, the DATE_TRUNC(time_unit, date) function takes two parameters: a time_unit (such as 'year', 'quarter', 'month', etc.) and a date or time column.

In our example, DATE_TRUNC('year', date) returns the beginning of the year when the order was placed ('2016-01-01 00:00:00', '2017-01-01 00:00:00', etc.) As you can see, we also use the DATE_TRUNC() function to group all the orders and sum the revenue values for each year. Listing the beginning of the year may seem strange at first, but using DATE_TRUNC() to group by a given period of time is a common pattern in PostgreSQL.

Note that we also added an ORDER BY clause to make sure the revenue values are shown in chronological order.

Exercise
For each year, show the total revenue from all orders shipped to the USA. Show two columns: revenue_year and total_revenue_usa.

Order the rows by year.

SELECT 
	DATE_TRUNC('YEAR', order_date) AS revenue_year,
    SUM(amount) as total_revenue_usa
FROM orders
WHERE ship_country = 'USA'
GROUP BY revenue_year
ORDER BY revenue_year

revenue_year	total_revenue_usa
2016-01-01 00:00:00+00	38105.68
2017-01-01 00:00:00+00	114845.29
2018-01-01 00:00:00+00	44083.02
2020-01-01 00:00:00+00	456.00
2021-01-01 00:00:00+00	5298.75
2022-01-01 00:00:00+00	11120.59
2023-01-01 00:00:00+00	24650.45
2024-01-01 00:00:00+00	7024.87
--------------------------------------------------------
Showing total revenue for each month and quarter
Good job! Now, let's say we want to compare revenue changes month by month. 
We can pick a single year and show the revenue for each month. Check it out:

SELECT
  DATE_TRUNC('month', order_date) AS month_in_2016,
  SUM(amount) AS total_revenue 
FROM orders
WHERE order_date >= '2016-01-01'
  AND order_date < '2017-01-01'
GROUP BY month_in_2016
ORDER BY month_in_2016;
The result looks like this:

month_in_2016	total_revenue
...	...
2016-08-01 00:00:00+00	25485.28
2016-09-01 00:00:00+00	26381.40
2016-10-01 00:00:00+00	37515.73
...	...
To extract the months, we used DATE_TRUNC('month', order_date) instead of DATE_TRUNC('year', order_date). 
Note that DATE_TRUNC() displays the beginning of the month here.

Exercise
We can also use DATE_TRUNC() to get quarterly info, which is frequently used in financial analyses.

Show the total revenue from each quarter of 2017. 
Show two columns: quarter_in_2017 and total_revenue.

Order the results chronologically.

SELECT
	DATE_TRUNC('quarter',order_date) as quarter_in_2017,
    SUM(amount) as total_revenue
FROM orders
WHERE  order_date >= '2017-01-01'
  AND order_date < '2018-01-01'
GROUP BY quarter_in_2017
ORDER BY quarter_in_2017;

quarter_in_2017	total_revenue
2017-01-01 00:00:00+00	138288.95
2017-04-01 00:00:00+00	143177.07
2017-07-01 00:00:00+00	153937.83
2017-10-01 00:00:00+00	181681.50
----------------------------------------------------------------
THe EXTRACT() function
PostgreSQL offers one more function that you can use to see the revenue in each period. 
Take a look:

SELECT
  EXTRACT(year FROM order_date) AS revenue_year,
  SUM(amount) AS total_revenue
FROM orders
GROUP BY EXTRACT(year FROM order_date)
ORDER BY EXTRACT(year FROM order_date);
Here we can see how our revenue has changed each year. 
We use the EXTRACT() function to create such the report. 
The EXTRACT(time_unit FROM date) function takes two parameters: a time_unit (such as year, quarter, month, etc.) and a date or time column. 
The function returns the specified part of a given date.

Here’s the result of the query:

revenue_year	total_revenue
...	...
2016	208083.98
2017	617085.21
2018	440623.90
...	...
In our example, EXTRACT(year FROM order_date) returns the year when the order was placed (2016, 2017, or 2018).
We also use the EXTRACT() function to group all the orders and sum the revenue values for each year.

Note that we also added an ORDER BY clause to make sure the revenue values are shown in chronological order.

Exercise
For each year, show the total revenue from all orders shipped to the USA. Show two columns: revenue_year and total_revenue_usa.

Order the rows by year.
SELECT 
  EXTRACT(year FROM order_date) AS revenue_year,
  SUM(amount) AS total_revenue_usa
FROM orders
WHERE ship_country = 'USA'
GROUP BY revenue_year
ORDER BY revenue_year

the above worked but was not accepted.
--------------------------------------------
SELECT 
  EXTRACT(year FROM order_date) AS revenue_year,
  SUM(amount) AS total_revenue
FROM orders
WHERE ship_country = 'USA'
GROUP BY EXTRACT(year FROM order_date)
ORDER BY EXTRACT(year FROM order_date)
accepted
-------------
revenue_year	total_revenue
2016	38105.68
2017	114845.29
2018	44083.02
2020	456.00
2021	5298.75
2022	11120.59
2023	24650.45
2024	7024.87
----------------------------------------------------'
Showing total revenue for each month using EXTRACT()
Perfect! To show the monthly revenue in each year we must use the EXTRACT() function twice. Take a look:

SELECT
  EXTRACT(year FROM order_date) AS revenue_year,
  EXTRACT(month FROM order_date) AS revenue_month,
  SUM(amount) AS total_revenue
FROM orders
GROUP BY
  EXTRACT(year FROM order_date),
  EXTRACT(month FROM order_date)
ORDER BY
  EXTRACT(year FROM order_date),
  EXTRACT(month FROM order_date);
We would get a result like this:

revenue_year	revenue_month	total_revenue
...	...	...
2016	4	128355.40
2017	1	138288.95
2017	2	143177.03
...	...	...
==========================================================================================================================
Note two things:

months are shown as integers from 1 to 12.
months don't contain any information about the year.
If you only grouped by the month, you'd get monthly revenue values summed across all years. 
In other words, the January revenue would show the sum of January 2016, January 2017, and January 2018. 
To avoid that, we used EXTRACT() twice, with either year or month as the first argument. We also group all rows by both the year and month columns.
==============================================================================================================
Exercise
Show the total monthly revenue in each year, but only for orders processed by the employee with ID of 5.

Order the results by year and month. The columns names should be revenue_year, revenue_month, and total_revenue.

SELECT
  EXTRACT(year FROM order_date) AS revenue_year,
  EXTRACT(month FROM order_date) AS revenue_month,
  SUM(amount) AS total_revenue
FROM orders
WHERE employee_id = 5
GROUP BY
  EXTRACT(year FROM order_date),
  EXTRACT(month FROM order_date)
ORDER BY
  EXTRACT(year FROM order_date),
  EXTRACT(month FROM order_date);

revenue_year	revenue_month	total_revenue
2016	7	1638.82
2016	9	1420.00
2016	10	1393.20
2016	11	3901.08
2016	12	10030.82
2017	3	2520.40
2017	5	4500.28
2017	6	3037.40
2017	7	6475.40
2017	8	3585.58
2017	9	2024.83
2017	10	7581.33
2017	11	484.27
2017	12	507.00
2018	1	11702.80
2018	2	5377.06
2020	5	742.50
2021	6	1659.54
2023	7	210.00
--------------------------------------------------------------
Showing total revenue on all aggregation levels – 1
Very well done! Using the EXTRACT() function in PostgreSQL to generate revenue in period report is tricky, because you have to use it twice to tell apart years and months. However, there is one scenario when EXTRACT() is useful. Let’s say we want a report containing:

quarterly revenue values.
annual revenue values.
the grand total revenue value.
Here's an example of the result we'd like to achieve:  SEE PIC 2 IN 

rollup – result example

Sound complicated? Here's a query to handle it:

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
------------------------------------------===================================
We introduced a small change in the GROUP BY clause. Instead of:

GROUP BY
  EXTRACT(year FROM order_date),
  EXTRACT(quarter FROM order_date)
we used:

GROUP BY ROLLUP(
  EXTRACT(year FROM order_date),
  EXTRACT(quarter FROM order_date)
)
Let's run the query and see what happens.
revenue_year	revenue_quarter	total_revenue
2016	3	79728.58
2016	4	128355.41
2016	null	208083.99
2017	1	138288.95
2017	2	143177.07
2017	3	153937.83
2017	4	181681.50
2017	null	617085.35
2018	1	193637.42
2018	null	193637.42
2020	2	8589.19
2020	3	7945.13
2020	4	6510.28
2020	null	23044.60
2021	1	15324.83
2021	2	7215.16
2021	3	10432.00
2021	4	7311.97
2021	null	40283.96
2022	1	36597.23
2022	2	21745.79
2022	3	16150.17
2022	4	14522.83
2022	null	89016.02
2023	1	13985.18
2023	2	38459.15
2023	3	8438.13
2023	4	11062.50
2023	null	71944.96
2024	1	19618.33
2024	2	3078.66
2024	null	22696.99
null	null	1265793.29

As you can see, we've got rows showing three aggregation levels: 
the grand total revenue, annual revenues, and the quarterly revenues for each year.

In other words, now you can see:

the grand total revenue – the total sum for all years (revenue_year and revenue_quarter being NULL).
the annual revenues – the sums for each year (revenue_quarter being NULL).
the sums for each year and quarter (being the results of the query from the pevious exercise).

--------------------------------------------===============================
Showing total revenue on all aggregation levels – 2
Excellent! As you saw, we used ROLLUP() in the GROUP BY clause:

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
-------------------------------------------------------------------------------------------------------
In PostgreSQL, ROLLUP() is an extension of GROUP BY. 
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
The diagram below explains where the resulting rows come from:         SEE PIC 3 IN READ ME...........

rollup – explanation

In this course, we're only going to briefly introduce ROLLUP(). To learn more about this and other GROUP BY extensions, check out our GROUP BY Extensions in PostgreSQL course.

Exercise
Show the total revenue generated by all orders on three aggregation levels:

The grand total of all revenue values – total_revenue
Annual revenue values – revenue_year
Monthly revenue values – revenue_month
Order all rows by year and month.

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

revenue_year	revenue_month	total_revenue
2016	7	27861.90
2016	8	25485.28
2016	9	26381.40
2016	10	37515.73
2016	11	45600.05
2016	12	45239.63
2016	null	208083.99
2017	1	61258.08
2017	2	38483.64
2017	3	38547.23
2017	4	53032.95
2017	5	53781.30
2017	6	36362.82
2017	7	51020.88
2017	8	47287.68
2017	9	55629.27
2017	10	66749.24
2017	11	43533.81
2017	12	71398.45
2017	null	617085.35
2018	1	94222.13
2018	2	99415.29
2018	null	193637.42
2020	4	2936.19
2020	5	3068.50
2020	6	2584.50
2020	7	1789.55
2020	8	3567.75
2020	9	2587.83
2020	10	1420.60
2020	11	1075.50
2020	12	4014.18
2020	null	23044.60
2021	1	4931.75
2021	2	1981.33
2021	3	8411.75
2021	4	1039.97
2021	5	4441.25
2021	6	1733.94
2021	7	2439.70
2021	8	2298.00
2021	9	5694.30
2021	10	2856.86
2021	11	3473.06
2021	12	982.05
2021	null	40283.96
2022	1	5165.70
2022	2	20871.50
2022	3	10560.03
2022	4	4928.40
2022	5	14246.39
2022	6	2571.00
2022	7	7007.80
2022	8	881.38
2022	9	8260.99
2022	10	4764.80
2022	11	865.53
2022	12	8892.50
2022	null	89016.02
2023	1	9840.64
2023	2	1966.81
2023	3	2177.73
2023	4	16061.85
2023	5	18514.70
2023	6	3882.60
2023	7	4489.85
2023	8	2828.68
2023	9	1119.60
2023	10	4692.00
2023	11	5512.50
2023	12	858.00
2023	null	71944.96
2024	1	8693.75
2024	2	3232.10
2024	3	7692.48
2024	4	3078.66
2024	null	22696.99
null	null	1265793.29

=================================================================================
===================================================================================
Showing total revenue for a previous period
The next type of report we'd like to discuss calculates the revenue change between two periods. 
Such reports can help us assess whether revenue increases or decreases over time, and to what extent. 
We first need to learn how to show the revenue from the previous period for each row. Take a look:

SELECT
  DATE_TRUNC('year', order_date) AS revenue_year, 
  SUM(amount) AS total_revenue,
  LAG(SUM(amount), 1) OVER(ORDER BY DATE_TRUNC('year', order_date)) AS previous_year_revenue
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
We used DATE_TRUNC() function as a more efficient way in PostgreSQL than EXTRACT(). 
Here is the result: SEE PIC 4
----------------------------------------------------------------------------------
LAG() – explanation

As you can see, the report shows the total revenue for 
1) each year and 2) the previous year. 
To do this, we used the LAG() function with an OVER() clause.
LAG() shows values from row(s) that precede the current row.
In this context, OVER() defines which rows are considered the "preceding rows". 
The statement:
LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date))
means: order all rows by the year (OVER (ORDER BY DATE_TRUNC('year', order_date))), 
sum order values for each year (SUM(amount)) and take the value from the 
previous year (LAG(SUM(amount), 1)). 
The expression may look difficult, but it helps to remember it as a fixed pattern.

Note: LAG() and OVER() are used in window functions. To get a deeper understanding of how these work, see our Window Functions in PostgreSQL course.

Exercise
For each month of 2016, show the average order amount and the average order amount from the previous month. 
Show three columns: calculation_month, avg_order_amount, and previous_month_avg_order_amount.

In the first row, leave the previous month value as NULL. Order the rows by month.
SELECT 
	DATE_TRUNC('MONTH', order_date) as calculation_month,
    avg(amount) as avg_order_amount,
    LAG(avg(amount),1) OVER(ORDER BY DATE_TRUNC('MONTH', order_date)) AS previous_month_avg_order_amount
 FROM orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01'  
GROUP BY DATE_TRUNC('MONTH', order_date)
ORDER BY DATE_TRUNC('MONTH', order_date)

calculation_month	avg_order_amount	previous_month_avg_order_amount
2016-07-01 00:00:00+00	1266.4500000000000000	null
2016-08-01 00:00:00+00	1019.4112000000000000	1266.4500000000000000
2016-09-01 00:00:00+00	1147.0173913043478261	1019.4112000000000000
2016-10-01 00:00:00+00	1442.9126923076923077	1147.0173913043478261
2016-11-01 00:00:00+00	1824.0020000000000000	1442.9126923076923077
2016-12-01 00:00:00+00	1459.3429032258064516	1824.0020000000000000

Showing total revenue for previous period – exercise
Very good! It's time for an additional exercise.

Exercise
For each year, calculate the count of orders placed in the current year and the count of orders placed in the previous year. Show three columns: order_year, order_count, and previous_year_order_count.

In the first row, leave the previous year value as NULL. Order the rows by year.

SELECT
	DATE_TRUNC('YEAR',order_date) AS order_year,
    COUNT(order_id) AS order_count,
    LAG(COUNT(order_id),1) OVER(ORDER BY DATE_TRUNC('YEAR',order_date)) AS previous_year_order_count
FROM orders
GROUP BY DATE_TRUNC('YEAR',order_date)
ORDER BY DATE_TRUNC('YEAR',order_date)

order_year	order_count	previous_year_order_count
2016-01-01 00:00:00+00	152	null
2017-01-01 00:00:00+00	408	152
2018-01-01 00:00:00+00	109	408
2020-01-01 00:00:00+00	23	109
2021-01-01 00:00:00+00	35	23
2022-01-01 00:00:00+00	45	35
2023-01-01 00:00:00+00	39	45
2024-01-01 00:00:00+00	19	39
---------------------------------------------=========================================
Calculating revenue deltas
Good job! Now that we know how to calculate the revenue value for the previous period, 
we can easily calculate the revenue change (delta) between two periods. Take a look:

SELECT
  DATE_TRUNC('year', order_date) AS revenue_year, 
  SUM(amount) AS total_revenue,
  SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS delta
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
Result:

revenue_year	total_revenue	delta
2016-01-01 00:00:00+00	208083.99	null
2017-01-01 00:00:00+00	617085.35	409001.36
2018-01-01 00:00:00+00	193637.42	-423447.93
In the delta column, we simply subtracted the revenue generated in the previous year from the revenue generated in the current year. 
Once again, we used the LAG() function pattern from the previous exercise.

Exercise
Show the total revenue for each quarter in each year alongside the delta (revenue change) as compared to the previous quarter.
Show the following columns: revenue_quarter, total_revenue, and delta.

SELECT
	DATE_TRUNC('quarter', order_date) as revenue_quarter,
    SUM(amount) as total_revenue,
    SUM(amount) - LAG(SUM(amount),1) OVER (ORDER BY DATE_TRUNC('quarter', order_date)) AS delta
FROM orders
GROUP BY DATE_TRUNC('quarter', order_date)
ORDER BY DATE_TRUNC('quarter', order_date)

revenue_quarter	total_revenue	delta
2016-07-01 00:00:00+00	79728.58	null
2016-10-01 00:00:00+00	128355.41	48626.83
2017-01-01 00:00:00+00	138288.95	9933.54
2017-04-01 00:00:00+00	143177.07	4888.12
2017-07-01 00:00:00+00	153937.83	10760.76
2017-10-01 00:00:00+00	181681.50	27743.67
2018-01-01 00:00:00+00	193637.42	11955.92
2020-04-01 00:00:00+00	8589.19	-185048.23
2020-07-01 00:00:00+00	7945.13	-644.06
2020-10-01 00:00:00+00	6510.28	-1434.85
2021-01-01 00:00:00+00	15324.83	8814.55
2021-04-01 00:00:00+00	7215.16	-8109.67
2021-07-01 00:00:00+00	10432.00	3216.84
2021-10-01 00:00:00+00	7311.97	-3120.03
2022-01-01 00:00:00+00	36597.23	29285.26
2022-04-01 00:00:00+00	21745.79	-14851.44
2022-07-01 00:00:00+00	16150.17	-5595.62
2022-10-01 00:00:00+00	14522.83	-1627.34
2023-01-01 00:00:00+00	13985.18	-537.65
2023-04-01 00:00:00+00	38459.15	24473.97
2023-07-01 00:00:00+00	8438.13	-30021.02
2023-10-01 00:00:00+00	11062.50	2624.37
2024-01-01 00:00:00+00	19618.33	8555.83
2024-04-01 00:00:00+00	3078.66	-16539.67

-----------------------------------------------------------------------------------------------
Calculating revenue deltas – exercise
Well done! Let's try another exercise.

Exercise
Calculate the total monthly revenue for each month of 2017, along with the revenue change as compared to the previous month. Show three columns: revenue_month, total_revenue, and delta.

In the first row, leave the delta value as NULL. Order the rows by month.

In the first row, leave the delta value as NULL. Order the rows by year and quarter.

SELECT
	DATE_TRUNC('month', order_date)  as revenue_month, .....................................................DATE_TRUNC('month', order_date) gives 2017-01-01 00:00:00+00
    sum(amount) as total_revenue,
     sum(amount) - LAG(sum(amount) ,1) OVER(ORDER BY DATE_TRUNC('month', order_date)) delta
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2017 .................................................................EXTRACT( YEAR FROM date) GIVES ONLY YEAR PART ie 2017
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date)

revenue_month	total_revenue	delta
2017-01-01 00:00:00+00	61258.08	null
2017-02-01 00:00:00+00	38483.64	-22774.44
2017-03-01 00:00:00+00	38547.23	63.59
2017-04-01 00:00:00+00	53032.95	14485.72
2017-05-01 00:00:00+00	53781.30	748.35
2017-06-01 00:00:00+00	36362.82	-17418.48
2017-07-01 00:00:00+00	51020.88	14658.06
2017-08-01 00:00:00+00	47287.68	-3733.20
2017-09-01 00:00:00+00	55629.27	8341.59
2017-10-01 00:00:00+00	66749.24	11119.97
2017-11-01 00:00:00+00	43533.81	-23215.43
2017-12-01 00:00:00+00	71398.45	27864.64

Calculating revenue deltas as percentages
Awesome! We can also express the delta between two periods as a percentage. Look at the following query:

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
This time, the calculation in the last column is a bit more complicated. Here’s the expression we want to calculate:

100.0⋅ (total_revenue − previous_year_total_revenue) / previous_year_total_revenue
 
We divide the change between the current and previous period by the revenue value from the previous period.
To avoid integer division we multiply the numerator by 100.0:
100.0 * ((SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))
We round the percentage to two decimal places using the ROUND(value, 2) function.

Exercise
The template query contains the code from the previous example. Modify it to show the revenue change as a percentage that's rounded to three decimal places.

Here's how you can count the revenue change as a percentage:

total amount − total amount from preceding quarters / the total amount from preceding quarters  ⋅ 100
total amount from preceding quarters
total amount−total amount from preceding quarters
​
 ⋅100
Remember to round the result to three decimal places.

SELECT
  DATE_TRUNC('quarter', order_date) AS revenue_quarter, 
  SUM(amount) AS total_revenue,
  ROUND(
    100.0 *
    (SUM(amount) - LAG(SUM(amount), 1)
      OVER (ORDER BY DATE_TRUNC('quarter', order_date)))
      / (LAG(SUM(amount), 1)
      OVER (ORDER BY DATE_TRUNC('quarter', order_date))),
    3) AS delta
FROM orders
GROUP BY DATE_TRUNC('quarter', order_date)
ORDER BY DATE_TRUNC('quarter', order_date);

revenue_quarter	total_revenue	delta
2016-07-01 00:00:00+00	79728.58	null
2016-10-01 00:00:00+00	128355.41	60.990
2017-01-01 00:00:00+00	138288.95	7.739
2017-04-01 00:00:00+00	143177.07	3.535
2017-07-01 00:00:00+00	153937.83	7.516
2017-10-01 00:00:00+00	181681.50	18.023
2018-01-01 00:00:00+00	193637.42	6.581
2020-04-01 00:00:00+00	8589.19	-95.564
2020-07-01 00:00:00+00	7945.13	-7.498
2020-10-01 00:00:00+00	6510.28	-18.059
2021-01-01 00:00:00+00	15324.83	135.394
2021-04-01 00:00:00+00	7215.16	-52.918
2021-07-01 00:00:00+00	10432.00	44.584
2021-10-01 00:00:00+00	7311.97	-29.908
2022-01-01 00:00:00+00	36597.23	400.511
2022-04-01 00:00:00+00	21745.79	-40.581
2022-07-01 00:00:00+00	16150.17	-25.732
2022-10-01 00:00:00+00	14522.83	-10.076
2023-01-01 00:00:00+00	13985.18	-3.702
2023-04-01 00:00:00+00	38459.15	174.999
2023-07-01 00:00:00+00	8438.13	-78.059
2023-10-01 00:00:00+00	11062.50	31.101
2024-01-01 00:00:00+00	19618.33	77.341
2024-04-01 00:00:00+00	3078.66	-84.307

Calculating revenue deltas as percentages – exercise
Very well done! Let's try one more exercise before we move on.

Exercise
For each month of 2017, calculate the total monthly revenue from orders shipped to the USA and the percentage revenue change (delta) as compared to the previous month. 
Show three columns: revenue_month, total_revenue, and delta_percentage.

In the first row, leave the delta value as NULL. Order the rows by month. Here's how you can count delta_percentage:

total amount
−
total amount from preceding months
total amount from preceding months
⋅
1
0
0
total amount from preceding months
total amount−total amount from preceding months
​
 ⋅100
Remember to round the result to the second decimal point.

SELECT
  DATE_TRUNC('month', order_date) AS revenue_month, 
  SUM(amount) AS total_revenue,
  ROUND(
    100.0 *
    (SUM(amount) - LAG(SUM(amount), 1)
      OVER (ORDER BY DATE_TRUNC('month', order_date)))
      / (LAG(SUM(amount), 1)
      OVER (ORDER BY DATE_TRUNC('month', order_date))),
    2) AS delta_percentage
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2017 AND ship_country = 'USA'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

revenue_month	total_revenue	delta_percentage
2017-01-01 00:00:00+00	4456.00	null
2017-02-01 00:00:00+00	8697.64	95.19
2017-03-01 00:00:00+00	12268.08	41.05
2017-04-01 00:00:00+00	6096.04	-50.31
2017-05-01 00:00:00+00	1019.40	-83.28
2017-06-01 00:00:00+00	6719.50	559.16
2017-07-01 00:00:00+00	25229.59	275.47
2017-08-01 00:00:00+00	2578.99	-89.78
2017-09-01 00:00:00+00	15902.60	516.62
2017-10-01 00:00:00+00	19147.05	20.40
2017-11-01 00:00:00+00	9220.40	-51.84
2017-12-01 00:00:00+00	3510.00	-61.93

==================================================================================
Creating "revenue in quarters" reports

Creating new columns with custom values
There's one more report type we want to show you in this part: the revenue-in-quarters report. 
First, however, we need to introduce a SQL construction you might not have heard about.
Take a look:

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
The construction:

CASE WHEN expression THEN result_true
  ELSE result_false
END
checks if the expression part is true. If it is, the result_true part from the THEN clause is used.
Otherwise, the result_false part from the ELSE clause is used. 
In this case, we check the value in the ship_country column. 
Based on that value, we set the value of the new column to either 'North America' or 'Elsewhere'.

Exercise
For each order shipped to Germany, show three columns:

order_id
amount
order_value – set this value to 'high' if the order's amount is greater than $1,000. 
Otherwise, set it to 'low'.

SELECT 
	order_id,
	amount,
	CASE WHEN amount>1000 THEN 'high'
    else 'low' END as order_value
FROM orders
WHERE ship_country = 'Germany'

order_id	amount	order_value
10249	1863.40	high
10260	1504.65	high
10267	3536.60	high
10273	2037.28	high
10277	1200.80	high
10279	351.00	low
10284	1170.38	high
10285	1743.36	high
10286	3016.00	high
10301	755.00	low
10312	1614.80	high
10313	182.40	low
10323	164.40	low
10325	1497.00	high
10337	2467.00	high
10342	1840.64	high
10343	1584.00	high
10345	2924.80	high
10348	363.60	low
10356	1106.40	high
10361	2046.24	high
10363	447.20	low
10391	86.40	low
10396	1903.80	high
10407	1194.00	high
10418	1814.80	high
10438	454.00	low
10446	246.24	low
10451	3849.66	high
10456	557.60	low
10457	1584.00	high
10468	717.60	low
10488	1512.00	high
10497	1380.60	high
10501	149.00	low
10506	415.80	low
10508	240.00	low
10509	136.80	low
10513	1942.00	high
10515	9921.30	high
10522	2318.24	high
10527	1503.00	high
10534	465.70	low
10536	1645.00	high
10540	10191.70	high
10542	469.11	low
10548	240.10	low
10549	3554.28	high
10554	1728.53	high
10557	1152.50	high
10560	1072.43	high
10575	2147.40	high
10580	1013.75	high
10582	330.00	low
10588	3120.00	high
10592	516.47	low
10593	1994.40	high
10608	1064.00	high
10614	464.00	low
10623	1336.95	high
10630	903.60	low
10632	589.00	low
10640	708.75	low
10643	814.50	low
10651	397.80	low
10653	1083.15	high
10658	4464.60	high
10668	625.28	low
10670	2301.75	high
10675	1423.00	high
10684	1768.00	high
10691	10164.80	high
10692	878.00	low
10694	4825.00	high
10699	114.00	low
10702	330.00	low
10717	1270.75	high
10718	3463.00	high
10721	923.88	low
10745	4529.80	high
10765	1515.60	high
10766	2310.00	high
10772	3603.22	high
10779	1335.00	high
10788	731.50	low
10791	1829.76	high
10797	420.00	low
10799	1553.50	high
10817	10952.85	high
10825	1030.76	high
10833	906.93	low
10835	845.80	low
10845	3812.70	high
10849	967.82	low
10853	625.00	low
10859	1078.69	high
10862	581.00	low
10865	16387.50	high
10878	1539.00	high
10891	368.93	low


-----------------------------------------------------------------------------------
Creating columns with custom sums
Perfect! Now, let's say we want to create two columns that show different order sums based on the ship_country column. 
We can use the construction we've just learned, like so:

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
Above, we twice used the CASE WHEN construction from the previous exercise along with the SUM() function. 
For each row, CASE WHEN checks the value in the ship_country column. 
The order's amount is only added if the ship_country value matches the given condition. 
Otherwise, 0.0 is added. As a result, we'll get the total sum from orders shipped to the USA, Canada, and Mexico 
in the first column and the total sum from orders shipped to all other countries in the second column.

Exercise
Show two columns:

sum_high_freight – The total amount generated by all orders with freight values above 100.0.
sum_low_freight – The total amount generated by all orders with freight values equal to or less than 100.0.

SELECT
	SUM(CASE WHEN freight > 100 THEN amount ELSE 0.0 END) AS sum_high_freight,
    SUM(CASE WHEN freight <= 100 THEN amount ELSE 0.0 END) AS sum_low_freight
FROM orders    

sum_high_freight	sum_low_freight
649633.80	616159.49
-----------------------------------------------------------
Creating a "revenue in quarters" report
Very well done! We can now create a new report type. It should look like this:

year	Q1	Q2	Q3	Q4
2016-01-01 00:00:00+00	0.00	0.00	79728.58	128355.40
2017-01-01 00:00:00+00	138288.95	143177.03	153937.83	181681.50
2018-01-01 00:00:00+00	193637.42	0.00	0.00	0.00
In other words, we want to see quarterly revenue values in the form of a table, with rows representing years and columns representing quarters. Such reports can help us see seasonal trends in revenue values. For instance, Q4 revenues are typically higher because of holiday shopping. It would be much harder to spot such trends when quarters are shown below each other.

How do we write such a query? Take a look:

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
In the query above, we grouped all rows by the DATE_TRUNC('year', order_date) value. This is something we've done before. However, we also used SUM(CASE WHEN...) expressions in the SELECT clause. In this case, the SUM(CASE WHEN...) expression first checks the quarter of the given order (EXTRACT(quarter FROM order_date) = X). If the quarter value matches the value for the given column, the order's amount is added. Otherwise, we add 0. This way, Q1 will only sum orders from the first quarter, Q2 will only sum orders from the second quarter, etc.

Exercise
Show a revenue in quarters report similar to the one in the explanation. Instead of the revenue per quarter, show the average order amount per quarter.

Order the rows by year.

HINT: You will need two modifications:

Change the SUM() function to the AVG() function.
Remove the ELSE 0 part from all CASE WHEN instances. 
Using zeroes for orders from other quarters would change the average value.

SELECT
	DATE_TRUNC('year', order_date) AS year,
    AVG(CASE WHEN EXTRACT(quarter FROM order_date) = 1
        THEN amount END) AS Q1,
    AVG(CASE WHEN EXTRACT(quarter FROM order_date) = 2
        THEN amount END) AS Q2,
    AVG(CASE WHEN EXTRACT(quarter FROM order_date) = 3
        THEN amount END) AS Q3,
    AVG(CASE WHEN EXTRACT(quarter FROM order_date) = 4
        THEN amount END) AS Q4
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER  BY DATE_TRUNC('year', order_date)

year	q1	q2	q3	q4
2016-01-01 00:00:00+00	null	null	1138.9797142857142857	1565.3098780487804878
2017-01-01 00:00:00+00	1503.1407608695652174	1539.5383870967741935	1494.5420388349514563	1514.0125000000000000
2018-01-01 00:00:00+00	1776.4900917431192661	null	null	null
2020-01-01 00:00:00+00	null	1073.6487500000000000	879.5000000000000000	1037.3637500000000000
2021-01-01 00:00:00+00	1211.4255555555555556	1662.4514285714285714	1159.1111111111111111	731.1970000000000000
2022-01-01 00:00:00+00	2873.2027272727272727	2056.7530769230769231	1468.1972727272727273	1452.2830000000000000
2023-01-01 00:00:00+00	1748.1475000000000000	3204.9291666666666667	763.8300000000000000	1387.3125000000000000
2024-01-01 00:00:00+00	1107.7176923076923077	1382.7766666666666667	null	null

================================================================================
Creating a "revenue in quarters" report – exercise
Great job! It's now your turn to create a "revenue in quarters" report!

Exercise
Create a "revenue in quarters" report showing the number of orders placed in each quarter of each year. The final report should look like this:

year	Q1	Q2	Q3	Q4
2016	0	0	70	82
2017	92	93	103	120
2018	182	88	0	0
Order the rows by year.

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
---------------------------------------------------------------
RECAP

That's all we wanted to teach you in this part. 
It's time to wrap things up! First, let's review what we've learned:

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

4. To calculate the difference between the current period and the previous period, use:
SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)) AS delta

5. To calculate the difference between the current period and the previous period as a percentage, use:
ROUND(100 * (
  (SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))
  / (LAG(SUM(amount), 1) OVER (ORDER BY DATE_TRUNC('year', order_date)))::float
  ), 2) AS delta_percentage

6. To create a revenue in quarters report, use:
SELECT
  DATE_TRUNC('year', order_date) AS year, 
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN amount ELSE 0 END) AS Q1,
  ...
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
Question 1
Okay, let's start with Question 1!

Exercise
Calculate the average order value for each month of 2017. Show two columns: revenue_month and avg_order_value.

Order the rows by month.
SELECT
	DATE_TRUNC('month', order_date) as revenue_month,
    avg(amount) as avg_order_value
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2017
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date)

revenue_month	avg_order_value
2017-01-01 00:00:00+00	1856.3054545454545455
2017-02-01 00:00:00+00	1327.0220689655172414
2017-03-01 00:00:00+00	1284.9076666666666667
2017-04-01 00:00:00+00	1710.7403225806451613
2017-05-01 00:00:00+00	1680.6656250000000000
2017-06-01 00:00:00+00	1212.0940000000000000
2017-07-01 00:00:00+00	1546.0872727272727273
2017-08-01 00:00:00+00	1432.9600000000000000
2017-09-01 00:00:00+00	1503.4937837837837838
2017-10-01 00:00:00+00	1756.5589473684210526
2017-11-01 00:00:00+00	1280.4061764705882353
2017-12-01 00:00:00+00	1487.4677083333333333

Question 2
Very good! Let's try the second question.

Exercise
For each month of the first half of 2017, calculate the total revenue and the revenue change 
(delta) as compared to the previous month. Show three columns: revenue_month, total_revenue, 
and delta.

In the first row, leave the delta value as NULL. Order the results by month.

SELECT
	DATE_TRUNC('month', order_date) as revenue_month,
    SUM(amount) as total_revenue,
    SUM(amount) - LAG(SUM(amount),1) OVER(ORDER BY DATE_TRUNC('month', order_date)) AS delta
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2017 AND
	EXTRACT(MONTH FROM order_date) <=6
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date)

-----------or WHERE order_date >= '2017-01-01'
  AND order_date < '2017-07-01'---------------------------
revenue_month	total_revenue	delta
2017-01-01 00:00:00+00	61258.08	null
2017-02-01 00:00:00+00	38483.64	-22774.44
2017-03-01 00:00:00+00	38547.23	63.59
2017-04-01 00:00:00+00	53032.95	14485.72
2017-05-01 00:00:00+00	53781.30	748.35
2017-06-01 00:00:00+00	36362.82	-17418.48

================================================================
Question 3
Well done! Now, the final question.

Exercise
For all orders shipped to Germany, create a "revenue in quarters" report showing the total quarterly revenue in each year. The report should look like this:

year	Q1	Q2	Q3	Q4
2016-01-01 00:00:00+00	0	0	18975.67	16431.48
2017-01-01 00:00:00+00	11929.90	42017.24	23575.24	39797.81
2018-01-01 00:00:00+00	44599.09	0	0	0
...	...	...	...	...
Order the results by year.

-------------GIVEN ANS ---------USES DATE_TRUNC----O/P IS 2016-01-01 --:00:00+00 ------- -------------------
SELECT
  DATE_TRUNC('year', order_date) AS year, 
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 1 THEN amount ELSE 0 END) AS Q1,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 2 THEN amount ELSE 0 END) AS Q2,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 3 THEN amount ELSE 0 END) AS Q3,
  SUM(CASE WHEN EXTRACT(quarter FROM order_date) = 4 THEN amount ELSE 0 END) AS Q4
FROM orders
WHERE ship_country = 'Germany'
GROUP BY YEAR
ORDER BY YEAR

year	q1	q2	q3	q4
2016-01-01 00:00:00+00	0	0	18975.67	16431.48
2017-01-01 00:00:00+00	11929.90	42017.24	23575.25	39797.81
2018-01-01 00:00:00+00	44599.09	0	0	0
2020-01-01 00:00:00+00	0	0	1174.75	3231.88
2021-01-01 00:00:00+00	245.00	471.20	4261.00	910.40
2022-01-01 00:00:00+00	0	2856.00	1197.95	3758.80
2023-01-01 00:00:00+00	6938.64	3852.00	1485.80	858.00
2024-01-01 00:00:00+00	1716.83	0	0	0

----------------My ANS --------USING EXTRACT ---- O/P YR ONLY NUMBER--------          
SELECT
	EXTRACT(YEAR FROM order_date) as YEAR,
    SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 1 THEN amount END) AS Q1, 
    SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 2 THEN amount END) AS Q2, 
    SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 3 THEN amount END) AS Q3, 
    SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 4 THEN amount END) AS Q4
FROM orders
WHERE ship_country = 'Germany'
GROUP BY YEAR
ORDER BY YEAR

year	q1	q2	q3	q4
2016	null	null	18975.67	16431.48
2017	11929.90	42017.24	23575.25	39797.81
2018	44599.09	null	null	null
2020	null	null	1174.75	3231.88
2021	245.00	471.20	4261.00	910.40
2022	null	2856.00	1197.95	3758.80
2023	6938.64	3852.00	1485.80	858.00
2024	1716.83	null	null	null
