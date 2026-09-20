# Data — Sample Superstore (Cleaned)

## Overview
`Sample_Superstore_clean.csv` is the source dataset for this analysis: US retail order-line data. Its column layout structurally matches the widely used public **"Sample Superstore"** dataset (commonly distributed via Tableau / Kaggle for SQL and BI portfolio projects).

## Grain
One row = **one product line within one order**, not one row per order. An order containing 3 different products produces 3 rows that share the same `Order ID`.

## Scale (verified by SQL profiling — see `/sql/superstore.sql`, query 1)
| Metric | Value |
|---|---|
| Order lines (rows) | 9,994 |
| Distinct orders (`Order ID`) | 5,009 |
| Distinct customers | 793 |
| Distinct products | 1,862 |
| Order date range | 2014-01-03 → 2017-12-30 |
| Missing values | 0 across all 21 columns |
| Duplicate (`Order ID` + `Product ID`) pairs | 8, each appearing exactly twice — only 1 of the 8 is a fully identical duplicate row |

## Columns
| Column | Type | Description |
|---|---|---|
| `Row ID` | INT | Row surrogate key |
| `Order ID` | STRING | Order identifier, shared across all lines of one order |
| `Order Date` | STRING (`M/D/YYYY`) | Date the order was placed — stored as text, cast before date arithmetic |
| `Ship Date` | STRING (`M/D/YYYY`) | Date the order was shipped — stored as text |
| `Ship Mode` | STRING | `Same Day`, `First Class`, `Second Class`, `Standard Class` |
| `Customer ID` | STRING | Customer identifier |
| `Customer Name` | STRING | Customer full name |
| `Segment` | STRING | `Consumer`, `Corporate`, `Home Office` |
| `Country` | STRING | United States only (single value across all rows) |
| `City` | STRING | Delivery city |
| `State` | STRING | Delivery state |
| `Postal Code` | INT | Delivery ZIP code |
| `Region` | STRING | `Central`, `East`, `South`, `West` |
| `Product ID` | STRING | Product identifier |
| `Category` | STRING | `Furniture`, `Office Supplies`, `Technology` |
| `Sub-Category` | STRING | 17 sub-categories nested under the 3 categories |
| `Product Name` | STRING | Product description |
| `Sales` | FLOAT | Line revenue (USD) |
| `Quantity` | INT | Units sold on the line |
| `Discount` | FLOAT | Discount rate applied, 0–1 |
| `Profit` | FLOAT | Line profit (USD) — can be negative |

## Known data-quality notes
- `Order Date` / `Ship Date` are text, not a native date type. In the Oracle queries in this repo they are cast explicitly with `TO_DATE(col, 'MM,DD,YYYY')` before any date arithmetic, min/max, or `EXTRACT()`.
- No NULLs in any of the 21 columns (confirmed by an explicit per-column `COUNT(*) - COUNT(col)` check).
- 8 `(Order ID, Product ID)` pairs repeat exactly twice; the rest of those repeats differ in quantity/discount and represent legitimate repeat purchases within the same order rather than data errors.

## Load instructions
Standard header-row CSV, UTF-8, comma-delimited, quoted fields for values that contain commas (e.g. some `Product Name` values). To run the SQL in `/sql` unmodified, load it into a table named `SUPERSTORE` (uppercase) with matching uppercase column names.

