DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10    

SELECT 
    COUNT(*) 
FROM retail_sales

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
     cogs IS NULL
    OR
    total_sale IS NULL;


-- Data Exploration

-- How many sales we have?

SELECT COUNT(*) AS total_sales from retails_sales;

-- How many unique customer we have-
SELECT COUNT (DISTINCT transactions_id)AS total_sales FROM retails_sales;

SELECT DISTINCT category FROM retails_sales;


-- Data Analysis & business key problems & answer--

Q.1 - Write s SQL qwery to retrieve all columns for sales  made on 2022-11-05-

SELECT * FROM retails_sales
WHERE sale_date = '2022-11-05';

Q.2 - Write a SQL qwery to retrieve all transaction where category is 'Clothing' and the quantity
sold is more than 4 in the month of Nov-2022-

SELECT*FROM retails_sales
WHERE category = 'Clothing'
AND 
quantity >= 4
AND
TO_CHAR(sale_date,	'YYYY-MM')='2022-11'

Q.3- Write SQL qwery to calculate the total_sales for each category.

SELECT 
category,SUM(total_sale) AS net_sales,
COUNT(*) AS total_order
FROM retails_sales
GROUP BY 1;

Q.4- Write a SQL qwery to find the average age of customers who purchased items from
the 'Beauty' category.

SELECT ROUND(AVG(age),2) AS average_age
FROM retails_sales
WHERE category = 'Beauty';

Q.5- Write the SQL qwery to find all the transaction where total 
sale is greater than 1000.

SELECT * FROM retails_sales
WHERE total_sale > 1000;

Q.6- Write the SQL qwery to find the total number of transaction (transaction_id)
made by each gender in each category.

SELECT  category , gender,
COUNT(*) AS total_transaction
FROM retails_sales
GROUP BY category , gender
ORDER BY 1;

Q.7- Write a SQL qwery to calculate the average sale for each month. Find out
best selling month in each year.

SELECT year, month, avg_sales
FROM (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sales,
    RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS rank
  FROM retails_sales
  GROUP BY 1, 2
) AS t1
WHERE rank = 1;

Q.8- Write the SQL qwery to find the top 5 customer based on highest total sales.

SELECT 
customer_id,
SUM(total_sale)
FROM retails_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

Q.9- Write the SQL qwery to find the number of unique customers who purshased
item from each category.

SELECT  category,
COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retails_sales
GROUP BY 1;

Q.10- Write the SQL qwery to create each shift and no. of orders
(Example Morning <=12 , Afternoon between 12 & 17,Evening > 17)

WITH hourly_sales
AS
(
  SELECT *,
    CASE
	    WHEN EXTRACT(hour FROM sale_time)<12 THEN 'Morning'
        WHEN EXTRACT(hour FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS Shift
  FROM retails_sales
)
	SELECT
	 Shift,
	 COUNT(*) AS total_orders
	 FROM hourly_sales
	 GROUP BY Shift;


-- End of project--










