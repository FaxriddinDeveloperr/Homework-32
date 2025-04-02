-- Ma'lumotlar bazasini yaratish
CREATE DATABASE phone;

-- Phones jadvali
CREATE TABLE Phones (
    phone_id SERIAL PRIMARY KEY,
    model VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    storage INT NOT NULL
);

-- Customers jadvali
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Employees jadvali
CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL
);

-- Sales jadvali
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    phone_id INT REFERENCES Phones(phone_id) ON DELETE CASCADE,
    customer_id INT REFERENCES Customers(customer_id) ON DELETE CASCADE,
    employee_id INT REFERENCES Employees(employee_id) ON DELETE SET NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    total_price FLOAT NOT NULL
);

-- Phones jadvaliga ma'lumot qo'shish
INSERT INTO Phones (model, price, manufacturer, storage) VALUES
('iPhone 14', 999.99, 'Apple', 128),
('Samsung Galaxy S23', 849.99, 'Samsung', 256),
('Google Pixel 7', 599.99, 'Google', 128),
('Xiaomi Mi 13', 499.99, 'Xiaomi', 256),
('OnePlus 11', 699.99, 'OnePlus', 256);

-- Customers jadvaliga ma'lumot qo'shish
INSERT INTO Customers (first_name, last_name, phone) VALUES
('Ali', 'Valiyev', '+998901234567'),
('Olim', 'Karimov', '+998909876543'),
('Sarvar', 'Narzullayev', '+998931112233'),
('Shahnoza', 'Ismoilova', '+998935556677'),
('Diyor', 'Rahmonov', '+998977778899');

-- Employees jadvaliga ma'lumot qo'shish
INSERT INTO Employees (first_name, last_name, position) VALUES
('Javlon', 'Turgunov', 'Sales Manager'),
('Madina', 'Abdullayeva', 'Cashier'),
('Bekzod', 'Sharipov', 'Sales Representative'),
('Kamola', 'Saidova', 'Store Manager'),
('Rustam', 'Gulomov', 'Technician');

-- Sales jadvaliga ma'lumot qo'shish
INSERT INTO Sales (phone_id, customer_id, employee_id, quantity, total_price) VALUES
(1, 1, 1, 1, 999.99),
(2, 2, 2, 2, 1699.98),
(3, 3, 3, 1, 599.99),
(4, 4, 4, 1, 499.99),
(5, 5, NULL, 1, 699.99); -- NULL, chunki ON DELETE SET NULL bor

-- 1. Har bir ishlab chiqaruvchi bo‘yicha o‘rtacha narxni hisoblash
SELECT manufacturer, AVG(price) FROM Phones GROUP BY manufacturer;

-- 2. Har bir mijoz nechta telefon sotib olgani va qancha miqdorda olganini hisoblash
SELECT 
    c.first_name,
    c.last_name,
    COUNT(s.sale_id) as total_phones_bought,
    SUM(s.quantity) as total_quantity
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;

-- 3. Eng ko‘p savdo qilgan xodimni aniqlash
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    COUNT(s.sale_id) as total_sales,
    SUM(s.quantity) as total_items_sold,
    SUM(s.total_price) as total_revenue
FROM Employees e
JOIN Sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.position
ORDER BY total_sales DESC, total_items_sold DESC
LIMIT 1;

-- 4. Narxi bo‘yicha tartiblangan holda, 4-o‘rindan boshlab 6 ta telefonni olish
SELECT 
    phone_id,
    model,
    manufacturer,
    storage,
    price
FROM Phones
ORDER BY price DESC
OFFSET 4 LIMIT 6;

-- 5. Har bir ishlab chiqaruvchining o‘rtacha, minimal va maksimal narxlari
SELECT 
    manufacturer,
    AVG(price) as average_price,
    MIN(price) as min_price,
    MAX(price) as max_price,
    (SELECT model FROM Phones p2 WHERE p2.manufacturer = p1.manufacturer ORDER BY price ASC LIMIT 1) as cheapest_model,
    (SELECT model FROM Phones p3 WHERE p3.manufacturer = p1.manufacturer ORDER BY price DESC LIMIT 1) as most_expensive_model
FROM Phones p1
GROUP BY manufacturer
ORDER BY average_price DESC;

-- 6. Har bir ishlab chiqaruvchining eng katta xotiraga ega telefoni
SELECT 
    p1.manufacturer,
    p1.model,
    p1.storage
FROM Phones p1
JOIN (
    SELECT manufacturer, MAX(storage) as max_storage
    FROM Phones
    GROUP BY manufacturer
) p2 ON p1.manufacturer = p2.manufacturer AND p1.storage = p2.max_storage
ORDER BY p1.storage DESC;

-- 7. Eng ko‘p sotilgan telefonlar ro‘yxati
SELECT 
    p.model,
    p.manufacturer,
    p.price,
    COUNT(s.sale_id) as total_sales,
    SUM(s.quantity) as total_quantity
FROM Phones p
JOIN Sales s ON p.phone_id = s.phone_id
GROUP BY p.phone_id, p.model, p.manufacturer, p.price
ORDER BY total_quantity DESC, total_sales DESC;