CREATE DATABASE veebipoodGrechishkin;
USE veebipoodGrechishkin;

-- tabel Categories
CREATE TABLE categories(
category_id int PRIMARY KEY identity(1,1),
category_name varchar(30) unique);

INSERT INTO categories(category_name)
VALUES ('T-särk'), ('mantel'),('pusa'),('pintsak'),('püksid');
SELECT * FROM categories

--tabel products
CREATE TABLE products(
product_id int PRIMARY KEY identity(1,1),
product_name varchar(50) NOT NULL,
brand_id int,
category_id int,
FOREIGN KEY(category_id) references categories(category_id),
model_year int,
list_price decimal(7,2));

INSERT INTO products
(product_name, brand_id, category_id, model_year, list_price)
VALUES
('Logoga T-särk', 1, 1, 2020, 25.50),
('Mantel', 2, 2, 2023, 249.99),
('Pusa', 3, 3, 2024, 64.99),
('Pintsak', 4, 4, 2022, 99.99),
('Püksid printiga', 5, 5, 2025, 50.25);

SELECT * FROM products;

--tabel brands
CREATE TABLE brands(
brand_id int PRIMARY KEY identity(1,1),
brand_name varchar(30) unique);

ALTER TABLE products ADD CONSTRAINT fk_brand
FOREIGN KEY(brand_id) references brands(brand_id);

INSERT INTO brands (brand_name)
VALUES
('Nike'),
('Adidas'),
('Puma'),
('Zara'),
('H&M');

SELECT * FROM brands;

--tabel stocks -- kaks primary key
CREATE TABLE stocks(
store_id int,
product_id int,
quantity int,
PRIMARY KEY (store_id, product_id),
foreign key (product_id) references products(product_id)
);

ALTER TABLE stocks
ADD CONSTRAINT fk_stocks_store
FOREIGN KEY (store_id) REFERENCES stores(store_id);

INSERT INTO stocks
(store_id, product_id, quantity)
VALUES
(1, 1, 50),
(1, 2, 20),
(1, 3, 30),
(2, 1, 40),
(2, 4, 15);

SELECT * FROM stocks;

--tabel customers
CREATE TABLE customers(
customer_id int PRIMARY KEY identity(1,1),
first_name varchar(30),
last_name varchar(30),
phone varchar(20),
email varchar(50),
street varchar(50),
city varchar(30),
state varchar(30),
zip_code varchar(10)
);

INSERT INTO customers
(first_name, last_name, phone, email, street, city, state, zip_code)
VALUES
('Anna', 'Mantel', '5556666', 'anna@gmail.com', 'Pärnu mnt 20', 'Tallinn', 'Harjumaa', '11312'),
('Karl', 'Mets', '5557777', 'karl@gmail.com', 'Vabaduse 3', 'Tartu', 'Tartumaa', '51005'),
('Liis', 'Mägi', '5558888', 'liis@gmail.com', 'Rae 7', 'Narva', 'Ida-Virumaa', '20308');

SELECT * FROM customers;

--tabel stores
CREATE TABLE stores(
store_id int PRIMARY KEY identity(1,1),
store_name varchar(50),
phone varchar(20),
email varchar(50),
street varchar(50),
city varchar(30),
state varchar(30),
zip_code char(5)
);

INSERT INTO stores
(store_name, phone, email, street, city, state, zip_code)
VALUES
('Tallinna pood', '5551111', 'tln@pood.ee', 'Narva mnt 10', 'Tallinn', 'Harjumaa', '10101'),
('Tartu pood', '5552222', 'trt@pood.ee', 'Riia 5', 'Tartu', 'Tartumaa', '51001');

SELECT * FROM stores;

--tabel staffs
CREATE TABLE staffs(
staff_id int PRIMARY KEY identity(1,1),
first_name varchar(30),
last_name varchar(30),
email varchar(50),
phone varchar(20),
active int,
store_id int,
manager_id int,

FOREIGN KEY (store_id) REFERENCES stores(store_id),
);

INSERT INTO staffs
(first_name, last_name, email, phone, active, store_id, manager_id)
VALUES
('Jeffrey', 'Epstein', 'jeffrey@pood.ee', '5553333', 1, 1, 1),
('Kati', 'Kask', 'kati@pood.ee', '5554444', 1, 1, 1),
('Jaan', 'Sepp', 'jaan@pood.ee', '5555555', 1, 2, 1);

SELECT * FROM staffs;

--tabel orders
CREATE TABLE orders(
order_id int PRIMARY KEY identity(1,1),
customer_id int,
order_status varchar(30) check(order_status='töötlemisel' or order_status = 'valmis' or order_status='makstud'),
order_date date,
required_date date,
shipped_date date,
store_id int,
staff_id int,

FOREIGN KEY (store_id) REFERENCES stores(store_id),
FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);


INSERT INTO orders
(customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
(1, 1, '2025-01-10', '2025-01-15', '2025-01-12', 1, 1),
(2, 2, '2025-01-11', '2025-01-16', '2025-01-18', 2, 3);

SELECT * FROM orders;

--tabel order_items
CREATE TABLE order_items(
order_id int,
item_id int,
product_id int,
quantity int,
list_price decimal(7,2),
discount int,

PRIMARY KEY (order_id, item_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
);

INSERT INTO order_items
(order_id, item_id, product_id, quantity, list_price, discount)
VALUES
(1, 1, 1, 2, 25.50, 0.10),
(1, 2, 3, 1, 64.99, 0.00),
(2, 1, 2, 1, 249.99, 0.15);

SELECT * FROM order_items;

