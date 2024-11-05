DELIMITER $$

# classify customers according to purchase frequency and total expenditure, and identify high-value customers.
CREATE EVENT UpdateCustomerSegmentation
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
    BEGIN
        INSERT INTO customer_segmentation (customer_id, recency, frequency, monetary)
        SELECT 
            customer_id,
            DATEDIFF(NOW(), MAX(order_purchase_timestamp)) AS recency,
            COUNT(order_id) AS frequency,
            SUM(price + freight_value) AS monetary
        FROM orders_dataset
        JOIN order_items_dataset USING (order_id)
        GROUP BY customer_id;
    END$$

DELIMITER ;

