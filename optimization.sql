-- Query performance BEFORE indexing
EXPLAIN ANALYZE
SELECT cu.customer_id, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY cu.customer_id
ORDER BY total_spend DESC;

-- Add indexes on foreign keys and commonly filtered columns
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);

-- Query performance AFTER indexing (re-run same query, compare)
EXPLAIN ANALYZE
SELECT cu.customer_id, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY cu.customer_id
ORDER BY total_spend DESC;
