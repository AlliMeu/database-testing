-- migration_test.sql

CREATE DATABASE IF NOT EXISTS shop;
USE shop;

-- Step 1: Reset and create Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    item VARCHAR(255),
    amount DECIMAL(10,2)
);
INSERT INTO Orders (item, amount) VALUES
('Book', 12.99),
('Pen', 1.99),
('Notebook', 5.49),
('Backpack', 25.00),
('Laptop', 750.00);

-- Step 2: Reset and create Orders_Archive
DROP TABLE IF EXISTS Orders_Archive;
CREATE TABLE Orders_Archive (
    id INT PRIMARY KEY,
    item VARCHAR(255),
    amount DECIMAL(10,2)
);

-- Step 3: Migrate data
INSERT INTO Orders_Archive (id, item, amount)
SELECT id, item, amount FROM Orders;

-- Step 4: Verification
SELECT 
  (SELECT COUNT(*) FROM Orders) AS orders_count,
  (SELECT COUNT(*) FROM Orders_Archive) AS archive_count;

SELECT o.*
FROM Orders o
LEFT JOIN Orders_Archive a
  ON a.id=o.id AND a.item=o.item AND a.amount=o.amount
WHERE a.id IS NULL;
