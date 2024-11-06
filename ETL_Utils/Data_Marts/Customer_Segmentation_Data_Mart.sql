# This view leverages customer data and order data to support customer Segmentation with data such as recent purchase time, purchase frequency, and total spend.
CREATE VIEW CustomerSegmentationDataMart AS
SELECT 
    c.customer_id,
    c.customer_city,
    DATEDIFF(NOW(), MAX(o.order_purchase_timestamp)) AS recency,
    COUNT(o.order_id) AS frequency,
    SUM(oi.price + oi.freight_value) AS monetary
FROM customers_dataset c
JOIN orders_dataset o ON c.customer_id = o.customer_id
JOIN order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY c.customer_id;


CREATE TABLE Materialized_CustomerSegmentationDataMart (
    customer_id VARCHAR(50),
    customer_city VARCHAR(100),
    recency INT,
    frequency INT,
    monetary DECIMAL(10,2)
);


# Update my Materialized_CustomerSegmentationDataMart table per hour
DELIMITER $$

CREATE EVENT RefreshMaterializedCustomerSegmentationDataMart
ON SCHEDULE EVERY 1 DAY
DO
    BEGIN
        DELETE FROM Materialized_CustomerSegmentationDataMart;

        INSERT INTO Materialized_CustomerSegmentationDataMart
        SELECT 
            c.customer_id,
            c.customer_city,
            DATEDIFF(NOW(), MAX(o.order_purchase_timestamp)) AS recency,
            COUNT(o.order_id) AS frequency,
            SUM(oi.price + oi.freight_value) AS monetary
        FROM customers_dataset c
        JOIN orders_dataset o ON c.customer_id = o.customer_id
        JOIN order_items_dataset oi ON o.order_id = oi.order_id
        GROUP BY c.customer_id;
    END$$

DELIMITER ;


# Create transformation stored procedure TransformCustomers
DELIMITER $$

CREATE PROCEDURE TransformCustomers()
BEGIN
    UPDATE extracted_customers
    SET customer_city = UPPER(customer_city);
END$$

DELIMITER ;


DROP TABLE IF EXISTS Materialized_CustomerSegmentationDataMart;


# Create a target table Materialized_CustomerSegmentationDataMart
CREATE TABLE Materialized_CustomerSegmentationDataMart (
    customer_id VARCHAR(50),
    customer_city VARCHAR(100),
    recency INT,
    frequency INT,
    monetary DECIMAL(10,2),
    PRIMARY KEY (customer_id)
);

DELIMITER $$


# Create the load stored procedure LoadCustomers
DELIMITER $$

CREATE PROCEDURE LoadCustomers()
BEGIN
    INSERT INTO Materialized_CustomerSegmentationDataMart (customer_id, customer_city, recency, frequency, monetary)
    SELECT customer_id, customer_city, MIN(recency), SUM(frequency), SUM(monetary)
    FROM extracted_customers
    GROUP BY customer_id;
    
    DELETE FROM extracted_customers;
END$$

DELIMITER ;









