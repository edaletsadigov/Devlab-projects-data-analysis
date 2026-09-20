# Superstore Sales & Profitability Analysis (SQL + Python)

End-to-end analysis of the Sample Superstore dataset — 9,994 US retail order lines, 2014–2017. Data profiling and quality checks plus 10 business questions in Oracle SQL, with a Python/pandas/matplotlib layer for visualization and written, evidence-based insight.

## Repository structure
```
superstore-sql-analysis/
├── data/
│   ├── Sample_Superstore_clean.csv
│   └── README.md
├── sql/
│   ├── superstore.sql
│   └── README.md
├── notebook/
│   ├── sql.ipynb
│   └── README.md
├── charts/
│   ├── 01_profit_by_subcategory.png
│   ├── 02_avg_profit_by_discount_band.png
│   └── 03_total_sales_by_year_yoy.png
└── README.md
```

## What's in each folder
- **`data/`** — the source CSV and its data dictionary.
- **`sql/`** — all raw SQL (Oracle dialect): profiling, data-quality checks, and 10 numbered business questions.
- **`notebook/`** — the Jupyter notebook that runs the SQL against a live database, builds the charts, and documents the insights.
- **`charts/`** — the 3 exported PNG visualizations referenced by the notebook.

## Business questions answered
1. Row count, distinct customers/products, order-date range
2. Data quality: NULL check per column, duplicate order-line detection
3. Average days-to-ship per shipping mode
4. Sales, profit and margin by Region × Category × Sub-Category
5. Top 5 / bottom 5 sub-categories by profit
6. Profit across discount bands (0%, 1–20%, 21–40%, 41%+)
7. Year-over-year sales trend, 2014–2017
8. Sub-categories generating a net loss, and their revenue share
9. Top 10 customers by lifetime profit and average order value
10. Consolidated yearly sales / profit / margin summary

## Key findings
- **Scope:** 9,994 order lines / 5,009 orders / 793 customers / 1,862 products, Jan 2014 – Dec 2017. Total sales **$2.30M**, total profit **$286.4K**, blended margin **12.5%**. Data quality: 0 NULLs across 21 columns; 8 repeated `(Order ID, Product ID)` pairs, only 1 a true full duplicate.
- **Growth pattern:** sales dipped 2.8% in 2015, then grew 29.5% (2016) and 20.4% (2017); margin peaked at 13.4% in 2016 and eased to 12.7% in 2017.
- **Discounting:** lines above 20% discount (13.9% of order lines, 15.8% of sales) lose -$135.4K combined, against +$321.0K earned by 0%-discount lines.
- **Structural loss:** Tables, Bookcases and Supplies are net-negative (-$22.4K combined). Tables is discount-driven (+18.5% margin at 0% discount vs. -$30.7K above 20%); Supplies shows no such pattern, pointing to pricing/cost rather than discounting.
- **Customer concentration:** the top 10 customers generate 17.5% of profit at a 41% margin, but the top 3 earned 81–98% of their profit from a single order each. 155 customers (19.5%) are net-unprofitable, -$71.2K combined.

Every discount→profit and profit→margin relationship above is flagged in the notebook as correlational, not causal — no experiment isolates discounting as the cause.

## Recommendations
1. Cap discounts at 20% for Tables and Bookcases; pilot in the East region and measure the volume effect before rolling out further.
2. Review pricing / unit cost for Supplies; keep Machines on a watchlist (8.2% of revenue at only a 1.8% margin).
3. Segment customers into repeat buyers vs. one-off large orders; base retention on recurring profit, not lifetime profit alone.
4. Track yearly margin, not sales growth alone — 2017's margin declined despite sales growing 20.4%.

## Tools
- **SQL:** Oracle Database (XE), queried via `oracledb` / SQLAlchemy
- **Python:** pandas, matplotlib, SQLAlchemy
- **Environment:** Jupyter Notebook

## How to reproduce
1. Load `data/Sample_Superstore_clean.csv` into a table named `SUPERSTORE` in an Oracle instance.
2. Run `sql/superstore.sql` directly, or open `notebook/sql.ipynb` — update the DB connection string first (see the security note in `notebook/README.md`).

## Author
Adalat Sadigov — Data Analytics, Baku, Azerbaijan.

