online_food_ordering;

CREATE DATABASE online_food_ordering;

USE online_food_ordering;


-- CUSTOMER TABLE
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);


-- RESTAURANT TABLE
CREATE TABLE restaurant (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    phone_number VARCHAR(15)
);


-- FOOD ITEM TABLE
CREATE TABLE food_item (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    food_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    availability VARCHAR(20),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurant(restaurant_id)
);


-- ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurant(restaurant_id)
);


-- ORDER DETAILS TABLE
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (food_id)
        REFERENCES food_item(food_id)
);


-- PAYMENT TABLE
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    UNIQUE (order_id)
);


-- SHOW TABLES
SHOW TABLES;


-- INSERT CUSTOMERS
INSERT INTO CUSTOMER
(Customer_ID, Name, Email, Phone_Number, Address)
VALUES
(1, 'Sairam', 'sairam@gmail.com', '9876543210', 'Hyderabad'),
(2, 'Brunda', 'brunda@gmail.com', '9876543211', 'Vijayawada'),
(3, 'Bhavya Sree', 'bhavyasree@gmail.com', '9876543212', 'Guntur'),
(4, 'Lasya', 'lasya@gmail.com', '9876543213', 'Warangal'),
(5, 'Manogna', 'manogna@gmail.com', '9876543214', 'Nellore');


-- INSERT RESTAURANTS
INSERT INTO RESTAURANT
(Restaurant_ID, Restaurant_Name, Location, Phone_Number)
VALUES
(1, 'Spice Hub', 'Hyderabad', '9000000001'),
(2, 'Food Palace', 'Vijayawada', '9000000002'),
(3, 'Tasty Treats', 'Guntur', '9000000003'),
(4, 'Biryani House', 'Warangal', '9000000004'),
(5, 'Food Court', 'Nellore', '9000000005');


-- INSERT FOOD ITEMS
INSERT INTO FOOD_ITEM
(Food_ID, Food_Name, Price, Category, Availability, Restaurant_ID)
VALUES
(1, 'Chicken Biryani', 250.00, 'Biryani', 'Available', 1),
(2, 'Veg Biryani', 180.00, 'Biryani', 'Available', 2),
(3, 'Chicken Fried Rice', 220.00, 'Rice', 'Available', 3),
(4, 'Paneer Butter Masala', 200.00, 'Curry', 'Available', 4),
(5, 'Masala Dosa', 80.00, 'Tiffin', 'Available', 5);


-- INSERT ORDERS
INSERT INTO ORDERS
(Order_ID, Order_Date, Total_Amount, Status, Customer_ID, Restaurant_ID)
VALUES
(1, '2026-09-07', 250.00, 'Delivered', 1, 1),
(2, '2026-09-07', 180.00, 'Preparing', 2, 2),
(3, '2026-09-07', 220.00, 'Delivered', 3, 3),
(4, '2026-09-07', 200.00, 'Pending', 4, 4),
(5, '2026-09-07', 80.00, 'Confirmed', 5, 5);


-- UPDATE ORDERS
UPDATE ORDERS
SET Order_Date = '2026-09-07';


-- INSERT ORDER DETAILS
INSERT INTO ORDER_DETAILS
(Order_Details_ID, Quantity, Price, Order_ID, Food_ID)
VALUES
(1, 1, 250.00, 1, 1),
(2, 2, 180.00, 2, 2),
(3, 1, 220.00, 3, 3),
(4, 1, 200.00, 4, 4),
(5, 2, 80.00, 5, 5);


-- INSERT PAYMENTS
INSERT INTO PAYMENT
(Payment_ID, Payment_Date, Amount, Payment_Method, Payment_Status, Order_ID)
VALUES
(1, '2026-09-07', 250.00, 'UPI', 'Paid', 1),
(2, '2026-09-07', 360.00, 'Cash', 'Paid', 2),
(3, '2026-09-07', 220.00, 'UPI', 'Paid', 3),
(4, '2026-09-07', 200.00, 'Card', 'Pending', 4),
(5, '2026-09-07', 160.00, 'UPI', 'Paid', 5);


-- CRUD OPERATIONS

-- READ
SELECT * FROM CUSTOMER;

-- UPDATE
UPDATE CUSTOMER
SET Address = 'Secunderabad'
WHERE Customer_ID = 1;

-- CREATE
INSERT INTO CUSTOMER
(Customer_ID, Name, Email, Phone_Number, Address)
VALUES
(6, 'Test User', 'test@gmail.com', '9000000000', 'Hyderabad');

-- DELETE
DELETE FROM CUSTOMER
WHERE Customer_ID = 6;


-- JOIN 1: CUSTOMER AND ORDERS
SELECT
    CUSTOMER.Name,
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    ORDERS.Total_Amount,
    ORDERS.Status
FROM CUSTOMER
INNER JOIN ORDERS
ON CUSTOMER.Customer_ID = ORDERS.Customer_ID;


-- JOIN 2: RESTAURANT AND FOOD ITEM
SELECT
    RESTAURANT.Restaurant_Name,
    FOOD_ITEM.Food_Name,
    FOOD_ITEM.Price,
    FOOD_ITEM.Category,
    FOOD_ITEM.Availability
FROM RESTAURANT
INNER JOIN FOOD_ITEM
ON RESTAURANT.Restaurant_ID = FOOD_ITEM.Restaurant_ID;


-- JOIN 3: ORDERS, ORDER DETAILS AND FOOD ITEM
SELECT
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    FOOD_ITEM.Food_Name,
    ORDER_DETAILS.Quantity,
    ORDER_DETAILS.Price
FROM ORDERS
INNER JOIN ORDER_DETAILS
ON ORDERS.Order_ID = ORDER_DETAILS.Order_ID
INNER JOIN FOOD_ITEM
ON ORDER_DETAILS.Food_ID = FOOD_ITEM.Food_ID;


-- JOIN 4: ORDERS AND PAYMENT
SELECT
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    ORDERS.Total_Amount,
    ORDERS.Status,
    PAYMENT.Payment_Method,
    PAYMENT.Payment_Status
FROM ORDERS
INNER JOIN PAYMENT
ON ORDERS.Order_ID = PAYMENT.Order_ID;


-- SUBQUERY 1: MAXIMUM ORDER
SELECT *
FROM ORDERS
WHERE Total_Amount = (
    SELECT MAX(Total_Amount)
    FROM ORDERS
);


-- SUBQUERY 2: ABOVE AVERAGE ORDER
SELECT *
FROM ORDERS
WHERE Total_Amount > (
    SELECT AVG(Total_Amount)
    FROM ORDERS
);


-- SUBQUERY 3: CUSTOMERS WHO PLACED ORDERS
SELECT *
FROM CUSTOMER
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM ORDERS
);


-- VIEW
CREATE VIEW Customer_Order_View AS
SELECT
    CUSTOMER.Name,
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    ORDERS.Total_Amount,
    ORDERS.Status
FROM CUSTOMER
JOIN ORDERS
ON CUSTOMER.Customer_ID = ORDERS.Customer_ID;


-- DISPLAY VIEW
SELECT * FROM Customer_Order_View;


-- STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetAllOrders()
BEGIN
    SELECT *
    FROM ORDERS;
END //

DELIMITER ;


-- CALL STORED PROCEDURE
CALL GetAllOrders();