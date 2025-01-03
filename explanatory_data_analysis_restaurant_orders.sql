DELIMITER //
CREATE PROCEDURE call_tables()
BEGIN
SELECT * 
FROM menu_items;

SELECT *
FROM order_details;
END //
DELIMITER ;

-- Analysis
-- Objective 1
-- Explore the items table
-- Your first objective is to better understand the items table by finding the number of rows in the table, 
SELECT COUNT(*) AS cnt_rows
FROM menu_items; -- 32 of rows and 4 columns

SELECT COUNT(*) AS cnt_rows
FROM order_details; -- 12234 of rows 4 columns

-- the least and most expensive items, and the item prices within each category.
SELECT 	item_name,
		category,
        price
FROM menu_items
ORDER BY price;
-- least expensive item is edamame asian oof with a price of 5.00
-- expensive item is Shrimp Scampi italian food with a price of 19.95

-- View the menu_items table and write a query to find the number of items on the menu
SELECT COUNT(menu_item_id)
FROM menu_items; --  32 items
-- What are the least and most expensive items on the menu?
SELECT 	menu_item_id,
		item_name,
        price
FROM menu_items
ORDER BY price;
-- least expensice item is edamame asian oof with a price of 5.00
-- expensive item is Shrimp Scampi italian food with a price of 19.95

-- How many Italian dishes are on the menu?
SELECT 	COUNT(menu_item_id)
FROM menu_items
WHERE category = 'italian';

-- What are the least and most expensive Italian dishes on the menu?
-- least expensive is Italian items is Spaghetti	14.50
-- most  expensive is Italian items is Shrimp Scampi	19.95
SELECT 	category,
		item_name,
        price
FROM menu_items
WHERE category = 'italian'
ORDER BY price ASC;
-- 'Italian', 'Spaghetti', '14.50'
-- 'Italian', 'Fettuccine Alfredo', '14.50'
-- 'Italian', 'Cheese Lasagna', '15.50'
-- 'Italian', 'Mushroom Ravioli', '15.50'

-- How many dishes are in each category? 
SELECT 	category,
		COUNT(category) AS cnt_dishes_in_category
FROM menu_items
GROUP BY category;
-- American	6
-- Asian	8
-- Mexican	9
-- Italian	9

-- What is the average dish price within each category?
SELECT 	category,
		AVG(price) AS avg_price_per_category,
        (SUM(price) / COUNT(category)) AS check_avg_calculation,
        IF(AVG(price) !=  (SUM(price) / COUNT(category)), 'Not Match', 'Match') AS check_avg
FROM menu_items
GROUP BY category;

-- American	10.066667
-- Asian	13.475000
-- Mexican	11.800000
-- Italian	16.750000

-- Objective 2
-- Explore the orders table
-- Your second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.
-- View the order_details table. What is the date range of the table?
SELECT 	MIN(order_date) AS date_range_min,
		MAX(order_date) AS date_range_maxw
FROM order_details;
-- January to March Year 2023 

-- How many orders were made within this date range? '5370' orders were made
SELECT	COUNT(DISTINCT order_id) AS item_count
FROM order_details;

-- How many items were ordered within this date range? '12234' items were order
SELECT	COUNT(order_details_id) AS item_count
FROM order_details;

-- Which orders had the most number of items?
SELECT 	order_id,
		COUNT(item_id) AS cnt_orders
FROM order_details
WHERE item_id IS NOT NULL
GROUP BY order_id
ORDER BY COUNT(item_id) DESC;

-- How many orders had more than 12 items?
WITH cte AS (
	SELECT 	order_id,
		COUNT(item_id) AS cnt_orders
	FROM order_details
	WHERE item_id IS NOT NULL
	GROUP BY order_id
    HAVING COUNT(item_id) > 12
)
	SELECT COUNT(cnt_orders) orders_cnt_more_than_12
    FROM cte;

