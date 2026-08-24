-- 1. Total revenue per month
SELECT DATE_TRUNC('month', o.order_date) AS month,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;

-- 2. Top 5 best-selling products by quantity
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- 3. Revenue by category
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- 4. Customers with no orders yet
SELECT cu.customer_id, cu.first_name, cu.last_name
FROM customers cu
LEFT JOIN orders o ON cu.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 5. Average order value per customer
SELECT cu.customer_id, cu.first_name,
       ROUND(AVG(order_total), 2) AS avg_order_value
FROM customers cu
JOIN (
    SELECT o.order_id, o.customer_id, SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id
) sub ON cu.customer_id = sub.customer_id
GROUP BY cu.customer_id, cu.first_name;
