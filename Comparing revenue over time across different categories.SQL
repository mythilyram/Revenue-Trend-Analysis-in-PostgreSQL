Welcome
Hello and welcome to the last part of our course.
Previously, we learned to create reports showing revenue values across different periods. 
In this part, we'll extend that knowledge by learning how we can compare revenue for various categories. 
Comparing multiple categories is just an example – this part aims to teach you how you can compare various segments of your business. 
The same rules apply to comparing revenue from multiple departments or cities.

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


