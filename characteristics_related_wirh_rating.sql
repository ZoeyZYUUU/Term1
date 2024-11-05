# the impact of delivery delays on ratings
SELECT 
    CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late Delivery' ELSE 'On Time' END AS delivery_status,
    AVG(r.review_score) AS average_rating,
    COUNT(*) AS count_of_orders
FROM orders_dataset o
JOIN order_reviews_dataset r ON o.order_id = r.order_id
GROUP BY delivery_status;


# relationship between product category and rating
SELECT p.product_category_name, AVG(r.review_score) AS average_rating, COUNT(*) AS count_of_ratings
FROM order_items_dataset oi
JOIN products_dataset p ON oi.product_id = p.product_id
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY p.product_category_name
ORDER BY average_rating ASC
LIMIT 0, 1000;


# impact of freight and additional costs
SELECT CASE WHEN oi.freight_value > 10 THEN 'High Freight' ELSE 'Low Freight' END AS freight_category,AVG(r.review_score) AS average_rating,COUNT(*) AS count_of_ratings
FROM order_items_dataset oi
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY freight_category
ORDER BY average_rating ASC;


# the relationship between product price and rating
SELECT CASE WHEN oi.price > 50 THEN 'High Price' ELSE 'Low Price' END AS price_category,AVG(r.review_score) AS average_rating,COUNT(*) AS count_of_ratings
FROM order_items_dataset oi
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY price_category
ORDER BY average_rating ASC;






