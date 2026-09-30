# E-Commerce Sales Analytics Database

A normalized PostgreSQL database for an e-commerce business with analytical
SQL queries covering revenue trends, customer segmentation, and query
performance optimization.

## Tech
PostgreSQL

## Structure
- `schema.sql` — table definitions (8 tables, 3NF, with PK/FK constraints)
- `seed_data.sql` — sample data for testing
- `basic_queries.sql` — joins & aggregations (revenue, top products, AOV)
- `window_functions.sql` — running totals, MoM growth, ranking, moving averages
- `rfm_segmentation.sql` — CTE-based RFM (Recency, Frequency, Monetary) customer segmentation
- `optimization.sql` — indexing + EXPLAIN ANALYZE before/after

## Highlights
- Monthly revenue trend and month-over-month growth using window functions
- RFM customer segmentation (Champion / Loyal / At Risk / Lost) via CTEs and NTILE
- Top-selling products and revenue-by-category breakdowns
- Query performance improved via indexing on foreign keys and filter columns

## How to run
1. Create a PostgreSQL database (e.g. via [Supabase](https://supabase.com) free tier)
2. Run `schema.sql` to create the tables
3. Run `seed_data.sql` to populate sample data
4. Run any of the query files to see the analysis

## Author
[Nitin Raj] — [www.linkedin.com/in/nitin-raj14]
