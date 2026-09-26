# Notebook — SQL + Python Analysis (`sql.ipynb`)

## Overview
Jupyter notebook (Python 3) that runs 11 SQL queries — **Q1 through Q10 plus a final yearly summary**, all written **inline as Python string variables** (`q1_sql` … `q10_sql`, `final_sql`) — against a live Oracle database via SQLAlchemy + `oracledb`, loads each result into pandas, and builds 3 matplotlib charts. Written, evidence-based business insight is documented for **Q7–Q10**, each explicitly flagging correlation vs. causation.

## Stack
- `sqlalchemy` + `oracledb` — database connection and query execution (`pd.read_sql`)
- `pandas` — result handling
- `matplotlib` — visualization
- `getpass` — interactive password prompt (password is never written into the notebook)

## Structure
| Section | Cells | Content |
|---|---|---|
| Libraries | 1–4 | Imports, `getpass`-prompted password + engine creation, connectivity check (`SELECT COUNT(*)`) |
| 10 questions | 5–16 | Profiling (Q1), data-quality checks (Q2–Q3), Q4–Q10, and the final yearly summary query — each executed with its resulting `DataFrame` displayed |
| Visualation | 17–22 | Data pull for Chart 1, the 3 matplotlib charts (from Q6, Q7 and Q8 results), and a redisplay of the Q8 result |
| insights | 23–31 | Displayed result + written interpretation for **Q7, Q8, Q9 and Q10 only**, each explicitly flagging correlation vs. causation |
| Final conclusion | 32–34 | Final yearly query result + consolidated summary and 4 recommendations |

## Database connection
```
oracle+oracledb://Devlab:<entered via getpass>@localhost:1521/?service_name=XEPDB1
```
The password is typed in at runtime (`getpass("Oracle password: ")`) and is **not** hardcoded anywhere in the notebook. `username`, `host`, `port` and `service_name` *are* hardcoded — harmless for a local dev instance, but worth moving to environment variables (`os.environ`, a `.env` file via `python-dotenv`) if the notebook needs to run against different environments or be shared as a reusable template.

## Charts produced
No charts are saved to disk — all 3 render inline via `plt.show()` only.

| # | Cell | Source query | What it shows |
|---|---|---|---|
| 1 | 19 | Q6 base data (`q_plot6_sql`) | Horizontal bar chart, all sub-categories by total profit, loss-making bars in red |
| 2 | 20 | Q7 | Bar chart, average profit per discount band (zero / lower / middle / high) |
| 3 | 21 | Q8 | Line chart, total sales 2014–2017, with YoY % change annotated at each point |

To persist these as image files, add `plt.savefig("charts/<name>.png", dpi=150, bbox_inches="tight")` before each `plt.show()`.

## Requirements to re-run
```
pandas
sqlalchemy
oracledb
matplotlib
```
Plus a running Oracle instance with the `SUPERSTORE` table loaded, and the Oracle account password on hand (entered at runtime, not stored).

## Headline findings
Full text is in the notebook's `insights` and `Final conclusion` cells; summarized here:

- **Scope:** 9,994 order lines, 5,009 orders, 793 customers, 2014–2017. Total sales **$2.30M**, total profit **$286.4K**, blended margin **12.5%**. Data quality is clean: no NULLs (Q2), and only 1 fully identical line among 8 repeated order-product pairs (Q3).
- **Growth:** sales fell 2.8% in 2015, then grew 29.5% (2016) and 20.4% (2017). Profit grew every year, but margin peaked at 13.4% in 2016 and eased to 12.7% in 2017 — profit growth (14.2%) lagged sales growth (20.4%) that year.
- **Discounting:** lines above 20% discount (13.9% of order lines, 15.8% of sales) lose **-$135.4K** combined; 0%-discount lines earn **+$321.0K**. Average profit per line falls from +$66.9 (no discount) to -$106.7 (41%+ discount).
- **Loss-making sub-categories:** Tables, Bookcases and Supplies lose **-$22.4K** combined on 16.0% of revenue. Tables alone is 79% of that loss and is discount-driven: +18.5% margin at 0% discount vs. -$30.7K above 20% discount. Bookcases follows the same pattern. Supplies shows no discounts above 20% at all — its loss points to pricing or unit cost, not discounting. Machines is flagged as a watchlist item: 8.2% of revenue at only a 1.8% margin.
- **Customer concentration:** the top 10 customers generate 17.5% of total profit at a 41% margin, but the top 3's profit is 81–98% concentrated in a single order each — "lifetime profit" here rewards one-off large purchases over loyalty. 155 customers (19.5%) are net-unprofitable, -$71.2K combined; the #1 customer by sales, Sean Miller ($25.0K), is himself at a loss of -$1,981.

Correlation-vs-causation is explicitly flagged in three of the four narrative insights — Q7 (discount → profit), Q9 (discount → sub-category loss) and Q10 (profit → margin) each carry a stated "correlation, not causation" note. Q8's insight is a plain trend description and makes no causal claim to flag.
