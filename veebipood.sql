CREATE DATABASE veebipoodGrossholm;
USE veebipoodGrossholm;

--table Categories
CREATE TABLE categories(
category_id int PRIMARY KEY identity(1,1),
category_name varchar(30) UNIQUE);

INSERT INTO categories(category_name)
VALUES ('T-särk'),('mantel'),('pusa'),('pintsak');
SELECT * FROM categories;

--tabel products
CREATE TABLE products(
product_id int PRIMARY KEY identity(1,1),
product_name varchar(50) NOT NULL,
brand_id int,
category_id int,
FOREIGN KEY (category_id) references categories(category_id),
model_year int, 
list_price decimal(3,2));

INSERT INTO products(product_name, brand_id, category_id, model_year, list_price)
VALUES ('Gucci T-Särk', 1, 1, '2024', '400'),
('YSL Pusa', 3, 3, '2020', '799.99');

select * from products

DELETE FROM products Where product_id=2;

--tabel brands
CREATE TABLE brands(
brand_id int PRIMARY KEY identity(1,1),
brand_name varchar(30) unique);

INSERT INTO brands(brand_name)
VALUES ('Gucci'), ('YSL');

select * from brands

ALTER TABLE products ADD CONSTRAINT fk_brand
FOREIGN KEY (brand_id) references brands(brand_id);

--table stocks -- kaks primary key
CREATE TABLE stocks(
store_id int,
product_id int,
quantity int,
PRIMARY KEY (store_id, product_id),
FOREIGN KEY (product_id) references products(product_id));

select * from stocks

--table customers
CREATE TABLE customers(
customer_id int PRIMARY KEY identity(1,1),
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
phone char(15),
email varchar(50) UNIQUE,
steet varchar(50),
city varchar(50),
state_ varchar(50),
zip_code char(5));

--table stores
CREATE TABLE stores(
store_id int PRIMARY KEY identity(1,1),
store_name varchar(30),
phone varchar(15),
email varchar(50),
street varchar(50),
city varchar (50),
state_ varchar(50),
zip_code char(5));

--table staffs
CREATE TABLE staffs(
staff_id int PRIMARY KEY identity(1,1),
first_name varchar(30),
last_name varchar(30),
email varchar(30),
phone char(15),
active varchar(30),
store_id int,
FOREIGN KEY (store_id) REFERENCES stores(store_id),
manager_id int);

select * from stores

--table orders
CREATE TABLE orders(
order_id int PRIMARY KEY identity(1,1),
customer_id int,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
order_status varchar(30) check(order_status='töötlemisel' or order_status='valmis' or order_status='makstud'),
order_date date,
required_date date,
shipped_date date,
store_id int,
FOREIGN KEY (store_id) REFERENCES stores(store_id),
staff_id int,
FOREIGN KEY (staff_id) REFERENCES staffs(staff_id));

select * from orders

--table order_items
CREATE TABLE order_items(
order_id int,
item_id int,
PRIMARY KEY (order_id, item_id),
product_id int,
FOREIGN KEY (product_id) REFERENCES products(product_id),
quantity int,
list_price decimal(7,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
discount int);

ALTER TABLE stocks ADD CONSTRAINT fk_store
FOREIGN KEY (store_id) references stores(store_id);

select * from order_items
