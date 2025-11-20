                               --PHASE 1--
--List all unique pizza categories
SELECT DISTINCT category FROM pizza_types;
--Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
SELECT pizza_type_id,name,COALESCE(ingredients, 'Missing Data') AS ingredients
FROM pizza_types
LIMIT 5;
--Check for pizzas missing a price (IS NULL).
SELECT * 
FROM pizzas
WHERE price IS NULL;
                                 --PHASE 2--
--Orders placed on '2015-01-01'--
SELECT *
FROM orders
WHERE date = '2015-01-01';
--List pizzas with price descending.
SELECT *
FROM pizzas
ORDER BY price DESC;
--Pizzas sold in sizes 'L' or 'XL'.
SELECT *
FROM pizzas
WHERE size IN ('L', 'XL');
--Pizzas priced between $15.00 and $17.00
SELECT *
FROM pizzas
WHERE price BETWEEN 15 AND 17;
--Pizzas with "Chicken" in the name
SELECT *
FROM pizza_types
WHERE name LIKE '%Chicken%';
--Orders on 2015-02-15 OR placed after 8 PM
SELECT *
FROM orders
WHERE date = '2015-02-15'
   OR EXTRACT(HOUR FROM time) >= 20;
                                       --PHSE 3--
--Total quantity of pizzas sold
SELECT SUM(quantity) AS total_quantity_sold
FROM order_details;
--Average pizza price
SELECT AVG(price) AS avg_price
FROM pizzas;
--Total order value per order
SELECT od.order_id,
    SUM(od.quantity * p.price) AS order_total
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY od.order_id;
--Total quantity sold per pizza category
SELECT pt.category,
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;
--Categories with more than 5,000 pizzas sold
SELECT pt.category,
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000;
--Pizzas never ordered
SELECT p.*
FROM pizzas p
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id
WHERE od.order_details_id IS NULL;
--Price differences between different sizes of same pizza (Self Join)
SELECT p1.pizza_type_id,p1.size AS size_1,p2.size AS size_2,p1.price AS price_1,p2.price AS price_2,(p2.price - p1.price) AS price_difference
FROM pizzas p1
JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id
   AND p1.size < p2.size;  
--

