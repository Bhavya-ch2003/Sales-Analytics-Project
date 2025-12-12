-- sales_queries.sql
-- Useful SQL queries for analyzing the sales dataset (table name: sales_data)

-- 1) Create table (example)
CREATE TABLE sales_data (
  OrderID VARCHAR(50),
  OrderDate DATE,
  Customer VARCHAR(100),
  Region VARCHAR(50),
  Product VARCHAR(100),
  Category VARCHAR(50),
  UnitPrice DECIMAL(10,2),
  Quantity INT,
  Discount DECIMAL(5,2),
  Sales DECIMAL(12,2),
  Cost DECIMAL(12,2),
  Profit DECIMAL(12,2)
);

-- 2) Total Sales and Profit
SELECT SUM(Sales) AS total_sales, SUM(Profit) AS total_profit
FROM sales_data;

-- 3) Sales by month
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS month, SUM(Sales) AS revenue
FROM sales_data
GROUP BY month
ORDER BY month;

-- 4) Top 10 products by revenue
SELECT Product, SUM(Sales) AS revenue
FROM sales_data
GROUP BY Product
ORDER BY revenue DESC
LIMIT 10;

-- 5) Region performance
SELECT Region, SUM(Sales) AS sales, SUM(Profit) AS profit
FROM sales_data
GROUP BY Region
ORDER BY sales DESC;

-- 6) Profit impact of discounts
SELECT Discount, SUM(Profit) AS total_profit, SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Discount
ORDER BY Discount;

-- 7) Repeat customers (customers with multiple orders)
SELECT Customer, COUNT(DISTINCT OrderID) AS orders
FROM sales_data
GROUP BY Customer
HAVING orders > 1
ORDER BY orders DESC;

-- 8) Average order value by region
SELECT Region, AVG(order_total) as avg_order_value
FROM (
  SELECT OrderID, Region, SUM(Sales) as order_total
  FROM sales_data
  GROUP BY OrderID, Region
) t
GROUP BY Region
ORDER BY avg_order_value DESC;
