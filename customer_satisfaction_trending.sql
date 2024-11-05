# average rating trends per month or quarter
SELECT DATE_FORMAT(r.review_creation_date, '%Y-%m') AS month,p.product_category_name,AVG(r.review_score) AS average_rating,COUNT(r.review_id) AS count_of_ratings
FROM order_reviews_dataset r
JOIN order_items_dataset oi ON r.order_id = oi.order_id
JOIN products_dataset p ON oi.product_id = p.product_id
GROUP BY month, p.product_category_name
ORDER BY month, p.product_category_name;

# trend of satisfaction
SELECT DATE_FORMAT(r.review_creation_date, '%Y-%m') AS month,p.product_category_name,AVG(CASE WHEN r.review_score >= 4 THEN 1 ELSE 0 END) * 100 AS satisfaction_rate,COUNT(r.review_id) AS count_of_ratings
FROM order_reviews_dataset r
JOIN order_items_dataset oi ON r.order_id = oi.order_id
JOIN products_dataset p ON oi.product_id = p.product_id
GROUP BY month, p.product_category_name
ORDER BY month, p.product_category_name;


# query and export data
SELECT DATE_FORMAT(r.review_creation_date, '%Y-%m') AS month,p.product_category_name,AVG(CASE WHEN r.review_score >= 4 THEN 1 ELSE 0 END) * 100 AS satisfaction_rate,COUNT(r.review_id) AS count_of_ratings
FROM order_reviews_dataset r
JOIN order_items_dataset oi ON r.order_id = oi.order_id
JOIN products_dataset p ON oi.product_id = p.product_id
GROUP BY month, p.product_category_name
ORDER BY month, p.product_category_name;

