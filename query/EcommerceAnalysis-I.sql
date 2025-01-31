USE ECOMMERCEDATABASE; 

-- 1. Retrieve All Users and Their Roles
SELECT u.user_id, u.full_name, u.email, r.role_name
FROM users u
JOIN user_roles r ON u.role_id = r.role_id;

-- 2. Count Total Orders Per User
SELECT u.user_id, u.full_name, COUNT(o.order_id) AS total_orders
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_orders DESC;

-- 3. Get Total Revenue Per Product
SELECT p.product_id, p.name AS product_name, SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

-- 4. Find the Total Number of Orders
SELECT COUNT(order_id) AS total_orders FROM orders;

-- 5. List All Available Categories
SELECT DISTINCT category_name FROM categories;

-- 6. Find the Most Expensive Product
SELECT * FROM products ORDER BY price DESC LIMIT 1;

-- 7. Count Total Products by Each Brand
SELECT b.brand_name, COUNT(p.product_id) AS total_products
FROM brands b
JOIN products p ON b.brand_id = p.brand_id
GROUP BY b.brand_name;

-- 8. Find Average Order Value
SELECT AVG(total_amount) AS avg_order_value FROM orders;

-- 9. Find Orders with a Specific Status (e.g., 'Shipped')
SELECT * FROM orders WHERE order_status = 'Shipped';

-- 10. List Users Who Have Written Reviews
SELECT DISTINCT u.user_id, u.full_name
FROM users u
JOIN reviews r ON u.user_id = r.user_id;

-- 11. Retrieve Order Items for a Specific Order
SELECT * FROM order_items WHERE order_id = 1001;

-- 12. Count Total Number of Users
SELECT COUNT(user_id) AS total_users FROM users;

-- 13. Get the List of Active Shipping Methods
SELECT DISTINCT method_name FROM shipping_methods;

-- 14. Find the Total Quantity of Products Sold
SELECT SUM(quantity) AS total_products_sold FROM order_items;

-- 15. Retrieve Payment Details for Orders
SELECT p.payment_id, p.order_id, p.payment_method, p.payment_status
FROM payments p;

-- 16. Count Number of Unique Users Who Placed Orders
SELECT COUNT(DISTINCT user_id) AS unique_customers FROM orders;

-- 17. Find the Latest Orders Placed
SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

-- 19. Find All Users Who Have Made a Purchase in the Last 30 Days
SELECT DISTINCT user_id FROM orders WHERE order_date >= NOW() - INTERVAL 30 DAY;

-- 15. Retrieve the Most Recent Reviews
SELECT * FROM reviews ORDER BY created_at DESC LIMIT 5;


