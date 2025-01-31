-- 41. Identify the Most Discounted Products
SELECT p.product_id, p.name AS product_name, SUM(d.discount_amount) AS total_discount
FROM products p
JOIN discounts d ON p.product_id = d.product_id
GROUP BY p.product_id, p.name
ORDER BY total_discount DESC
LIMIT 5;

-- 42. Top 5 Customers by Lifetime Value
SELECT o.user_id, u.full_name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY o.user_id, u.full_name
ORDER BY total_spent DESC
LIMIT 5;

-- 43. Identify Repeat Customers
SELECT o.user_id, u.full_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY o.user_id, u.full_name
HAVING total_orders >= 3;

-- 44. Calculate Customer Retention Rate
WITH monthly_orders AS (
    SELECT user_id, DATE_FORMAT(order_date, '%Y-%m') AS order_month
    FROM orders
    GROUP BY user_id, order_month
)
SELECT COUNT(DISTINCT user_id) AS retained_customers,
       (COUNT(DISTINCT user_id) / (SELECT COUNT(*) FROM users)) * 100 AS retention_rate
FROM monthly_orders
WHERE order_month IN (
    DATE_FORMAT(NOW(), '%Y-%m'),
    DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH), '%Y-%m'),
    DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 2 MONTH), '%Y-%m')
);

-- 45. Identify Churned Users (Users Who Have Not Purchased in the Last 6 Months)
SELECT user_id, full_name FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM orders
    WHERE order_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
);

-- 47. Retrieve the 5 Most Recently Ordered Products
SELECT p.name, o.order_date
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
ORDER BY o.order_date DESC
LIMIT 5;

-- 49. Identify High-Value Orders (Top 10% by Order Value)
WITH order_values AS (
    SELECT order_id, total_amount, PERCENT_RANK() OVER (ORDER BY total_amount DESC) AS percentile
    FROM orders
)
SELECT * FROM order_values WHERE percentile <= 0.10;

-- 50. Find Products That Have Been Ordered More Than Their Available Stock
SELECT p.product_id, p.name, pv.stock, SUM(oi.quantity) AS total_ordered
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_variants pv ON oi.product_id = pv.product_id
GROUP BY p.product_id, p.name, pv.stock
HAVING total_ordered > pv.stock;
