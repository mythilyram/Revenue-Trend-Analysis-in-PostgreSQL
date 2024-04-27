Part 1
Welcome
  
Hello and welcome to our PostgreSQL Revenue Trend Analysis course!
  This course is aimed for students from various industries who would like to use PostgreSQL to analyze revenue trends for their companies. 
  Once you learn how to analyze revenue, you'll also be able to analyze other trends, such as website visits over time, in a similar way.

Revenue is the income generated from the sale of products (or services, if that's what your company is selling), before any costs or expenses are deducted. 
  It is sometimes called sales or (in the UK) turnover. To determine net income you subtract all charges, costs, and expenses from the revenue.

Revenue is the most important figure in a financial statement for a company. In this course we'll look at various revenue metrics and we'll learn how to compute them in SQL.

SQL Basics - JOIN, WHERE, GROUP BY, ORDER BY, and HAVING clauses – all of which you'll need for this course.

First, we'll get to know the database we're going to work with.

2. The Northwind database
We'll be using a Microsoft database named Northwind. 
  It describes a fictional store, its customers, and its orders. The original database is available here. 
  We have modified it a bit to better suit the needs of this course.

  
3. The employees table

  The employees table stores information about the people employed at Northwind. 
  Each employee has a unique ID (stored in the column employee_id), a first and last name 
  (first_name, last_name) and a professional title (title). 
  There are also other columns in this table, such as hire_date and address.

  employee_id	last_name	first_name	title	birth_date	hire_date	address	city	region	postal_code	country	reports_to
1	Davolio	Nancy	Sales Representative	1968-12-08	2012-05-01	507 - 20th Ave. E. Apt. 2A	Seattle	WA	98122	USA	2
2	Fuller	Andrew	Vice President, Sales	1972-02-19	2012-08-14	908 W. Capital Way	Tacoma	WA	98401	USA	null
3	Smith	John	Sales Representative	1983-08-30	2012-04-01	722 Moss Bay Blvd.	Kirkland	WA	98033	USA	2
4	Peacock	Margaret	Sales Representative	1957-09-19	2013-05-03	4110 Old Redmond Rd.	Redmond	WA	98052	USA	2
5	Buchanan	Steven	Sales Manager	1975-03-04	2013-10-17	14 Garrett Hill	London	null	SW1 8JR	UK	2
6	Suyama	Michael	Sales Representative	1983-07-02	2013-10-17	Coventry House Miner Rd.	London	null	EC2 7JR	UK	5
7	King	Robert	Sales Representative	1980-05-29	2014-01-02	Edgeham Hollow Winchester Way	London	null	RG1 9SP	UK	5
8	Callahan	Laura	Inside Sales Coordinator	1978-01-09	2014-03-05	4726 - 11th Ave. N.E.	Seattle	WA	98105	USA	2
9	Dodsworth	Anne	Sales Representative	1986-01-27	2014-11-15	7 Houndstooth Rd.	London	null	WG2 7LT	UK	5
10	Smith	John	Sales Representative	1994-08-30	2017-03-21	22 Abbey Rd	London	null	NW6 5JG	UK	2

4. The customers table

Each customer has a 5-letter customer_id column and a company_name column. 
  There are also columns related to the contact person (contact_name, contact_title) 
  and columns related to the customer''s address and fax.

Exercise
For each customer select customer_id, company_name, contact_name, contact_title, and city.  

customer_id	company_name	contact_name	contact_title	city
ALFKI	Alfreds Futterkiste	Maria Anders	Sales Representative	Berlin
ANATR	Ana Trujillo Emparedados y helados	Ana Trujillo	Owner	México D.F.
ANTON	Antonio Moreno Taquería	Antonio Moreno	Owner	México D.F.
AROUT	Around the Horn	Thomas Hardy	Sales Representative	London
BERGS	Berglunds snabbköp	Christina Berglund	Order Administrator	Luleå
BLAUS	Blauer See Delikatessen	Hanna Moos	Sales Representative	Mannheim
BLONP	Blondesddsl père et fils	Frédérique Citeaux	Marketing Manager	Strasbourg
BOLID	Bólido Comidas preparadas	Martín Sommer	Owner	Madrid
BONAP	Bon app'	Laurence Lebihan	Owner	Marseille
BOTTM	Bottom-Dollar Markets	Elizabeth Lincoln	Accounting Manager	Tsawassen
BSBEV	B's Beverages	Victoria Ashworth	Sales Representative	London
CACTU	Cactus Comidas para llevar	Patricio Simpson	Sales Agent	Buenos Aires
CENTC	Centro comercial Moctezuma	Francisco Chang	Marketing Manager	México D.F.
CHOPS	Chop-suey Chinese	Yang Wang	Owner	Bern
COMMI	Comércio Mineiro	Pedro Afonso	Sales Associate	Sao Paulo
CONSH	Consolidated Holdings	Elizabeth Brown	Sales Representative	London
DRACD	Drachenblut Delikatessen	Sven Ottlieb	Order Administrator	Aachen
DUMON	Du monde entier	Janine Labrune	Owner	Nantes
EASTC	Eastern Connection	Ann Devon	Sales Agent	London
ERNSH	Ernst Handel	Roland Mendel	Sales Manager	Graz
FAMIA	Familia Arquibaldo	Aria Cruz	Marketing Assistant	Sao Paulo
FISSA	FISSA Fabrica Inter. Salchichas S.A.	Diego Roel	Accounting Manager	Madrid
FOLIG	Folies gourmandes	Martine Rancé	Assistant Sales Agent	Lille
FOLKO	Folk och fä HB	Maria Larsson	Owner	Bräcke
FRANK	Frankenversand	Peter Franken	Marketing Manager	München
FRANR	France restauration	Carine Schmitt	Marketing Manager	Nantes
FRANS	Franchi S.p.A.	Paolo Accorti	Sales Representative	Torino
FURIB	Furia Bacalhau e Frutos do Mar	Lino Rodriguez	Sales Manager	Lisboa
GALED	Galería del gastrónomo	Eduardo Saavedra	Marketing Manager	Barcelona
GODOS	Godos Cocina Típica	José Pedro Freyre	Sales Manager	Sevilla
GOURL	Gourmet Lanchonetes	André Fonseca	Sales Associate	Campinas
GREAL	Great Lakes Food Market	Howard Snyder	Marketing Manager	Eugene
GROSR	GROSELLA-Restaurante	Manuel Pereira	Owner	Caracas
HANAR	Hanari Carnes	Mario Pontes	Accounting Manager	Rio de Janeiro
HILAA	HILARION-Abastos	Carlos Hernández	Sales Representative	San Cristóbal
HUNGC	Hungry Coyote Import Store	Yoshi Latimer	Sales Representative	Elgin
HUNGO	Hungry Owl All-Night Grocers	Patricia McKenna	Sales Associate	Cork
ISLAT	Island Trading	Helen Bennett	Marketing Manager	Cowes
KOENE	Königlich Essen	Philip Cramer	Sales Associate	Brandenburg
LACOR	La corne d'abondance	Daniel Tonini	Sales Representative	Versailles
LAMAI	La maison d'Asie	Annette Roulet	Sales Manager	Toulouse
LAUGB	Laughing Bacchus Wine Cellars	Yoshi Tannamuri	Marketing Assistant	Vancouver
LAZYK	Lazy K Kountry Store	John Steel	Marketing Manager	Walla Walla
LEHMS	Lehmanns Marktstand	Renate Messner	Sales Representative	Frankfurt a.M.
LETSS	Let's Stop N Shop	Jaime Yorres	Owner	San Francisco
LILAS	LILA-Supermercado	Carlos González	Accounting Manager	Barquisimeto
LINOD	LINO-Delicateses	Felipe Izquierdo	Owner	I. de Margarita
LONEP	Lonesome Pine Restaurant	Fran Wilson	Sales Manager	Portland
MAGAA	Magazzini Alimentari Riuniti	Giovanni Rovelli	Marketing Manager	Bergamo
MAISD	Maison Dewey	Catherine Dewey	Sales Agent	Bruxelles
MEREP	Mère Paillarde	Jean Fresnière	Marketing Assistant	Montréal
MORGK	Morgenstern Gesundkost	Alexander Feuer	Marketing Assistant	Leipzig
NORTS	North/South	Simon Crowther	Sales Associate	London
OCEAN	Océano Atlántico Ltda.	Yvonne Moncada	Sales Agent	Buenos Aires
OLDWO	Old World Delicatessen	Rene Phillips	Sales Representative	Anchorage
OTTIK	Ottilies Käseladen	Henriette Pfalzheim	Owner	Köln
PARIS	Paris spécialités	Marie Bertrand	Owner	Paris
PERIC	Pericles Comidas clásicas	Guillermo Fernández	Sales Representative	México D.F.
PICCO	Piccolo und mehr	Georg Pipps	Sales Manager	Salzburg
PRINI	Princesa Isabel Vinhos	Isabel de Castro	Sales Representative	Lisboa
QUEDE	Que Delícia	Bernardo Batista	Accounting Manager	Rio de Janeiro
QUEEN	Queen Cozinha	Lúcia Carvalho	Marketing Assistant	Sao Paulo
QUICK	QUICK-Stop	Horst Kloss	Accounting Manager	Cunewalde
RANCH	Rancho grande	Sergio Gutiérrez	Sales Representative	Buenos Aires
RATTC	Rattlesnake Canyon Grocery	Paula Wilson	Assistant Sales Representative	Albuquerque
REGGC	Reggiani Caseifici	Maurizio Moroni	Sales Associate	Reggio Emilia
RICAR	Ricardo Adocicados	Janete Limeira	Assistant Sales Agent	Rio de Janeiro
RICSU	Richter Supermarkt	Michael Holz	Sales Manager	Genève
ROMEY	Romero y tomillo	Alejandra Camino	Accounting Manager	Madrid
SANTG	Santé Gourmet	Jonas Bergulfsen	Owner	Stavern
SAVEA	Save-a-lot Markets	Jose Pavarotti	Sales Representative	Boise
SEVES	Seven Seas Imports	Hari Kumar	Sales Manager	London
SIMOB	Simons bistro	Jytte Petersen	Owner	Kobenhavn
SPECD	Spécialités du monde	Dominique Perrier	Marketing Manager	Paris
SPLIR	Split Rail Beer & Ale	Art Braunschweiger	Sales Manager	Lander
SUPRD	Suprêmes délices	Pascale Cartrain	Accounting Manager	Charleroi
THEBI	The Big Cheese	Liz Nixon	Marketing Manager	Portland
THECR	The Cracker Box	Liu Wong	Marketing Assistant	Butte
TOMSP	Toms Spezialitäten	Karin Josephs	Marketing Manager	Münster
TORTU	Tortuga Restaurante	Miguel Angel Paolino	Owner	México D.F.
TRADH	Tradição Hipermercados	Anabela Domingues	Sales Representative	Sao Paulo
TRAIH	Trail's Head Gourmet Provisioners	Helvetius Nagy	Sales Associate	Kirkland
VAFFE	Vaffeljernet	Palle Ibsen	Sales Manager	Århus
VICTE	Victuailles en stock	Mary Saveley	Sales Agent	Lyon
VINET	Vins et alcools Chevalier	Paul Henriot	Accounting Manager	Reims
WANDK	Die Wandernde Kuh	Rita Müller	Sales Representative	Stuttgart
WARTH	Wartian Herkku	Pirkko Koskitalo	Accounting Manager	Oulu
WELLI	Wellington Importadora	Paula Parente	Sales Manager	Resende
WHITC	White Clover Markets	Karl Jablonski	Owner	Seattle
WILMK	Wilman Kala	Matti Karttunen	Owner/Marketing Assistant	Helsinki
WOLZA	Wolski Zajazd	Zbyszek Piestrzeniewicz	Owner	Warszawa

5. The products and categories tables

Each product has a product_id and product_name. 
  Each product belongs to one category (category_id) and has a fixed unit_price. 
  The discontinued column holds either a false (available in the store) or a true (no longer available) for each product.

Each category has an ID and a category_name. There is also a short description.

Exercise
The products table contains a category_id column, but no category_name column. 
  To find out the category name for a given product, you will have to join these two tables.

Show each product_name alongside its category_name.

  select 
	product_name,
    category_name
from products
join categories
using (category_id)

product_name	category_name
Chai	Beverages
Chang	Beverages
Aniseed Syrup	Condiments
Chef Anton's Cajun Seasoning	Condiments
Chef Anton's Gumbo Mix	Condiments
Grandma's Boysenberry Spread	Condiments
Uncle Bob's Organic Dried Pears	Produce
Northwoods Cranberry Sauce	Condiments
Mishi Kobe Niku	Meat/Poultry
Ikura	Seafood
Queso Cabrales	Dairy Products
Queso Manchego La Pastora	Dairy Products
Konbu	Seafood
Tofu	Produce
Genen Shouyu	Condiments
Pavlova	Confections
Alice Mutton	Meat/Poultry
Carnarvon Tigers	Seafood
Teatime Chocolate Biscuits	Confections
Sir Rodney's Marmalade	Confections
Sir Rodney's Scones	Confections
Gustaf's Knäckebröd	Grains/Cereals
Tunnbröd	Grains/Cereals
Guaraná Fantástica	Beverages
NuNuCa Nuß-Nougat-Creme	Confections
Gumbär Gummibärchen	Confections
Schoggi Schokolade	Confections
Rössle Sauerkraut	Produce
Thüringer Rostbratwurst	Meat/Poultry
Nord-Ost Matjeshering	Seafood
Gorgonzola Telino	Dairy Products
Mascarpone Fabioli	Dairy Products
Geitost	Dairy Products
Sasquatch Ale	Beverages
Steeleye Stout	Beverages
Inlagd Sill	Seafood
Gravad lax	Seafood
Côte de Blaye	Beverages
Chartreuse verte	Beverages
Boston Crab Meat	Seafood
Jack's New England Clam Chowder	Seafood
Singaporean Hokkien Fried Mee	Grains/Cereals
Ipoh Coffee	Beverages
Gula Malacca	Condiments
Rogede sild	Seafood
Spegesild	Seafood
Zaanse koeken	Confections
Chocolade	Confections
Maxilaku	Confections
Valkoinen suklaa	Confections
Manjimup Dried Apples	Produce
Filo Mix	Grains/Cereals
Perth Pasties	Meat/Poultry
Tourtière	Meat/Poultry
Pâté chinois	Meat/Poultry
Gnocchi di nonna Alice	Grains/Cereals
Ravioli Angelo	Grains/Cereals
Escargots de Bourgogne	Seafood
Raclette Courdavault	Dairy Products
Camembert Pierrot	Dairy Products
Sirop d'érable	Condiments
Tarte au sucre	Confections
Vegie-spread	Condiments
Wimmers gute Semmelknödel	Grains/Cereals
Louisiana Fiery Hot Pepper Sauce	Condiments
Louisiana Hot Spiced Okra	Condiments
Laughing Lumberjack Lager	Beverages
Scottish Longbreads	Confections
Gudbrandsdalsost	Dairy Products
Outback Lager	Beverages
Flotemysost	Dairy Products
Mozzarella di Giovanni	Dairy Products
Röd Kaviar	Seafood
Longlife Tofu	Produce
Rhönbräu Klosterbier	Beverages
Lakkalikööri	Beverages
Original Frankfurter grüne Soße	Condiments

 6. The orders and order_items tables
Very well done! Finally, we'll take a look at the orders and order_items tables.

The orders table contains information about orders such as the order_id, customer_id, and the employee_id of the worker responsible for that order. 
  There are also timestamp columns (order_date, required_date, and shipped_date) and a lot of columns related to the shipment process. 
  Finally, there is the amount column, which shows the total amount paid for that order.

The order_items table, in turn, stores information about what was actually ordered in a given order. 
  Each row represents a single line item from an order. You can find the order_id, product_id, and the amount paid for the specific item.

Exercise
For each order display order_id, order_date, the number of products ordered in this order (name this column product_count) and the total amount paid for that order (name this column total_amount).

To access the total_amount for each order, you should use the amount column from the orders table.

select
 	order_id,
    order_date,
    count(product_id) as product_count,
    sum(oi.amount) as total_amount
from order_items oi
join orders o
using (order_id)
group by order_id, order_date

order_id	order_date	product_count	total_amount
10323	2016-10-07	3	164.40
11021	2023-01-03	5	6306.24
10798	2017-12-26	2	446.60
10346	2016-11-05	2	1618.88
10711	2017-10-21	3	4451.70
10908	2018-02-26	2	663.10
10858	2018-01-29	3	649.00
10422	2017-01-22	1	49.80
10499	2017-04-08	2	1412.00
10531	2017-05-08	1	110.00
10943	2021-02-06	3	711.00
10910	2018-02-26	3	452.90
10645	2017-08-26	2	1535.00
11046	2023-08-11	3	1485.80
10417	2017-01-16	4	11188.40
10940	2021-01-02	2	360.00
10719	2017-10-27	3	844.25
10483	2017-03-24	2	668.80
10919	2020-04-21	3	1122.80
10784	2017-12-18	3	1488.00
10801	2017-12-29	2	3026.85
10309	2016-09-19	5	1762.00
10384	2016-12-16	2	2222.40
10362	2016-11-25	3	1549.60
10937	2020-12-01	2	644.80
10995	2022-05-23	2	1196.00
10445	2017-02-13	2	174.90
10749	2017-11-20	3	1080.00
11029	2023-04-12	2	1286.80
10706	2017-10-16	3	1893.00
10520	2017-04-29	2	200.00
10459	2017-02-27	3	1659.20
10712	2017-10-21	2	1233.48
10928	2020-08-07	2	137.50
10482	2017-03-21	1	147.00
10875	2018-02-06	3	709.55
10657	2017-09-04	6	4371.60
11039	2023-06-27	4	3090.00
10618	2017-08-01	3	2697.50
10644	2017-08-25	3	1371.80
10344	2016-11-01	2	2296.00
10826	2018-01-12	2	730.00
10787	2017-12-19	2	2622.76
10279	2016-08-13	1	351.00
10951	2021-04-14	3	458.77
10449	2017-02-18	3	1838.20
10561	2017-06-06	2	2844.50
10356	2016-11-18	3	1106.40
10378	2016-12-10	1	103.20
10999	2022-07-04	3	1197.95
10934	2020-10-18	1	500.00
11066	2024-02-16	3	928.75
10444	2017-02-12	4	1031.70
10573	2017-06-19	3	2082.00
10790	2017-12-22	2	722.50
10655	2017-09-03	1	154.40
10545	2017-05-22	1	210.00
10809	2018-01-01	1	140.00
11019	2022-12-24	2	76.00
10893	2018-02-18	5	5502.11
10867	2018-02-03	1	98.40
10487	2017-03-26	3	889.70
10941	2021-01-19	4	4011.75
10927	2020-07-28	3	800.00
10515	2017-04-23	5	9921.30
10506	2017-04-15	2	415.80
10382	2016-12-13	5	2900.00
10558	2017-06-04	5	2142.90
10415	2017-01-15	2	102.40
10328	2016-10-14	3	1168.00
11036	2023-05-20	2	1692.00
10340	2016-10-29	3	2436.18
10443	2017-02-12	2	517.44
10391	2016-12-23	1	86.40
10397	2016-12-27	2	716.72
10640	2017-08-21	2	708.75
10643	2017-08-25	3	814.50
10595	2017-07-10	3	4725.00
10373	2016-12-05	2	1366.40
10650	2017-08-29	3	1779.20
10505	2017-04-14	1	147.90
10945	2021-02-25	2	245.00
11027	2023-03-23	2	877.73
10408	2017-01-08	3	1622.40
10533	2017-05-12	3	2222.20
10906	2018-02-25	1	427.50
10315	2016-09-26	2	516.80
10668	2017-09-15	3	625.28
10843	2018-01-21	1	159.00
10464	2017-03-04	4	1609.28
10496	2017-04-04	1	190.00
11011	2022-10-15	2	933.50
10646	2017-08-27	4	1446.00
10468	2017-03-07	2	717.60
10436	2017-02-05	4	1994.52
10511	2017-04-18	3	2550.00
10252	2016-07-09	3	3597.90
10386	2016-12-18	2	166.00
10915	2018-02-27	3	539.50
10963	2021-09-17	1	57.80
========================================================================
	Basic Revenue metrics
========================================================================
7. ----------------Revenue to date-----------------------------
let's take a look at some basic revenue metrics.

In this part we'll discuss the following revenue metrics:

Total revenue to date – the total revenue from all orders. We'll take advantage of this metric to get to know the revenue columns in our database.
Total revenue in a period of time – often we're interested in the total revenue for a specific period of time, e.g., for a specific month or a specific quarter.
Total revenue for the current year, month, etc. – they show how much the company earned so far in the given current period. 
             Commonly used report types are year-to-date, quarter-to-date, or month-to-date.
The easiest metric to compute is the total revenue to date, i.e., the total revenue from all orders. 

  Here is a SUM() function that will calculate it:

SELECT
  SUM(amount) AS total_revenue
FROM orders;
You could also use the order_items table to get the same result:

SELECT
  SUM(amount) AS total_revenue
FROM order_items;
As you can see, we only need to sum all values from the amount column of the orders or order_items tables to get the revenue-to-date value. We can also add a WHERE clause to find the revenue-to-date for specific orders, for instance:

SELECT
  SUM(amount) AS total_revenue
FROM orders
WHERE ship_country = 'USA';
The query above finds the revenue to date for orders shipped to the USA.

  Exercise
Find the total revenue to date for all beverages (i.e., products with category_id = 1).
  Use the amount column from order_items as total_revenue.
  
SELECT
  SUM(amount) AS total_revenue
FROM order_items
JOIN products p
USING (product_id)
WHERE category_id = 1;

total_revenue
267868.20

8. ---   Revenue to date by group---------------------------
Excellent! Now let us see how we can show the revenue generated by various groups to date. 
  For instance:

SELECT
  c.customer_id,
  c.company_name,
  SUM(o.amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.company_name;
The query above shows the revenue to date for each customer. To find the total amount for each customer, we group the whole query by the customer_id and company_name columns from the customers table.

Exercise
Show each category_id and category_name alongside the total_revenue generated by all order items from that category.

SELECT
  c.category_id,
c.category_name,
  SUM(oi.amount) AS total_revenue 
FROM order_items oi
JOIN products p
using (product_id)
JOIN categories c
using (category_id)
GROUP BY c.category_id,c.category_name

category_id	category_name	total_revenue
4	Dairy Products	234507.32
6	Meat/Poultry	163022.38
2	Condiments	106047.15
3	Confections	167357.29
5	Grains/Cereals	95744.60
7	Produce	99984.58
1	Beverages	267868.20
8	Seafood	131261.77

9. --------------------Time constraints in revenue reports------------------------
SELECT
  c.customer_id,
  company_name,
  SUM(amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE o.order_date >= '2017-03-01' AND o.order_date < '2017-04-01'
GROUP BY c.customer_id, company_name;
The query above shows total revenue per customer,
	but this time it's based on orders from March 2017. We've added a WHERE clause, 
	inside which we defined the range for order_date. 
	==========================================================================================
	Note the date format that we used: YYYY-MM-DD. In other words, o.order_date >= '2017-03-01' means 'orders placed on March 1, 2017 or later'. 
	Note that the month comes before the day in this date format – this might be counterintuitive for people from the US. 
	The other condition that we used is o.order_date < '2017-04-01', which means "orders placed before April 1, 2017".
=====================================================================================================
Exercise
Find the total_revenue (the sum of all amounts) from all orders placed in 2017.

SELECT
  SUM(amount) AS total_revenue 
FROM orders o
WHERE o.order_date >= '2017-01-01' AND o.order_date <= '2017-12-31'

total_revenue
617085.35

10. ------------------------------How to add interval to date-------------------------------------
Perfect! When we wanted to find orders from March 2017, we used the following WHERE clause:

WHERE o.order_date >= '2017-03-01' AND o.order_date < '2017-04-01'
There is another way to write this query. Take a look:
===============================================
SELECT
  c.customer_id,
  company_name,
  SUM(amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE o.order_date >= '2017-03-01'
  AND o.order_date < '2017-03-01'::DATE + INTERVAL '1' month
GROUP BY c.customer_id, company_name;
This time, instead of providing the specific end date, we used the INTERVAL keyword:

date::DATE + INTERVAL 'number' interval
where:
interval – the interval we want to add, such as year, month or day.
number – the amount of that interval to add.
date – the date to be modified.
	
In our example, '2017-03-01'::DATE + INTERVAL '1' month means "add one month to March 1, 2017".

Exercise
The fiscal year in Northwind starts on September 1.

For each customer, show the total revenue from orders placed in the fiscal year starting September 1, 2016. Show three columns: customer_id, company_name, and total_revenue.

Use the INTERVAL keyword.
SELECT
  c.customer_id,
  company_name,
  SUM(amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE o.order_date >= '2016-09-01'
  AND o.order_date < '2016-09-01'::DATE + INTERVAL '1' year
GROUP BY c.customer_id, company_name;

customer_id	company_name	total_revenue
ALFKI	Alfreds Futterkiste	814.50
ANATR	Ana Trujillo Emparedados y helados	568.55
ANTON	Antonio Moreno Taquería	5175.11
AROUT	Around the Horn	3929.60
BERGS	Berglunds snabbköp	9626.34
BLAUS	Blauer See Delikatessen	1079.80
BLONP	Blondesddsl père et fils	15968.08
BOLID	Bólido Comidas preparadas	982.00
BONAP	Bon app'	9263.48
BOTTM	Bottom-Dollar Markets	6345.05
BSBEV	B's Beverages	3179.50
CACTU	Cactus Comidas para llevar	225.50
CHOPS	Chop-suey Chinese	3431.80
COMMI	Comércio Mineiro	1128.00
CONSH	Consolidated Holdings	787.60
DRACD	Drachenblut Delikatessen	533.60
DUMON	Du monde entier	692.80
EASTC	Eastern Connection	4809.35
ERNSH	Ernst Handel	41748.74
FAMIA	Familia Arquibaldo	3819.75
FOLIG	Folies gourmandes	7363.90
FOLKO	Folk och fä HB	7477.12
FRANK	Frankenversand	10132.82
FRANS	Franchi S.p.A.	49.80
FURIB	Furia Bacalhau e Frutos do Mar	5081.24
GALED	Galería del gastrónomo	629.20
GODOS	Godos Cocina Típica	4576.15
GOURL	Gourmet Lanchonetes	1020.00
GREAL	Great Lakes Food Market	6673.71
HANAR	Hanari Carnes	3481.52
HILAA	HILARION-Abastos	12886.30
HUNGC	Hungry Coyote Import Store	1362.20
HUNGO	Hungry Owl All-Night Grocers	18959.31
ISLAT	Island Trading	1890.10
KOENE	Königlich Essen	6309.11
LAMAI	La maison d'Asie	5445.53
LAUGB	Laughing Bacchus Wine Cellars	335.50
LAZYK	Lazy K Kountry Store	357.00
LEHMS	Lehmanns Marktstand	11056.91
LETSS	Let's Stop N Shop	317.75
LILAS	LILA-Supermercado	8434.48
LINOD	LINO-Delicateses	4704.05
LONEP	Lonesome Pine Restaurant	1129.20
MAGAA	Magazzini Alimentari Riuniti	3760.68
MAISD	Maison Dewey	2380.00
MEREP	Mère Paillarde	28233.70
MORGK	Morgenstern Gesundkost	2147.40
NORTS	North/South	352.00
OCEAN	Océano Atlántico Ltda.	429.20
OLDWO	Old World Delicatessen	6996.30
OTTIK	Ottilies Käseladen	4176.28
PERIC	Pericles Comidas clásicas	2746.20
PICCO	Piccolo und mehr	16021.56
PRINI	Princesa Isabel Vinhos	2411.04
QUEDE	Que Delícia	3500.93
QUEEN	Queen Cozinha	14693.32
QUICK	QUICK-Stop	39108.18
RANCH	Rancho grande	443.40
RATTC	Rattlesnake Canyon Grocery	25424.93
REGGC	Reggiani Caseifici	1221.94
RICAR	Ricardo Adocicados	4633.28
RICSU	Richter Supermarkt	3921.40
ROMEY	Romero y tomillo	498.50
SANTG	Santé Gourmet	1758.40
SAVEA	Save-a-lot Markets	40452.00
SEVES	Seven Seas Imports	10837.99
SIMOB	Simons bistro	13072.20
SPLIR	Split Rail Beer & Ale	8286.63
SUPRD	Suprêmes délices	8818.28
THEBI	The Big Cheese	336.00
THECR	The Cracker Box	1393.24
TOMSP	Toms Spezialitäten	2004.34
TORTU	Tortuga Restaurante	7134.10
TRADH	Tradição Hipermercados	1320.40
TRAIH	Trail's Head Gourmet Provisioners	1333.30
VAFFE	Vaffeljernet	5979.05
VICTE	Victuailles en stock	5512.32
VINET	Vins et alcools Chevalier	121.60
WANDK	Die Wandernde Kuh	7079.55
WARTH	Wartian Herkku	11089.70
WELLI	Wellington Importadora	3222.14
WHITC	White Clover Markets	6490.86
WILMK	Wilman Kala	120.00
WOLZA	Wolski Zajazd	1267.00

11. How to add interval to date – exercise
Good job! Let's do one more exercise with INTERVAL.

Exercise
The quarter is a period of three months – the first quarter (Q1) is a period of the first three months (January, February, March),
	the second quarter (Q2) is a period of the second three months (April, May, June), etc. 
	In the world of finance, the quarter is a very important time period and quarterly analyses are very common.

Show the total revenue generated in the first quarter of 2018. 
	Group revenue by each shipping country. Show two columns: ship_country and total_revenue. You can use the following code:

'2018-01-01'::DATE + INTERVAL '3' month	

select 
	ship_country,
    sum(amount) as total_revenue
from orders
join customers 
using (customer_id)
where order_date >= '2018-01-01'
     and order_date <= '2018-01-01'::DATE + INTERVAL '3' month
     group by ship_country

ship_country	total_revenue
Argentina	2275.70
Austria	14786.40
Belgium	9742.50
Brazil	17196.94
Canada	187.00
Finland	1401.00
France	9657.39
Germany	44599.09
Ireland	17035.79
Italy	3188.90
Mexico	2174.50
Norway	3354.40
Poland	587.50
Spain	3901.46
Sweden	7532.70
UK	4607.50
USA	44083.02
Venezuela	7325.63

------------------------------------------------------------------------------------------------
12. 	Calculating the beginning of the current period
Great! In analyzing revenue trends it is often important to calculate the beginning of the current period
	(e.g. the current day, month, year, etc.). 
	This will help us create revenue reports for the current year, month, quarter, etc. 
	In PostgreSQL there is a function named DATE_TRUNC(). Take a look:

SELECT DATE_TRUNC('month', CURRENT_TIMESTAMP) AS current_month_start;
---------------------
The expression CURRENT_TIMESTAMP returns current timestamp, that is the current date and time.

The DATE_TRUNC() function has two arguments:

the text defining precision, e.g., 'minute', 'hour', 'day', 'month', 'quarter', or 'year'.
the date that is to be rounded down with a precision defined in the first argument.
The DATE_TRUNC() function returns a timestamp with unwanted details removed, e.g., the result of:

SELECT DATE_TRUNC('day', '2019-09-09 12:31:08.5'::timestamp)
is 2019-09-09 00:00:00.0 and the result of:

SELECT DATE_TRUNC('year', '2018-07-10'::timestamp)
is 2018-01-01 00:00:00.0.

Exercise
In a column named current_year_start, show the beginning of the current year using the function DATE_TRUNC().

SELECT DATE_TRUNC('year', current_timestamp) as current_year_start

current_year_start
2024-01-01 00:00:00+00

14-----------------------------------Month-to-date revenue----------------------------------
Good job! The last thing we'll show you in this part is how to do revenue reports for the current year, month, etc. 
	They're another frequent financial report, and they show how much the company earned so far in the given current period. 
	Commonly used report types are:

year-to-date (YTD) – refers to the period beginning the first day of the current calendar year up to the current date.
month-to-date (MTD) – refers to the period of time between the 1st of the current month and the current date.
quarter-to-date (QTD) – refers to the period of time between the beginning of the current quarter and the current date.
YTD, MTD, and QTD reports are used by business owners, investors, and individuals to analyze their revenue, income, business earnings, and investment returns for the current period of time.

For example, if we want to show the month-to-date revenue:

SELECT
  c.customer_id,
  company_name,
  SUM(amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE order_date >= DATE_TRUNC('month', CURRENT_TIMESTAMP)
GROUP BY c.customer_id, company_name;
If you look at the WHERE clause, you can see we used the technique we learned in the previous exercise to compute the beginning of the current month.

Exercise
Calculate the year-to-date revenue for each customer. Show two columns: customer_id and total_revenue.

SELECT
  c.customer_id,
  SUM(amount) AS total_revenue 
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE order_date >= DATE_TRUNC('year', CURRENT_TIMESTAMP)
GROUP BY c.customer_id
customer_id	total_revenue
QUEEN	2027.08
RATTC	1255.72
TORTU	360.00
FRANS	266.00
PERIC	300.00
LEHMS	1629.98
RICAR	1838.00
HUNGO	1342.95
BONAP	792.75
DRACD	86.85
SAVEA	4330.40
ERNSH	5218.00
REGGC	406.40
GREAL	510.00
SIMOB	232.09
LILAS	673.92
RICSU	498.10
WHITC	928.75

Month-to-date revenue – exercise
Great! One more exercise!

Exercise
For each employee, find their quarter-to-date revenue. 
	Show three columns: employee_id, last_name, and total_revenue. Use a DATE_TRUNC() function.
SELECT
  employee_id,
  last_name,
  SUM(amount) AS total_revenue 
FROM employees
JOIN orders
  using (employee_id)
WHERE order_date >= DATE_TRUNC('quarter', CURRENT_TIMESTAMP)
GROUP BY employee_id
employee_id	last_name	total_revenue
4	Peacock	792.75
2	Fuller	300.00
7	King	232.09
1	Davolio	1255.72
8	Callahan	498.10


15 ---------------------------------Summary-------------------------------
Perfect! That's it for this part of the course. Let's have a short summary before we continue.

To find rows for three months starting from March 20, 2017, use:
SELECT ... FROM ...
WHERE column_name >= '2017-03-20'
  AND column_name < '2017-03-20'::DATE + INTERVAL '3' month
	
To find rows for the current month, use:
SELECT ... FROM ...
WHERE column_name >= DATE_TRUNC('month', CURRENT_TIMESTAMP)
	==================================================
16 Exercise
Show the total revenue for 2018 in a column named total_revenue.
	
	SELECT  SUM(amount) AS total_revenue
FROM orders
WHERE order_date >= '2018-01-01'
  AND order_date < '2018-01-01'::DATE + INTERVAL '1' year

total_revenue
193637.42

==============
17 Exercise
For each shipping country, find the month-to-date revenue. Show two columns: ship_country and total_revenue.
	
select 
	ship_country,
    sum(amount) as total_revenue
from orders
join customers 
using (customer_id)
where order_date >=DATE_trunc('month', CURRENT_TIMESTAMP)  
                              group by ship_country
ship_country	total_revenue
USA	1255.72
France	792.75
Denmark	232.09
Switzerland	498.10
Mexico	300.00

