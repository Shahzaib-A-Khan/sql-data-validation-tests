INSERT INTO customers VALUES
  (1, 'amina.khan@example.com', 'Amina Khan', 'US', '2026-01-05'),
  (2, 'liam.smith@example.com', 'Liam Smith', 'UK', '2026-01-12'),
  (3, 'sara.ali@example.com', 'Sara Ali', 'US', '2026-02-03'),
  (4, 'noah.brown@example.com', 'Noah Brown', 'CA', '2026-02-20'),
  (5, 'zoe.lee@example.com', 'Zoe Lee', 'US', '2026-03-08');

INSERT INTO products VALUES
  (1, 'Wireless Mouse', 24.99, 'Accessories'),
  (2, 'USB-C Cable', 9.99, 'Accessories'),
  (3, 'Laptop Stand', 39.50, 'Office'),
  (4, 'Mechanical Keyboard', 89.00, 'Accessories'),
  (5, 'Desk Lamp', 29.90, 'Office');

INSERT INTO orders VALUES
  (1, 1, '2026-03-01', 'completed', 59.97),
  (2, 2, '2026-03-03', 'completed', 39.50),
  (3, 3, '2026-03-10', 'shipped', 118.97),
  (4, 1, '2026-03-15', 'completed', 59.80),
  (5, 4, '2026-03-20', 'cancelled', 24.99),
  (6, 5, '2026-03-25', 'pending', 108.90);

INSERT INTO order_items VALUES
  (1, 1, 1, 2, 24.99),
  (2, 1, 2, 1, 9.99),
  (3, 2, 3, 1, 39.50),
  (4, 3, 4, 1, 89.00),
  (5, 3, 2, 3, 9.99),
  (6, 4, 5, 2, 29.90),
  (7, 5, 1, 1, 24.99),
  (8, 6, 3, 2, 39.50),
  (9, 6, 5, 1, 29.90);