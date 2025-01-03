# My_Project_Restaurant_Order_Analysis
 This project demonstrates my skills in Excel and SQL

![Restaurant Order Analysis Gif](https://github.com/user-attachments/assets/f6dd9faf-b619-4bdd-9ef1-2e87f6793e4d)


### Project Overview 

The goal of this project is to analyze menu offerings, sales performance, and customer behavior to identify areas for improvement and develop actionable strategies for enhancing customer satisfaction, increasing revenue, and optimizing restaurant operations.

The goal of this project is to provide an in-depth analysis of:
- Various types of data analyst careers.
- Required technical skills.
- Salary ranges and influencing factors.
- Popular job posting platforms.
- Patterns in job postings based on dates and time
 
**Problem Statement**

1.	What were the least and most ordered items? What categories were they in?
2.	What do the highest spend orders look like? Which items did they buy and how much did they spend?
3.	Were there certain times that had more or less orders?
4.	Which cuisines should we focus on developing more menu items for based on the data?

**Data Overview**

Dataset Source: MavenAnalytics

File Size: 1 KB

Data Structure:

Menu_details table

menu_item_id	item_name, category, price

order_details table

order_details_id, order_id, order_date, order_time, item_id

**Restaurant Order Analysis Report (EDA)**

**Objective 1**

Explore the items table

1.	What are the least and most expensive items on the menu?
   - The least expensive item is the edamame Asian oof with a price of 5.00
   - The expensive item is Shrimp Scampi Italian food with a price of 19.95
2.	How many Italian dishes are on the menu? 
   - 9 Italian dishes are on the menu
3.	What are the least and most expensive Italian dishes on the menu?
   - Spaghetti 14.50
   - Fettuccine Alfredo 14.50
   - Cheese Lasagna 15.50
   - Mushroom Ravioli, 15.50 
4.	How many dishes are in each category? 
   - American		6
   - Asian		8
   - Mexican		9
   - Italian		9
5.	What is the average dish price within each category?
   - American		10.0000	
   - Asian		16.0000		
   - Italian		20.0000	
   -Mexican		13.0000	

**Objective 2**

Explore the orders table

1.	View the order_details table. What is the date range of the table?
   - January to March Year 2023
2.	How many orders were made within this date range? 
   - 5370 of order within 3 months
3.	Monthly Revenue and number of orders monthly?
   - March, Number of orders 4142, Revenue 54610.60 
   - January, Number of orders 4104, Revenue 53816.95 
   - February, Number of orders 3851, Revenue 50790.35 
4.	How many items were ordered within this date range?
   - 12234 items were order
5.	Which orders had the most number of items?
   - Order ID 330, 14 orders
   - Order ID 440, 14 orders
   - Order ID 443, 14 orders
   - Order ID 1957, 14 orders
   - Order ID 2675, 14 orders
   - Order ID 3473, 14 orders
   - Order ID 4305, 14 orders
6.	How many orders had more than 12 items?
   - 20 number of orders had more than 12 items

**Analyze customer behavior**

Objective 3

1.	What were the least and most ordered items? What categories were they in?
   -  Least ordered item is Chicken Tacos, Mexican food with 123 orders in 3 months 
   - Most ordered items is Hamburger, American, with  622 orders in 3 months
2.	What were the top 5 orders that spent the most money?
   - Order ID 440, 192.15
   - Order ID 2075, 191.05
   - Order ID 1957, 190.10
   - Order ID 330, 189.70
   - Order ID 2675, 185.10

View the details of the highest spend order. Which specific items were purchased?

Steak Tacos, Hot Dog, Spaghetti, Spaghetti & Meatballs, Fettuccine Alfredo, Korean Beef Bowl, Meat, Lasagna, Edamame, Chips & Salsa, Chicken Parmesan, French Fries, Eggplant Parmesan

Most of the ordered items are Italian dishes.

3.	View the details of the top 5 highest spend orders 

Most ordered in the top 5 are Italian, Asian, Mexican dishes and the least ordered is American dishes.

### Creating Database Using MySQL Workbench 

~~~
DROP DATABASE IF EXISTS Project_Restaurant_Order_Analysis;
CREATE DATABASE Project_Restaurant_Order_Analysis;

USE Project_Restaurant_Order_Analysis;

--
-- Table structure for table `order_details`
--

CREATE TABLE order_details (
  order_details_id SMALLINT NOT NULL,
  order_id SMALLINT NOT NULL,
  order_date DATE,
  order_time TIME,
  item_id SMALLINT,
  PRIMARY KEY (order_details_id)
);

--
-- Table structure for table `menu_items`
--

CREATE TABLE menu_items (
  menu_item_id SMALLINT NOT NULL,
  item_name VARCHAR(45),
  category VARCHAR(45),
  price DECIMAL(5,2),
  PRIMARY KEY (menu_item_id)
);
~~~
 
Explanatory Data Analysis Using MySQL Workbench 

~~~
-- Analysis
-- Objective 1
-- Explore the items table
-- Your first objective is to better understand the items table by finding the number of rows in the table, 
SELECT COUNT(*) AS cnt_rows
FROM menu_items; -- 32 of rows and 4 columns

SELECT COUNT(*) AS cnt_rows
FROM order_details; -- 12234 of rows 4 columns
~~~

~~~
-- the least and most expensive items, and the item prices within each category.
SELECT 	item_name,
		category,
        price
FROM menu_items
ORDER BY price;
-- least expensive item is edamame asian oof with a price of 5.00
-- expensive item is Shrimp Scampi italian food with a price of 19.95
~~~

~~~
-- View the menu_items table and write a query to find the number of items on the menu
SELECT COUNT(menu_item_id)
FROM menu_items; --  32 items
~~~

~~~
-- What are the least and most expensive items on the menu?
SELECT 	menu_item_id,
		item_name,
        price
FROM menu_items
ORDER BY price;
-- least expensice item is edamame asian oof with a price of 5.00
-- expensive item is Shrimp Scampi italian food with a price of 19.95
~~~

~~~
-- How many Italian dishes are on the menu?
SELECT 	COUNT(menu_item_id)
FROM menu_items
WHERE category = 'italian';
~~~

~~~
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
~~~

~~~
-- How many dishes are in each category? 
SELECT 	category,
		COUNT(category) AS cnt_dishes_in_category
FROM menu_items
GROUP BY category;
-- American	6
-- Asian	8
-- Mexican	9
-- Italian	9
~~~

~~~
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
~~~

~~~
-- Objective 2
-- Explore the orders table
-- Your second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.
-- View the order_details table. What is the date range of the table?
SELECT 	MIN(order_date) AS date_range_min,
		MAX(order_date) AS date_range_maxw
FROM order_details;
-- January to March Year 2023 
~~~

~~~
-- How many orders were made within this date range? '5370' orders were made
SELECT	COUNT(DISTINCT order_id) AS item_count
FROM order_details;
~~~

~~~
-- How many items were ordered within this date range? '12234' items were order
SELECT	COUNT(order_details_id) AS item_count
FROM order_details;
~~~

~~~
-- Which orders had the most number of items?
SELECT 	order_id,
		COUNT(item_id) AS cnt_orders
FROM order_details
WHERE item_id IS NOT NULL
GROUP BY order_id
ORDER BY COUNT(item_id) DESC;
~~~

~~~
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
~~~

~~~
-- Objective 3
-- Analyze customer behavior
-- Your final objective is to combine the items and orders tables, find the least and most ordered categories, and dive into the details of the highest spend orders.
-- Combine the menu_items and order_details tables into a single table
SELECT *
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id;
~~~

~~~
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
~~~

~~~
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
~~~

~~~
-- View the details of the highest spend order. Which specific items were purchased?
SELECT 	od.order_id,
		mi.item_name,
		mi.category
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
WHERE od.order_id = 440
GROUP BY od.order_id, mi.item_name, mi.category;
~~~

~~~
-- View the details of the top 5 highest spend orders
SELECT 	od.order_id,
		mi.item_name,
		mi.category
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
WHERE od.order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY od.order_id, mi.item_name, mi.category;

~~~

~~~
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
~~~

~~~
-- Date Analysis 
SELECT 	MONTHNAME(od.order_date) AS month,
		COUNT(od.order_id) AS cnt_order
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY MONTHNAME(od.order_date);
~~~

~~~
SELECT 	mi.category,
		MONTHNAME(order_date) AS month,
		COUNT(od.order_id) AS cnt_order
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY mi.category, MONTHNAME(od.order_date)
ORDER BY category, month, cnt_order;
~~~

~~~
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
~~~

~~~
-- Montly Revenue and number of orders monthly
SELECT 	MONTHNAME(od.order_date) AS month,
		COUNT(od.item_id) AS num_orders,
        SUM(price) AS total_spend
FROM menu_items AS mi
JOIN order_details AS od
ON mi.menu_item_id = od.item_id
GROUP BY MONTHNAME(od.order_date)
ORDER BY total_spend DESC;
~~~

~~~
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
~~~

### Excel Visualization

![image](https://github.com/user-attachments/assets/f6205488-968c-48d6-9752-0b4994293c5e)

**Visualization Overview**

Type: Donut Chart

Insight: American dishes do not have that much items, and the Italian price is so much higher than other food

**Recommendation:**

Menu Enhancement

Do a customer survey about the dishes and prices of foods and ask what do they recommend about it.

Diversify American Dishes
- Add more American comfort food options, such as BBQ ribs, sliders, or mac and cheese, to appeal to a broader audience.
- Highlight American dishes with combo meal deals or promotional discounts to increase visibility.
Balance Pricing Across Categories
- Evaluate customer sensitivity to Italian dish pricing. Consider introducing smaller portion sizes or budget-friendly Italian options to attract more customers.

Introduce Seasonal Specials
- Create a rotating menu of seasonal dishes, incorporating customer-favorite categories like Italian and Asian.

![image](https://github.com/user-attachments/assets/02811194-beab-45ef-b6c6-0e5b250e50a6)

**Visualization Overview**

Type: Clustered Chart

Insight: February, Number of orders 3851, Revenue 50790.35 has the lowest number of orders resulting to lowest revenue in January to March

**Recommendation:**

Factors 

- Many reasons Inflation surge because of pandemic, high inflation, consumer spending has weakened because household spending power has taken a hit from rising prices.
- Customers is buying more chocolate, flowers, and gifts because of February Month of heart introduce and discount introduce Valentine-themed promotions in February to counter low spending due to external factor

Sales and Marketing Strategies

Promotions for Low-Performing Months

- February revenue was the lowest. Counter this with Valentine-themed discounts, meal packages for couples, or “dine and win” promotions.
-	Utilize loyalty programs with points or discounts for repeat orders during slower months.

Highlight Popular Dishes
- Promote top-performing items like Hamburger and Italian dishes through social media and in-store displays.
-	Offer limited-time bundles featuring these dishes to boost sales.

Upselling and Cross-Selling
- Train staff to recommend complementary items for every order (e.g., drinks, desserts, or appetizers).
- Implement digital recommendations for online orders based on popular pairings.

![image](https://github.com/user-attachments/assets/bcede92b-708b-438c-bae3-9bdcd40226a4)

**Visualization Overview**

Type: Clustered Chart

Insight: Asian food has the most ordered food in the Top 5 customers highest spend and American food has the lowest.

**Recommendation:**

Customer Engagement

Focus on High-Performing Categories: Collect qualitative feedback on menu items like Chicken Tacos or Italian food to understand specific issues why they perform better and replicate those strategies across other categories.

Gather Feedback

-	Use surveys or feedback forms to understand why certain items are less popular (e.g., Chicken Tacos). Adjust recipes, presentation, or pricing accordingly.
Personalize Customer Experience
-	Use loyalty programs to collect data on customer preferences and offer personalized deals or recommendations.


