-- Deliberately bad data. Each block should break exactly one check.

-- 1. duplicate email (different case, trailing space)
INSERT INTO customers VALUES (6, 'AMINA.KHAN@example.com ', 'Amina K', 'US', '2026-03-30');

-- 2. malformed email
INSERT INTO customers VALUES (7, 'not-an-email', 'Bad Email', 'US', '2026-03-30');

-- 3. order whose customer does not exist
INSERT INTO orders VALUES (7, 99, '2026-03-28', 'pending', 10.00);
INSERT INTO order_items VALUES (10, 7, 1, 1, 10.00);

-- 4. item whose order does not exist
INSERT INTO order_items VALUES (11, 999, 1, 1, 5.00);

-- 5. item whose product does not exist
INSERT INTO orders VALUES (8, 1, '2026-03-29', 'pending', 5.00);
INSERT INTO order_items VALUES (12, 8, 888, 1, 5.00);

-- 6. order with no items
INSERT INTO orders VALUES (9, 2, '2026-03-29', 'pending', 12.00);

-- 7. order total that does not match its items
INSERT INTO orders VALUES (10, 3, '2026-03-29', 'completed', 50.00);
INSERT INTO order_items VALUES (13, 10, 2, 1, 9.99);

-- 8. negative product price
INSERT INTO products VALUES (6, 'Bad Product', -5.00, 'Office');

-- 9. zero quantity (zero adds nothing to the order total)
INSERT INTO order_items VALUES (14, 8, 1, 0, 5.00);

-- 10. invalid order status
INSERT INTO orders VALUES (11, 4, '2026-03-30', 'refunded', 7.00);
INSERT INTO order_items VALUES (15, 11, 2, 1, 7.00);