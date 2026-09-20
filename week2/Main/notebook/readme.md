# Notebook — SQL + Python Analysis (`sql.ipynb`)

## Overview
Jupyter notebook (Python 3) that executes every query from `/sql/superstore.sql` against a live Oracle database via SQLAlchemy, loads the results into pandas, builds 3 charts with matplotlib, and documents written, evidence-based business insight for each finding.

## Stack
- `sqlalchemy` + `oracledb` — database connection and query execution (`pd.read_sql`)
- `pandas` — result handling
- `matplotlib` — visualization

## Structure
| Section | Cells | Content |
|---|---|---|
| Libraries | 1–3 | Imports, engine creation, connectivity check (`SELECT COUNT(*)`) |
| 10 questions | 5–15 | Profiling, data-quality checks, Q4–Q10, and the final yearly summary — each query executed with its resulting `DataFrame` displayed |
| Visualisation | 17–21 | 3 matplotlib charts built from the Q6, Q7 and Q8 results |
| Insights | 22–30 | Written interpretation per question, each explicitly flagging correlation vs. causation |
| Final conclusion | 31–33 | Consolidated summary and 4 recommendations |

## ⚠️ Before publishing this notebook
The DB connection cell hardcodes credentials:
```
oracle+oracledb://Devlab:mypassword@localhost:1521/?service_name=XEPDB1
```
Replace this with environment variables (e.g. `os.environ["DB_USER"]`, a `.env` file loaded via `python-dotenv`) before pushing to a public GitHub repo. Even if this is a throwaway local/dev password, hardcoded DB credentials in a public notebook is a bad practice a reviewer will flag regardless of whether the value itself is sensitive.

## Charts produced (saved to `/charts`)
| File | Source query | What it shows |
|---|---|---|
| `01_profit_by_subcategory.png` | Q6 base data | Horizontal bar chart, all 17 sub-categories by total profit, loss-making bars in red |
| `02_avg_profit_by_discount_band.png` | Q7 | Bar chart, average profit per discount band (zero / lower / middle / high) |
| `03_total_sales_by_year_yoy.png` | Q8 | Line chart, total sales 2014–2017, with YoY % change annotated at each point |

## Requirements to re-run
```
pandas
sqlalchemy
oracledb
matplotlib
```
Plus a running Oracle instance with `SUPERSTORE` loaded — see `/data/README.md` and `/sql/README.md`.

## Headline findings
Full text is in the notebook's "insights" and "Final conclusion" cells; summarized here:

- **Scope:** 9,994 order lines, 5,009 orders, 793 customers, 2014–2017. Total sales **$2.30M**, total profit **$286.4K**, blended margin **12.5%**.
- **Growth:** sales fell 2.8% in 2015, then grew 29.5% (2016) and 20.4% (2017). Profit grew every year, but margin peaked at 13.4% in 2016 and eased to 12.7% in 2017 — profit growth (14.2%) lagged sales growth (20.4%) that year.
- **Discounting:** lines above 20% discount (13.9% of order lines, 15.8% of sales) lose **-$135.4K** combined; 0%-discount lines earn **+$321.0K**. Average profit per line falls from +$66.9 (no discount) to -$106.7 (41%+ discount).
- **Loss-making sub-categories:** Tables, Bookcases and Supplies lose **-$22.4K** combined on 16.0% of revenue. Tables alone is 79% of that loss and is discount-driven: +18.5% margin at 0% discount vs. -$30.7K above 20% discount. Bookcases follows the same pattern. Supplies shows no discounts above 20% at all — its loss points to pricing or unit cost, not discounting.
- **Customer concentration:** the top 10 customers generate 17.5% of total profit at a 41% margin, but the top 3's profit is 81–98% concentrated in a single order each — "lifetime profit" here rewards one-off large purchases over loyalty. 155 customers (19.5%) are net-unprofitable, -$71.2K combined.

Every discount→profit and profit→margin relationship above is explicitly flagged in the notebook as correlational, not causal — no controlled experiment isolates discounting as the cause of the profit differences.

