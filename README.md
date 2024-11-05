# Repository for Data Engineering 1


## Analytics Planning

### Document Overview

1. `olist_sellers_dataset.csv`
2. `product_category_name_translation.csv`
3. `olist_orders_dataset.csv`
4. `olist_order_items_dataset.csv`
5. `olist_customers_dataset.csv`
6. `olist_geolocation_dataset.csv`
7. `olist_order_payments_dataset.csv`
8. `olist_order_reviews_dataset.csv`
9. `olist_products_dataset.csv`

### SQL Analytics Problems Hypothesis

1. Which product categories sell the most? Look at changes in sales volume on a monthly or quarterly basis.
2. What is the sales performance of different sellers? Rankings can be made by region and sales.
3. What is the average amount of a single order?
4. Customer distribution: The number of active customers in different regions, and identifying regions with high purchase frequency.
5. What are the payment method preferences of customers?
6. Average transaction amount per payment method.
7. What are the main characteristics of a poorly rated product or order? (e.g., shipping delays, specific product categories)
8. Average rating of various products and analysis of reasons for low ratings (based on evaluation text and rating distribution analysis).
9. How do average product category ratings and customer satisfaction change over time?

### Preliminary Analysis Plan

1. Data Cleaning:
   - Check data for integrity (such as missing values and duplicates).
   - Merge or map appropriately based on data dictionaries (such as product categories).
   - Establish a complete order record by connecting order, customer, order payment, and order item tables through order ID and customer ID.

2. Data Integration:
   - Connect product information through the product category table to provide accurate product category descriptions for analysis.

3. Calculation of Main Indicators:
   - Create common KPIs, such as total revenue, order quantity, customer unit price, return rate, etc.
   - Generate time series analysis on a monthly and quarterly basis to monitor changes in sales and revenue.

4. Customer Stratification and Segmentation:  
   - Stratify customers through the RFM (Recency, Frequency, Monetary) model to identify high-value customers.
   - Segment customer groups by region and behavior to identify market needs in different regions.

5. Report Generation and Visualization:  
   - Create summary reports showing sales trends, customer behavior, and review distribution.
   - Use SQL for group aggregation, conduct multi-dimensional analysis of orders, products, and customers, and visualize results using Power BI or other BI tools.

### Summary

1. Best-Selling Product Categories and Regions:  
   - Identify product categories and regions with the highest sales volume and revenue to assist in strategic market targeting.

2. Customer Behavior and Segmentation:  
   - Identify high-frequency customers and high-value areas to design marketing and loyalty programs.

3. Payment Method Preference:  
   - Analyze the utilization rate of payment methods to adjust the support for payment channels.

4. Product Improvement Suggestions:  
   - Improve service or product quality through low-score data analysis.


### Source
taken from kaggle dataset 
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

