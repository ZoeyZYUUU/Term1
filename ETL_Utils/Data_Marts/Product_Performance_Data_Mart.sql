# This view aggregates order and sales related data such as total revenue average order amount and order quantity
CREATE VIEW ProductPerformanceDataMart AS
SELECT 
    p.product_id,
    p.product_category_name,
    AVG(r.review_score) AS avg_rating,
    COUNT(oi.order_id) AS sales_count,
    SUM(oi.price) AS total_revenue
FROM products_dataset p
JOIN order_items_dataset oi ON p.product_id = oi.product_id
LEFT JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY p.product_id;


CREATE TABLE Materialized_ProductPerformanceDataMart (
    product_id VARCHAR(50),
    product_category_name VARCHAR(50),
    avg_rating DECIMAL(3,2),
    sales_count INT,
    total_revenue DECIMAL(10,2)
);



# update my Materialized_ProductPerformanceDataMart table per hour
DELIMITER $$

CREATE EVENT RefreshMaterializedProductPerformanceDataMart
ON SCHEDULE EVERY 1 DAY
DO
    BEGIN
        DELETE FROM Materialized_ProductPerformanceDataMart;

        INSERT INTO Materialized_ProductPerformanceDataMart
        SELECT 
            p.product_id,
            p.product_category_name,
            AVG(r.review_score) AS avg_rating,
            COUNT(oi.order_id) AS sales_count,
            SUM(oi.price) AS total_revenue
        FROM products_dataset p
        JOIN order_items_dataset oi ON p.product_id = oi.product_id
        LEFT JOIN order_reviews_dataset r ON oi.order_id = r.order_id
        GROUP BY p.product_id;
    END$$

DELIMITER ;



