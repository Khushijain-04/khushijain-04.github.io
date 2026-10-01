create table orders(
Ship_mode varchar(100),
Segment	varchar(100),
Country	varchar(100),
City varchar(100),
State varchar(100),
Postal_Code	varchar(20),
Region	varchar(100),
Category varchar(100),
Sub_Category varchar(100),
Sales numeric,
Quantity int,
Discount	numeric,
Profit	numeric
);


Select * from orders;

--q1 Find the total sales and profit for each Region, sorted from highest to lowest sales.
SELECT
	REGION,
	SUM(SALES) AS TOTAL_SALES,
	SUM(PROFIT) AS TOTAL_PROFIT
FROM
	ORDERS
Group By region
order by total_sales desc;

--q2 Find the top 5 Sub-Categories by total profit.
SELECT
	SUB_CATEGORY,
	SUM(PROFIT) AS TOTAL_PROFIT
FROM
	ORDERS
GROUP BY
	SUB_CATEGORY
ORDER BY
	TOTAL_PROFIT DESC
LIMIT
	5;

--Which Category has the highest average discount?
SELECT
	CATEGORY,
	AVG(DISCOUNT) AS AVG_DISCOUNT
FROM
	ORDERS
GROUP BY
	CATEGORY
ORDER BY
	AVG_DISCOUNT DESC;
--Count how many orders exist for each Ship Mode
SELECT
	SHIP_MODE,
	COUNT(*) AS ORDER_COUNT
FROM
	ORDERS
GROUP BY
	SHIP_MODE
ORDER BY
	ORDER_COUNT ASC;

--Find total sales broken down by both Segment and Region together.
SELECT
	SEGMENT,
	REGION,
	SUM(SALES) AS TOTAL_SALES
FROM
	ORDERS
GROUP BY
	SEGMENT,
	REGION;


--Find all Sub-Categories that are actually losing money overall (total profit is negative)
SELECT
	SUB_CATEGORY,
	SUM(PROFIT) AS TOTAL_PROFIT
FROM
	ORDERS
GROUP BY
	SUB_CATEGORY
HAVING
	SUM(PROFIT) < 0
ORDER BY
	TOTAL_PROFIT ASC;


--Find the top 3 States by total sales.
SELECT
	STATE,
	SUM(SALES) AS TOTAL_SALES
FROM
	ORDERS
GROUP BY
	STATE
ORDER BY
	TOTAL_SALES DESC
LIMIT
	3;


--Calculate the profit margin (profit ÷ sales) for each Category, as a percentage
SELECT
	CATEGORY,
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS PROFIT_MARGIN
FROM
	ORDERS
GROUP BY
	CATEGORY
ORDER BY
	PROFIT_MARGIN DESC;


--Using a CASE statement, label each order as "High Discount" (discount > 20%) or "Low Discount" (20% or less), then count how many orders fall into each group.
SELECT 
  CASE WHEN discount > 0.20 THEN 'High Discount' ELSE 'Low Discount' END AS discount_group,
  COUNT(*) AS order_count
FROM orders
GROUP BY discount_group; 


--Find which Segment is most profitable within each Region (i.e., group by both, but focus on identifying the winner per region).
SELECT
	SEGMENT,
	REGION,
	SUM(PROFIT) AS TOTAL_PROFIT
FROM
	ORDERS
GROUP BY
	SEGMENT,
	REGION
ORDER BY
	REGION,
	TOTAL_PROFIT DESC;

--Rank all Sub-Categories by total profit using a window function (RANK()), instead of just sorting with ORDER BY.
SELECT
	SUB_CATEGORY,
	SUM(PROFIT) AS TOTAL_PROFIT,
	Rank() over(order by SUM(PROFIT) desc) as profit_rank
FROM
	ORDERS
GROUP BY
	SUB_CATEGORY;

