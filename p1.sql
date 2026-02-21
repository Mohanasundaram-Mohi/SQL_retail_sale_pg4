-----SQL RETAIL SALES ANALYSIS---P1
CREATE DATABASE sql_project_p2

DROP TABLE IF EXISTS RETAIL_SALES;

CREATE TABLE RETAIL_SALES
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(18),
    age INT,
    category VARCHAR(22),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM RETAIL_SALES
LIMIT 10

SELECT COUNT(*) FROM RETAIL_SALES

-- FINDING NULL VALUES OF ALL COLUMNS 

SELECT * FROM RETAIL_SALES
WHERE transactions_id IS NULL

SELECT * FROM RETAIL_SALES
WHERE sale_date IS NULL

SELECT * FROM RETAIL_SALES
WHERE sale_time IS NULL

SELECT * FROM RETAIL_SALES
	WHERE transactions_id IS NULL
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
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DELETE NULL VALUES OR INSERT IF YOU HAVE ANY VALUES 

DELETE FROM retail_sales

	WHERE transactions_id IS NULL
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
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

---DATA EXPLORATION

--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale from retail_sales

-- HOW MANY UNIQUE CUSTOMERS WE HAVE? 
SELECT COUNT(DISTINCT customer_id) AS total_sale from retail_sales

SELECT DISTINCT category from retail_sales

--- DATA ANALYSIS AND BUSINESS KEY PROBLEMES & ANSWERS 


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales WHERE sale_date= '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
	* from retail_sales where category ='Clothing' 
	and to_char(sale_date,'yyyy-mm')='2022-11'
	AND
	quantity>=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category, sum(total_sale) as net_sale,
	count (*) as total_orders
	FROM retail_sales
	group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

 select round(avg(age),2) as avg_age from retail_sales where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM RETAIL_SALES
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM RETAIL_SALES
GROUP BY gender, category
ORDER BY 2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(
select 
	Extract(YEAR FROM sale_date) as year, 
	Extract(MONTH FROM sale_date) as month,
	avg(total_sale) AS total_sales,
	rank()over(partition by Extract(YEAR FROM sale_date)order by avg(total_sale) desc) as rank
	from retail_sales
	group by 1,2
	)as t1
	where rank=1
--order by 1,3 desc
	
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select 
customer_id, sum(total_sale)as total_sales	
from retail_sales group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category, count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category	

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) > 12 
             AND EXTRACT(HOUR FROM sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM RETAIL_SALES
GROUP BY shift
ORDER BY shift;

--- END OF PROJECT 