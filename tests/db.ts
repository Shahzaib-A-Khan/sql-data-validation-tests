import { Pool } from 'pg';

export const pool = new Pool({
  host: process.env.DB_HOST || '127.0.0.1',
  port: Number(process.env.DB_PORT || 5432),
  user: process.env.DB_USER || 'qa',
  password: process.env.DB_PASSWORD || 'qa_password',
  database: process.env.DB_NAME || 'shop',
});

export async function query<T = any>(sql: string, params: unknown[] = []): Promise<T[]> {
  const result = await pool.query(sql, params);
  return result.rows;
}