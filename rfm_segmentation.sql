WITH order_summary AS (
    SELECT o.customer_id,
           MAX(o.order_date) AS last_order_date,
           COUNT(DISTINCT o.order_id) AS frequency,
           SUM(oi.quantity * oi.unit_price) AS monetary
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
),
rfm_scores AS (
    SELECT customer_id,
           last_order_date,
           frequency,
           monetary,
           CURRENT_DATE - last_order_date AS recency_days,
           NTILE(4) OVER (ORDER BY CURRENT_DATE - last_order_date DESC) AS recency_score,
           NTILE(4) OVER (ORDER BY frequency ASC) AS frequency_score,
           NTILE(4) OVER (ORDER BY monetary ASC) AS monetary_score
    FROM order_summary
)
SELECT customer_id,
       recency_days,
       frequency,
       monetary,
       recency_score,
       frequency_score,
       monetary_score,
       (recency_score + frequency_score + monetary_score) AS rfm_total,
       CASE
           WHEN (recency_score + frequency_score + monetary_score) >= 10 THEN 'Champion'
           WHEN (recency_score + frequency_score + monetary_score) >= 7  THEN 'Loyal'
           WHEN (recency_score + frequency_score + monetary_score) >= 4  THEN 'At Risk'
           ELSE 'Lost'
       END AS segment
FROM rfm_scores
ORDER BY rfm_total DESC;
