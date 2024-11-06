# This view aggregates order and sales related data such as total revenue average order amount and order quantity
CREATE VIEW SalesDataMart AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    SUM(oi.price + oi.freight_value) AS total_revenue,
    AVG(oi.price + oi.freight_value) AS avg_order_value,
    COUNT(oi.order_item_id) AS items_count
FROM orders_dataset o
JOIN order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY o.order_id;


CREATE TABLE Materialized_SalesDataMart (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    total_revenue DECIMAL(10,2),
    avg_order_value DECIMAL(10,2),
    items_count INT
);



# update my Materialized_SalesDataMart table per hour
DELIMITER $$

CREATE EVENT RefreshMaterializedSalesDataMart
ON SCHEDULE EVERY 1 HOUR
DO
    BEGIN
        DELETE FROM Materialized_SalesDataMart;

        INSERT INTO Materialized_SalesDataMart
        SELECT 
            o.order_id,
            o.customer_id,
            o.order_status,
            o.order_purchase_timestamp,
            SUM(oi.price + oi.freight_value) AS total_revenue,
            AVG(oi.price + oi.freight_value) AS avg_order_value,
            COUNT(oi.order_item_id) AS items_count
        FROM orders_dataset o
        JOIN order_items_dataset oi ON o.order_id = oi.order_id
        GROUP BY o.order_id;
    END$$

DELIMITER ;



