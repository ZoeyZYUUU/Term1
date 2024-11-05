# grouped payment types and dispayed its usage distribution
SELECT payment_type,COUNT(payment_type) AS payment_count,ROUND((COUNT(payment_type) * 100.0 / (SELECT COUNT(*) FROM order_payments_dataset)), 2) AS percentage
FROM order_payments_dataset
GROUP BY payment_type
ORDER BY payment_count DESC;

