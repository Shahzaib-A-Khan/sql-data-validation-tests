# SQL Data Validation Tests

![Data Quality Checks](https://github.com/Shahzaib-A-Khan/sql-data-validation-tests/actions/workflows/data-quality.yml/badge.svg)

SQL data quality checks for a sample shop database (Postgres in Docker), run with Playwright's test runner locally and in GitHub Actions.

## What it checks
- Tables are not empty
- Customer emails are unique (ignoring case and spaces) and well formed
- Every order belongs to an existing customer
- Every order item belongs to an existing order and product
- Every order has at least one item
- Each order total equals the sum of its items
- Product prices and item quantities are positive
- Order statuses are valid

## How each check works
Each test runs a SQL query that returns the rows that break a rule, then asserts the list is empty. A failure prints the bad rows.

## Proving the checks can fail
`db/dirty/dirty-data.sql` injects 10 deliberate defects, one per check. A second CI job loads that bad data and passes only when exactly 10 checks fail and 1 passes (the "tables are not empty" check). If a check stops catching its defect, or the database simply breaks, the pipeline turns red.

## Run it locally
docker compose up -d --wait
npm ci
npx playwright test

To try the bad data, load `db/dirty/dirty-data.sql` with `docker compose exec`, run the tests and watch them fail, then use `db/dirty/reset.sql` to clean up.

## Notes
- The tables intentionally have no foreign keys or unique constraints, like data loaded from imports, so the checks do the work those rules would do.
- The credentials in `docker-compose.yml` are throwaway values for a local container.
- CI runs on pushes, pull requests and nightly at 06:00 UTC.

## Project structure
- `docker-compose.yml`: Postgres container with a health check
- `db/init/`: schema and seed data
- `db/dirty/`: bad-data and cleanup scripts
- `tests/`: the connection helper and the data quality checks
- `.github/workflows/data-quality.yml`: CI workflow