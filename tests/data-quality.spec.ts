import { test, expect } from '@playwright/test';
import { pool, query } from './db';

test.afterAll(async () => {
  await pool.end();
});

test.describe('shop data quality', () => {
  test('tables are not empty', async () => {
    for (const table of ['customers', 'products', 'orders', 'order_items']) {
      const rows = await query(`SELECT COUNT(*)::int AS n FROM ${table}`);
      expect(rows[0].n, `${table} should have rows`).toBeGreaterThan(0);
    }
  });

  test('customer emails are unique, ignoring case and spaces', async () => {
    const rows = await query(
      `SELECT LOWER(TRIM(email)) AS email, COUNT(*)::int AS n
       FROM customers GROUP BY LOWER(TRIM(email)) HAVING COUNT(*) > 1`
    );
    expect(rows, 'duplicate emails').toEqual([]);
  });

  test('customers have a usable email', async () => {
    const rows = await query(
      `SELECT id, email FROM customers
       WHERE email IS NULL OR TRIM(email) = '' OR email NOT LIKE '%@%'`
    );
    expect(rows, 'customers with a missing or malformed email').toEqual([]);
  });

  test('every order belongs to an existing customer', async () => {
    const rows = await query(
      `SELECT o.id, o.customer_id FROM orders o
       LEFT JOIN customers c ON c.id = o.customer_id WHERE c.id IS NULL`
    );
    expect(rows, 'orders with no matching customer').toEqual([]);
  });

  test('every order item belongs to an existing order', async () => {
    const rows = await query(
      `SELECT i.id, i.order_id FROM order_items i
       LEFT JOIN orders o ON o.id = i.order_id WHERE o.id IS NULL`
    );
    expect(rows, 'order items with no matching order').toEqual([]);
  });

  test('every order item points to an existing product', async () => {
    const rows = await query(
      `SELECT i.id, i.product_id FROM order_items i
       LEFT JOIN products p ON p.id = i.product_id WHERE p.id IS NULL`
    );
    expect(rows, 'order items with no matching product').toEqual([]);
  });

  test('every order has at least one item', async () => {
    const rows = await query(
      `SELECT o.id FROM orders o
       LEFT JOIN order_items i ON i.order_id = o.id WHERE i.id IS NULL`
    );
    expect(rows, 'orders with no items').toEqual([]);
  });

  test('order totals equal the sum of their items', async () => {
    const rows = await query(
      `SELECT o.id, o.total, SUM(i.quantity * i.unit_price) AS items_total
       FROM orders o JOIN order_items i ON i.order_id = o.id
       GROUP BY o.id, o.total
       HAVING o.total <> SUM(i.quantity * i.unit_price)`
    );
    expect(rows, 'orders whose total does not match their items').toEqual([]);
  });

  test('product prices are positive', async () => {
    const rows = await query(
      `SELECT id, price FROM products WHERE price IS NULL OR price <= 0`
    );
    expect(rows, 'products with a missing or non-positive price').toEqual([]);
  });

  test('item quantities are positive', async () => {
    const rows = await query(
      `SELECT id, quantity FROM order_items WHERE quantity IS NULL OR quantity <= 0`
    );
    expect(rows, 'items with a missing or non-positive quantity').toEqual([]);
  });

  test('order statuses are valid', async () => {
    const rows = await query(
      `SELECT id, status FROM orders
       WHERE status IS NULL
          OR status NOT IN ('pending', 'shipped', 'completed', 'cancelled')`
    );
    expect(rows, 'orders with an invalid status').toEqual([]);
  });
});