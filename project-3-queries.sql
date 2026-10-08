-- ============================================================
-- Project 3: SQL Data Analysis
-- DecodeLabs Data Analytics Internship, Batch 2026
-- Author: Peter Omotoso
--
-- Dataset: 1,200 e-commerce orders (January 2023 to June 2025)
-- Table:   Sheet1
-- Columns: OrderID, Date, CustomerID, Product, Quantity, UnitPrice,
--          ShippingAddress, PaymentMethod, OrderStatus, TrackingNumber,
--          ItemsInCart, CouponCode, ReferralSource, TotalPrice
-- Dialect: SQLite (Date is stored as text, YYYY-MM-DD)
-- Note:    No NULL values in the dataset, so COUNT, SUM and AVG are reliable.
-- ============================================================

-- Query 1: What do the key details of the first 10 orders look like?
SELECT OrderID, Date, Product, Quantity, TotalPrice
FROM Sheet1
LIMIT 10;

-- Query 2: Which orders are for Laptops? (first 10 shown)
SELECT OrderID, Product, Quantity, TotalPrice
FROM Sheet1
WHERE Product = 'Laptop'
LIMIT 10;

-- Query 3: Which orders are worth $3,000 or more?
SELECT OrderID, Product, Quantity, TotalPrice
FROM Sheet1
WHERE TotalPrice >= 3000
ORDER BY TotalPrice DESC;

-- Query 4: How many orders used a coupon code starting with 'S'?
SELECT CouponCode, COUNT(*) AS total_orders
FROM Sheet1
WHERE CouponCode LIKE 'S%'
GROUP BY CouponCode;

-- Query 5: What are the 10 lowest-value orders? (ascending order)
SELECT OrderID, Product, Quantity, TotalPrice
FROM Sheet1
ORDER BY TotalPrice ASC
LIMIT 10;

-- Query 6: What are the 10 highest-value orders? (descending order)
SELECT OrderID, Product, Quantity, TotalPrice
FROM Sheet1
ORDER BY TotalPrice DESC
LIMIT 10;

-- Query 7: How many orders does each product have?
SELECT Product, COUNT(*) AS total_orders
FROM Sheet1
GROUP BY Product
ORDER BY total_orders DESC;

-- Query 8: How much revenue does each product generate?
SELECT Product, ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM Sheet1
GROUP BY Product
ORDER BY total_revenue DESC;

-- Query 9: What is the average order value for each payment method?
SELECT PaymentMethod, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM Sheet1
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC;

-- Query 10: How many orders and how much revenue does each order status have?
SELECT OrderStatus, COUNT(*) AS total_orders, ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM Sheet1
GROUP BY OrderStatus
ORDER BY total_orders DESC;

-- Query 11: Which products earn more than $180,000 in revenue?
SELECT Product, ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM Sheet1
GROUP BY Product
HAVING SUM(TotalPrice) > 180000
ORDER BY total_revenue DESC;

-- Query 12: What percentage of total revenue does each product contribute?
SELECT Product,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(SUM(TotalPrice) * 100.0 / (SELECT SUM(TotalPrice) FROM Sheet1), 2) AS pct_of_total
FROM Sheet1
GROUP BY Product
ORDER BY total_revenue DESC;

-- Query 13: Among Delivered orders only, which referral source brings the most revenue?
SELECT ReferralSource, COUNT(*) AS delivered_orders, ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM Sheet1
WHERE OrderStatus = 'Delivered'
GROUP BY ReferralSource
ORDER BY total_revenue DESC;

-- Query 14: How many orders and how much revenue were there in each year?
SELECT strftime('%Y', Date) AS order_year,
       COUNT(*) AS total_orders,
       ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM Sheet1
GROUP BY strftime('%Y', Date)
ORDER BY order_year;
