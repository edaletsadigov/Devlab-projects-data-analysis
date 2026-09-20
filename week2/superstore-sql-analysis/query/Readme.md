# SQL — Superstore Analysis Queries

## Overview
`superstore.sql` contains every query used in this project: table profiling, data-quality checks, 10 numbered business questions, and a final summary query. All queries run against a single table, `SUPERSTORE`, with the columns documented in `/data/README.md`.

## Dialect
Written and executed in **Oracle SQL** (Oracle Database XE), called from Python via the `oracledb` driver — see the connection string in `/notebook/sql.ipynb`. The following Oracle-specific syntax is used throughout:
- `TO_DATE(col, 'MM,DD,YYYY')` — explicit date cast, required because `Order Date` / `Ship Date` are stored as text
- `FETCH FIRST n ROWS ONLY` — row limiting (ANSI SQL / Oracle 12c+, not `LIMIT`)
- `EXTRACT(YEAR FROM ...)`
- `RANK() OVER (...)`, `LAG() OVER (...)` — window functions
- `NULLIF(...)` — safe division guard

> **Not MySQL.** To port to MySQL 8.x: replace `TO_DATE(x, 'MM,DD,YYYY')` with `STR_TO_DATE(x, '%m,%d,%Y')`, and `FETCH FIRST n ROWS ONLY` with `LIMIT n`. `RANK()`, `LAG()`, `EXTRACT()` and `NULLIF()` are unchanged in MySQL 8+.

## Query index

| # | Section | Business question |
|---|---|---|
| 1 | Profiling | Row count, distinct customers, distinct products, min/max order date |
| 2 | Profiling | Table structure (`DESCRIBE superstore`) |
| 3 | Data quality | NULL count for every column (all 21 columns) |
| 4 | Data quality | Duplicate order lines — same `Order ID` + `Product ID` appearing more than once |
| Q4 | Business | Average days-to-ship per `Ship Mode` |
| Q5 | Business | Sales, profit and profit margin by Region × Category × Sub-Category |
| Q6 | Business | Top 5 / bottom 5 sub-categories by total profit — two solutions: `UNION ALL` of two ordered subqueries, and `RANK() OVER()` in a CTE |
| Q7 | Business | Discount bands (0%, 1–20%, 21–40%, 41%+) via `CASE WHEN`, with order count, avg profit and total profit per band |
| Q8 | Business | Year-over-year sales change, absolute and %, using `LAG()` |
| Q9 | Business | Sub-categories with negative total profit and their share of total revenue |
| Q10 | Business | Top 10 customers by lifetime profit, order count, and average order value (AOV) |
| Final | Summary | Yearly sales, profit and profit margin (CTE + aggregation) |

## How to run
1. Create a table `SUPERSTORE` and load `/data/Sample_Superstore_clean.csv` into it (uppercase column names, matching the queries).
2. Run against an Oracle instance, or adapt per the dialect note above for MySQL/PostgreSQL.
3. Each block is self-contained — queries reference only `SUPERSTORE` directly, none depend on another query's output, so any block can be run standalone.

## Key results
| Finding | Value |
|---|---|
| Zero-discount lines | 4,798 orders · avg profit **+$66.90** · total **+$320,987.60** |
| 41%+ discount lines | 933 orders · avg profit **-$106.71** · total **-$99,558.59** |
| Top profit sub-category | Copiers, **+$55,617.82** |
| Bottom profit sub-category | Tables, **-$17,725.48** |
| Avg days to ship | Same Day 0.04 → First Class 2.18 → Second Class 3.24 → Standard Class 5.01 |

Full write-up with business interpretation: `/notebook/README.md`.

