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
	    
    - Calculating the beginning of the current period (e.g. the current day, month, year, etc.). This will help us create revenue reports for the current year, month, quarter, etc. 
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
        - YTD, MTD, and QTD reports are used by business owners, investors, and individuals to analyze their revenue, income, business earnings, and investment returns for the current period of time.
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
            
