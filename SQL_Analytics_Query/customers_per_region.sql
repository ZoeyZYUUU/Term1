SELECT c.customer_state AS region,COUNT(DISTINCT c.customer_id) AS active_customers
FROM customers_dataset c JOIN orders_dataset o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY active_customers DESC;
