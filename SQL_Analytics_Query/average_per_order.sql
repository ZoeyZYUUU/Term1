# order total per order
SELECT o.order_id,SUM(oi.price + oi.freight_value) AS order_total
FROM orders_dataset o JOIN order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_id;

# the average amount for order totals
SELECT AVG(order_total) AS average_order_amount
FROM (
    SELECT o.order_id,SUM(oi.price + oi.freight_value) AS order_total
    FROM orders_dataset o JOIN order_items_dataset oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
) AS order_totals;

    
    




