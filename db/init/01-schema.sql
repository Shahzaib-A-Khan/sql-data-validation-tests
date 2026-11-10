CREATE TABLE customers (
  id INT PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  country TEXT,
  created_at DATE
);

CREATE TABLE products (
  id INT PRIMARY KEY,
  name TEXT,
  price NUMERIC(10,2),
  category TEXT
);

CREATE TABLE orders (
  id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  status TEXT,
  total NUMERIC(10,2)
);

CREATE TABLE order_items (
  id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price NUMERIC(10,2)
);