-- 21. Identify the Most Popular Product by Order Count
SELECT p.product_id, p.name AS product_name, COUNT(oi.order_id) AS order_count
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY order_count DESC
LIMIT 1;

-- 22. Find Users Who Have Never Placed an Order
SELECT u.user_id, u.full_name, u.email
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;

-- 23. Calculate User's Average Order Value
SELECT o.user_id, u.full_name, AVG(o.total_amount) AS avg_order_value
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY o.user_id, u.full_name
ORDER BY avg_order_value DESC;

-- 24. Find Active Users Based on Page Views
SELECT p.user_id, u.full_name, COUNT(p.view_id) AS total_views
FROM page_views p
JOIN users u ON p.user_id = u.user_id
GROUP BY p.user_id, u.full_name
ORDER BY total_views DESC
LIMIT 10;

-- 25. Rank Users by Total Spending
SELECT u.user_id, u.full_name, SUM(o.total_amount) AS total_spent,
RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM orders o
JOIN users  u ON o.user_id = u.user_id
GROUP BY u.user_id, u.full_name;

-- 26. Find the Top 5 Revenue Generating Products
SELECT p.name, SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 5;

-- 27. Retrieve Orders That Contain More Than 5 Items
SELECT order_id, COUNT(*) AS item_count
FROM order_items
GROUP BY order_id
HAVING COUNT(*) > 5;

-- 28. Calculate Percentage of Orders in Each Status
SELECT order_status, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS percentage
FROM orders
GROUP BY order_status;

-- 29. Find Customers Who Have Used More Than One Payment Method
SELECT user_id, COUNT(DISTINCT payment_method) AS payment_methods
FROM payments
GROUP BY user_id
HAVING COUNT(DISTINCT payment_method) > 1;

-- 30. Identify Users with the Highest Number of Reviews
SELECT user_id, COUNT(review_id) AS total_reviews
FROM reviews
GROUP BY user_id
ORDER BY total_reviews DESC
LIMIT 5;

-- 31. Determine the Most Common Product Size Ordered
SELECT pv.size, COUNT(oi.product_id) AS total_orders
FROM order_items oi
JOIN product_variants pv ON oi.product_id = pv.product_id
GROUP BY pv.size
ORDER BY total_orders DESC;

-- 32. Retrieve the Most Frequently Searched Terms
SELECT search_query, COUNT(*) AS search_count
FROM search_logs
GROUP BY search_query
ORDER BY search_count DESC
LIMIT 10;

-- 36. Find the Orders That Used Coupons
SELECT DISTINCT o.order_id, c.coupon_code
FROM orders o
JOIN payments p ON o.order_id = p.order_id
JOIN coupons c ON p.order_id = c.coupon_id;

-- 37. Identify Users Who Have Repeatedly Contacted Customer Support
SELECT user_id, COUNT(*) AS ticket_count
FROM customer_support_tickets
GROUP BY user_id
HAVING COUNT(*) > 1;

