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



# Update my Materialized_ProductPerformanceDataMart table per hour
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


# Create a transformation stored procedure TransformProducts
DELIMITER $$

CREATE PROCEDURE TransformProducts()
BEGIN
    UPDATE extracted_products
    SET product_category_name = LOWER(product_category_name);
END$$

DELIMITER ;


DROP TABLE IF EXISTS Materialized_ProductPerformanceDataMart;


# Create a target table Materialized_ProductPerformanceDataMart
CREATE TABLE Materialized_ProductPerformanceDataMart (
    product_id VARCHAR(50),
    product_category_name VARCHAR(50),
    avg_rating DECIMAL(3,2),
    sales_count INT,
    total_revenue DECIMAL(10,2),
    PRIMARY KEY (product_id)
);



# Create the load stored procedure LoadProducts
DELIMITER $$

CREATE PROCEDURE LoadProducts()
BEGIN
    INSERT INTO Materialized_ProductPerformanceDataMart (product_id, product_category_name, avg_rating, sales_count, total_revenue)
    SELECT product_id, product_category_name, AVG(avg_rating), SUM(sales_count), SUM(total_revenue)
    FROM extracted_products
    GROUP BY product_id;

    DELETE FROM extracted_products;
END$$

DELIMITER ;







