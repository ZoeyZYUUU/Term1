# create database and tables 
CREATE DATABASE olist_data_analysis;
USE olist_data_analysis;
CREATE TABLE sellers_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
CREATE TABLE product_name_translation (
    product_category_name VARCHAR(50) PRIMARY KEY,
    translation VARCHAR(50)
);
CREATE TABLE orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME NULL,
    order_approved_at DATETIME NULL,
    order_delivered_carrier_date DATETIME NULL,
    order_delivered_customer_date DATETIME NULL,
    order_estimated_delivery_date DATETIME NULL
);
CREATE TABLE order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders_dataset(order_id),
    FOREIGN KEY (seller_id) REFERENCES sellers_dataset(seller_id)
);


CREATE TABLE customers_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);
CREATE TABLE geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
CREATE TABLE order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders_dataset(order_id)
);
CREATE TABLE order_reviews_dataset (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    FOREIGN KEY (order_id)
        REFERENCES orders_dataset (order_id)
);
CREATE TABLE products_dataset (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    FOREIGN KEY (product_category_name) REFERENCES product_name_translation(product_category_name)
);

SHOW VARIABLES LIKE 'secure_file_priv';
sHOW VARIABLES LIKE "local_infile";


use olist_data_analysis;
LOAD DATA INFILE '/private/tmp/brazil_database/olist_sellers_dataset.csv' 
INTO TABLE sellers_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_customers_dataset.csv' 
INTO TABLE customers_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_geolocation_dataset.csv' 
INTO TABLE geolocation_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_orders_dataset.csv' 
INTO TABLE orders_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(order_id, customer_id, order_status, 
 @order_purchase_timestamp, 
 @order_approved_at, 
 @order_delivered_carrier_date, 
 @order_delivered_customer_date, 
 @order_estimated_delivery_date)
SET order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');



# change the file path to where you downloaded the dataset tables
LOAD DATA INFILE '/private/tmp/brazil_database/olist_order_items_dataset.csv' 
INTO TABLE order_items_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_order_payments_dataset.csv' 
INTO TABLE order_payments_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_order_reviews_dataset.csv'
IGNORE INTO TABLE order_reviews_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/product_category_name_translation.csv'
IGNORE INTO TABLE product_name_translation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/private/tmp/brazil_database/olist_products_dataset.csv'
IGNORE INTO TABLE products_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;





