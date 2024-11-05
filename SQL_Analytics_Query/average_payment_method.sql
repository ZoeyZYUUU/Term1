# average transaction amount per payment method
SELECT payment_type, AVG(payment_value) AS average_transaction_amount
FROM order_payments_dataset
GROUP BY payment_type
ORDER BY average_transaction_amount DESC;