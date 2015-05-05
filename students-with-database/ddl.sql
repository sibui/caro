CREATE TABLE students (
    id          SERIAL PRIMARY KEY,
    pid         INTEGER,
    first_name  TEXT,
    middle_name TEXT,
    last_name   TEXT
);

INSERT INTO students (pid, first_name, middle_name, last_name) values (77777777, 'Mary', '', 'Doe');
INSERT INTO students (pid, first_name, middle_name, last_name) values (88888888, 'John', 'T', 'Smith');
INSERT INTO students (pid, first_name, middle_name, last_name) values (11111111, 'S', 'B', 'B');


CREATE TABLE users (
id SERIAL PRIMARY KEY,
state TEXT NOT NULL CHECK (char_length(state) > 0), 
role TEXT NOT NULL CHECK (char_length(role) > 0), 
age TEXT NOT NULL CHECK (char_length(age) > 0), 
name TEXT UNIQUE NOT NULL CHECK (char_length(name) > 0)
);

INSERT INTO users (state, role, age, name) values ('CA', 'owner', '99', 'simon');

CREATE TABLE categories (
id SERIAL PRIMARY KEY,
description TEXT NOT NULL CHECK (char_length(description) > 0),
name TEXT UNIQUE NOT NULL CHECK (char_length(name) > 0),
numProducts INTEGER
);

INSERT INTO categories(description, name, numProducts) values ('This is my test description','test',0);

CREATE TABLE products (
name TEXT NOT NULL CHECK (char_length(name) > 0),
sku TEXT UNIQUE NOT NULL CHECK (char_length(sku) > 0),
category TEXT NOT NULL CHECK (char_length(category) > 0),
price INTEGER
);

INSERT INTO products(name, sku, category, price) values ('testname', 'test008', 'tacos', 0);

CREATE TABLE carts (
owner TEXT NOT NULL CHECK (char_length(owner) > 0) references users(name),
sku TEXT NOT NULL CHECK (char_length(sku) > 0) references products(sku),
quantity INTEGER,
price INTEGER
);

INSERT INTO carts(owner, sku, quantity, price) values ('simon', 'test008', '1', 0);