-- Objective 3
-- Analyze customer behavior
-- Your final objective is to combine the items and orders tables, find the least and most ordered categories, and dive into the details of the highest spend orders.
-- Combine the menu_items and order_details tables into a single table
SELECT *
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id;

-- What were the least and most ordered items? What categories were they in?
SELECT	mi.menu_item_id,
		mi.item_name,
		mi.category,
		COUNT(item_id) AS num_items
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY mi.menu_item_id
ORDER BY num_items ASC;
--  Least 115, Chicken Tacos, Mexican, 123 num_items and Most 101, Hamburger, American, 622 num_items
SELECT	mi.category,
		COUNT(item_id) AS num_items
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY mi.category
ORDER BY num_items ASC;
-- American, 2734 least order when comes in category, most number order when it comes to category 'Asian', '3470'

-- What were the top 5 orders that spent the most money?
SELECT 	od.order_id,
        SUM(mi.price) AS total_spent
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY od.order_id
ORDER BY total_spent DESC
LIMIT 5;
-- top 5 orders that spent the most money
-- 440, 192.15
-- 2075, 191.05
-- 1957, 190.10
-- 330, 189.70
-- 2675, 185.10

-- View the details of the highest spend order. Which specific items were purchased?
SELECT 	od.order_id,
		mi.item_name,
		mi.category
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
WHERE od.order_id = 440
GROUP BY od.order_id, mi.item_name, mi.category;

-- BONUS: View the details of the top 5 highest spend orders
SELECT 	od.order_id,
		mi.item_name,
		mi.category
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
WHERE od.order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY od.order_id, mi.item_name, mi.category;

WITH cte AS (
	SELECT 	od.order_id,
			mi.item_name,
			mi.category
	FROM menu_items AS mi
	JOIN order_details AS od
	ON mi.menu_item_id = od.item_id
	WHERE od.order_id IN (440, 2075, 1957, 330, 2675)
	GROUP BY od.order_id, mi.item_name, mi.category
)
	SELECT 	category,
			AVG(num_orders_by_catory) OVER (PARTITION BY category) AS avg_per_cat,
            (num_orders_by_catory / SUM(num_orders_by_catory) OVER ()) * 100 AS percentage_per_category
    FROM (SELECT 	COUNT(item_name) AS num_orders_by_catory,
			category
	FROM cte
    GROUP BY category
    ORDER BY num_orders_by_catory DESC) AS top_five_tble
    GROUP BY category;
-- percentage and avg of order per category in the top 5 highest spend orders


-- Date Analysis 
SELECT 	MONTHNAME(od.order_date) AS month,
		COUNT(od.order_id) AS cnt_order
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY MONTHNAME(od.order_date);

SELECT 	mi.category,
		MONTHNAME(order_date) AS month,
		COUNT(od.order_id) AS cnt_order
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY mi.category, MONTHNAME(od.order_date)
ORDER BY category, month, cnt_order;

SELECT 	YEAR(od.order_date) AS `Year`,
		DAY(od.order_date) AS `day`,
		COUNT(od.item_id) AS Number_orders
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY YEAR(od.order_date), DAY(od.order_date);
-- Month of february has the lowest sell rate because of the Inflation surge beacuase of pandemic
-- In those countries with high inflation, consumer spending has weakened because household spending power has taken a hit from rising prices
-- People is buting more chocolate for and flowers, teddy bear because of Month of hearts

-- Montly Revenue and number of orders monthly
SELECT 	MONTHNAME(od.order_date) AS month,
		COUNT(od.item_id) AS num_orders,
        SUM(price) AS total_spend
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY MONTHNAME(od.order_date)
ORDER BY total_spend DESC;

-- Total Revenue in 3 months
WITH cte AS (
SELECT 	od.order_id,
		COUNT(od.item_id) AS num_orders,
        SUM(price) AS total_spend
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY od.order_id
ORDER BY total_spend DESC
)
	SELECT SUM(total_spend) AS Total_Revenue
    FROM cte;


CALL call_tables();