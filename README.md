# Revenue-Trend-Analysis-in-PostgreSQL
Revenue Trend Analysis in PostgreSQL
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/e5048e99-f755-41ed-904f-3939a1711e2e)


Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods - Showing total revenue on all aggregation levels – 1
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/74d4f3dd-d76f-4d36-b563-6cb3408f9f24)

Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods- Showing total revenue on all aggregation levels – 2
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/7b3f63f2-b761-40e7-a423-54231b91e89d)

Revenue-Trend-Analysis-in-PostgreSQL -Comparing revenue across different periods - Showing total revenue for a previous period - LAG() – explanation
![image](https://github.com/mythilyram/Revenue-Trend-Analysis-in-PostgreSQL/assets/123518126/7d2083b3-1a26-4ab3-a650-96d69b874811)

1-6. Getting to know the database
7-14 Basic revenue metrics
    Revenue to date - sum(amt), 
    given a category / ship_country use WHERE
    Time constraints in revenue reports - 
        - WHERE o.order_date >= '2017-03-01' AND o.order_date < '2017-04-01'
        - based on orders from March 2017
        - date format that we used: YYYY-MM-DD.
