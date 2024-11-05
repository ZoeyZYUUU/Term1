DROP VIEW IF EXISTS Rio_Customers;
CREATE VIEW Rio_Customers AS
SELECT * FROM customers_dataset WHERE customers_dataset.customer_city = 'rio de janeiro';