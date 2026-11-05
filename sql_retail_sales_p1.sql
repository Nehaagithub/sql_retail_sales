

use Sql_project_p1;

-- Drop table if it already exists
DROP TABLE IF EXISTS retail_sales;

-- Create table
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales;

-- data cleaning --
SELECT * FROM retail_sales
WHERE total_sale IS NULL;

-- Data Explanation --

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How amany unique customers we have?
select count(distinct customer_id) as total_sale from retail_sales;
select distinct category from retail_sales;

-- Data Analysis and Key Business Problems --

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
FROM retail_sales
WHERE sale_date = '05-11-2022';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND sale_date >= '01-11-2022'
AND sale_date < '01-12-2022'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category 
SELECT 
category,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) AS average_age
    FROM retail_sales
    WHERE category = 'Beauty';
   
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select COUNT(*)
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year--
SELECT
    year,
    month,
    avg_sale
FROM
(
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE sales_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,
sum(total_sale) As total_sales
from retail_sales
group by customer_id
order by total_sales desc
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct customer_id) As unique_customers
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select
CASE
when hour(sale_time) <= 12 then 'Morning'
when hour(sale_time) between 13 AND 17 Then 'Afternoon'
ELSE 'evening'
END as shift,
COUNT(*) As total_orders
from retail_sales
group by shift;














