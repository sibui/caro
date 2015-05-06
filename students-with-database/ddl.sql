CREATE TABLE users (
state TEXT NOT NULL CHECK (char_length(state) > 0), 
role TEXT NOT NULL CHECK (char_length(role) > 0), 
age TEXT NOT NULL CHECK (char_length(age) > 0), 
name TEXT UNIQUE NOT NULL CHECK (char_length(name) > 0)
);

INSERT INTO users (state, role, age, name) values ('CA', 'owner', '99', 'simon');

CREATE TABLE categories (
id SERIAL PRIMARY KEY,
description TEXT,
name TEXT UNIQUE NOT NULL CHECK (char_length(name) > 0)
);

INSERT INTO categories(description, name, numProducts) values ('This is my test description','test',0);

CREATE TABLE products (
name TEXT NOT NULL CHECK (char_length(name) > 0),
sku TEXT UNIQUE NOT NULL CHECK (char_length(sku) > 0),
category INTEGER NOT NULL CHECK (category > 0) references categories(id),
price INTEGER CHECK (price > 0)
);

INSERT INTO products(name, sku, category, price) values ('testname', 'test008', 1, 5);

CREATE TABLE carts (
owner TEXT NOT NULL CHECK (char_length(owner) > 0) references users(name),
sku TEXT NOT NULL CHECK (char_length(sku) > 0) references products(sku),
quantity INTEGER,
price INTEGER
);

INSERT INTO carts(owner, sku, quantity, price) values ('simon', 'test008', 1, 5);

CREATE TABLE purchases (
ts timestamp,
customer TEXT NOT NULL CHECK (char_length(customer) > 0),
sku TEXT NOT NULL CHECK (char_length(sku) > 0),
price INTEGER,
quantity INTEGER
);

INSERT INTO purchases(ts, customer, sku, price, quantity) values (CURRENT_TIMESTAMP, 'simon','test008', 1, 5);