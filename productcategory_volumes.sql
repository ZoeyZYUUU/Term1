SELECT p.product_category_name AS Category,
    COUNT(oi.order_id) AS Sales_Volume
FROM order_items_dataset AS oi
JOIN orders_dataset AS o ON oi.order_id = o.order_id
JOIN products_dataset AS p ON oi.product_id = p.product_id
GROUP BY Category
ORDER BY Sales_Volume DESC;
