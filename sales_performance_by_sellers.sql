WITH SellerSales AS (
    SELECT oi.seller_id, COUNT(oi.order_id) AS Total_Orders, SUM(oi.price) AS Total_Sales
    FROM order_items_dataset AS oi
    GROUP BY oi.seller_id
)

SELECT s.seller_id AS Seller_ID,g.geolocation_city AS Region,ss.Total_Orders,ss.Total_Sales
FROM SellerSales AS ss
JOIN sellers_dataset AS s ON ss.seller_id = s.seller_id
ORDER BY Region, Total_Sales DESC;

