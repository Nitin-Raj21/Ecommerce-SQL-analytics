-- 1. Running total of revenue by day
SELECT o.order_date,
       SUM(oi.quantity * oi.unit_price) AS daily_revenue,
       SUM(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY o.order_date) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- 2. Month-over-month revenue growth
WITH monthly_revenue AS (
    SELECT DATE_TRUNC('month', o.order_date) AS month,
           SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 1
)
SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
       ROUND(
         (revenue - LAG(revenue) OVER (ORDER BY month))
         / NULLIF(LAG(revenue) OVER (ORDER BY month), 0) * 100, 2
       ) AS pct_growth
FROM monthly_revenue
ORDER BY month;

-- 3. Rank customers by total spend
SELECT cu.customer_id, cu.first_name,
       SUM(oi.quantity * oi.unit_price) AS total_spend,
       RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS spend_rank
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY cu.customer_id, cu.first_name;

-- 4. 3-order moving average of order value per customer
SELECT customer_id, order_id, order_total,
       ROUND(AVG(order_total) OVER (
           PARTITION BY customer_id
           ORDER BY order_id
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) AS moving_avg_3
FROM (
    SELECT o.customer_id, o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id, o.order_id
) sub;
