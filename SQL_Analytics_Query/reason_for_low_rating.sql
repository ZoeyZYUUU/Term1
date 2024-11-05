# the average rating of each product
SELECT p.product_category_name,AVG(r.review_score) AS average_rating,COUNT(*) AS count_of_ratings
FROM order_items_dataset oi
JOIN products_dataset p ON oi.product_id = p.product_id
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY p.product_category_name
ORDER BY average_rating ASC;

# score distribution analysis
SELECT p.product_category_name,r.review_score,COUNT(*) AS count_of_ratings
FROM order_items_dataset oi
JOIN products_dataset p ON oi.product_id = p.product_id
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY p.product_category_name, r.review_score
ORDER BY p.product_category_name, r.review_score;
    
# analyze the reasons for the low score in the evaluation text
SELECT p.product_category_name,r.review_score,r.review_comment_message
FROM order_items_dataset oi
JOIN products_dataset p ON oi.product_id = p.product_id
JOIN order_reviews_dataset r ON oi.order_id = r.order_id
WHERE r.review_score IN (1, 2);


