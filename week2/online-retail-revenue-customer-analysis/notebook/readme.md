# Notebook — `Revenue_Analysis.ipynb`

[← Project README](../README.md) · [Dataset README](../data/README.md) · [Insights and Results](../INSIGHTS_AND_RESULTS.md) · [Chart index](../charts/README.md)

## Purpose

Find **where revenue comes from** (time, country, products) and **how concentrated, loyal and valuable the customer base is**, using the invoice-line data in [`data/data.csv`](../data/README.md) (541,909 rows x 8 columns, 1 Dec 2010 - 9 Dec 2011). The notebook is written in Polars and follows a fixed structure: overview and cleaning, revenue analysis, customer-level analysis, statistical tests, final conclusion.

> **Viewing note:** GitHub does not render interactive Plotly outputs. Use the static PNGs in [`charts/png`](../charts/png) (linked below) or open the notebook locally.

## Tools

| Tool | Use |
|---|---|
| **Polars** | Loading, cleaning, aggregation, joins, pivots, window-style ranking (all analysis code) |
| **pandas / NumPy** | Imported; NumPy is used for test inputs and the correlation matrix |
| **Plotly** (`express`, `graph_objects`, `make_subplots`) | All 11 charts |
| **SciPy** (`scipy.stats`) | Shapiro-Wilk, Mann-Whitney U, chi-square, Spearman |
| Jupyter / VS Code | Execution environment |

## Methodology

### 1. Data overview and cleaning

| Step | Action | Result |
|---|---|---|
| Overview | Shape, `describe`, nulls, duplicates, `nunique`, anomaly counts | 5,268 duplicates, 9,288 cancellations, 10,624 `Quantity <= 0`, 2,517 `UnitPrice <= 0`, 135,080 without `CustomerID` |
| 1 | `snake_case` columns, parse dates (`%m/%d/%Y %H:%M`), drop exact duplicates | 541,909 -> 536,641 rows |
| 2 | Remove non-product `stock_code` rows (postage, fees, adjustments, bad debt, vouchers) | -2,944 rows (0.55%) |
| 3 | Remove `unit_price <= 0` | -2,492 rows (0.47%) -> **531,205** clean lines |
| 4 | Split sales / returns; derive `revenue`, `month`, `weekday`, `hour`; verify | 522,537 sales lines, 8,668 return lines |
| 5 | Check missing `customer_id` and extreme quantities | 24.8% of lines (15.4% of net revenue) anonymous; two reversed orders found |
| 6 | Partial-period guard | Dec 2011 has 9 days and is excluded from comparisons and cohorts |

Key definitions: **net revenue = sales + returns**; cancellations are kept as negative revenue; both sides of the two fully reversed orders (customers `12346`, `16446`; together 245,653) are excluded from **order and customer counts** (`sales_ex`, `returns_ex`) because each pair sums to zero.

### 2. Revenue analysis

| Section | Question | Output |
|---|---|---|
| 2.1 Headline KPIs | How much revenue, and how much comes back? | Net revenue **9,771,318**; returns **2.3%** of gross |
| 2.2 Monthly trend | When does revenue peak? | [Chart 01](../charts/readmes/01_monthly_net_revenue_and_orders.md) |
| 2.3 Revenue by country | How dependent is revenue on the home market? | [Chart 02](../charts/readmes/02_top10_non_uk_countries_net_revenue.md) |
| 2.4 Products | Concentrated or spread? | [Chart 03](../charts/readmes/03_top10_products_net_revenue.md), [Chart 04](../charts/readmes/04_product_pareto_curve.md) |
| 2.5 When customers buy | Which weekdays and hours? | [Chart 05](../charts/readmes/05_net_revenue_by_weekday_and_hour.md) |
| 2.6 Returns | Where do returns come from? | [Chart 06](../charts/readmes/06_monthly_return_rate.md) |

### 3. Customer-level analysis

A customer table (`cust_statistic`) is built first because tests and segments compare customers, not invoice lines: 4,333 identified customers, minus 13 whose returns cancel out their purchases = **4,320**.

| Section | Question | Output |
|---|---|---|
| 3.2 Revenue concentration | How much comes from the best customers? | [Chart 07](../charts/readmes/07_customer_revenue_concentration_curve.md) |
| 3.3 Repeat behaviour | How many come back? | [Chart 08](../charts/readmes/08_customer_vs_revenue_share_by_order_count.md) |
| 3.4 RFM segmentation | Who are the valuable and lapsed customers? | [Chart 09](../charts/readmes/09_rfm_segments_bubble_chart.md) |
| 3.5 Cohort retention | How fast do cohorts decay? | [Chart 10](../charts/readmes/10_cohort_retention_heatmap.md) |
| 3.6 UK vs non-UK | Do foreign customers differ? | Summary table (no chart) |

RFM method: snapshot = last invoice date + 1 day; each of R, F, M scored 1-5 with `qcut` on the `ordinal` rank; eight rule-based segments written as a vectorised `when/then` chain. Cohort method: cohort = month of first order; retention = share of the cohort ordering in month *n*; cohorts and activity stop at Nov 2011.

### 4. Statistical analysis

All tests use `alpha = 0.05` on the customer table. The test is chosen from the distribution (strong right skew and Shapiro rejection lead to a rank-based test).

| Test | Question | Result |
|---|---|---|
| Mann-Whitney U (4.1) | Do UK and non-UK customers differ in AOV? | **Reject H0.** Median AOV 388 (non-UK) vs 279 (UK); U = 576,506; p = 3.75e-22; rank-biserial effect -0.289 |
| Chi-square (4.2) | Is repeat purchase related to country group? | **Fail to reject H0.** Repeat rate 64.1% (non-UK) vs 65.6% (UK); chi-square = 0.29, p = 0.589; Cramer's V = 0.008 |
| Spearman matrix (4.3) | Which customer metrics move together? | [Chart 11](../charts/readmes/11_spearman_correlation_heatmap.md): orders vs net revenue +0.81; recency vs orders -0.56; AOV vs orders +0.16 |

## Key findings

| # | Finding | Chart |
|---|---|---|
| 1 | Net revenue **9,771,318** (2.3% returned); Nov 2011 is **2.25x** the Jan-Aug average; Sep-Nov hold **37.5%** of the 12 complete months; the peak is order volume (2.03x orders, 1.10x value per order) | [01](../charts/readmes/01_monthly_net_revenue_and_orders.md) |
| 2 | UK brings **84.8%** of net revenue; Netherlands, EIRE and Australia depend on 3-9 large accounts; Germany and France are broad, UK-like markets | [02](../charts/readmes/02_top10_non_uk_countries_net_revenue.md) |
| 3 | Top 10 products = **8.2%** of net revenue; **840 of 3,921** products (21.4%) make 80% | [03](../charts/readmes/03_top10_products_net_revenue.md), [04](../charts/readmes/04_product_pareto_curve.md) |
| 4 | 10-15h holds **75.6%** of revenue; Thursday **21.3%**, Sunday **8.1%**, no Saturday | [05](../charts/readmes/05_net_revenue_by_weekday_and_hour.md) |
| 5 | Monthly return rate **1.2%-6.5%** (peak Apr 2011); top 8 returned products only 18.8% of returned value | [06](../charts/readmes/06_monthly_return_rate.md) |
| 6 | Top 10% of customers = **60.1%** of net revenue; mean 1,914 vs median 650 | [07](../charts/readmes/07_customer_revenue_concentration_curve.md) |
| 7 | **65.4%** repeat rate; one-time buyers 34.6% of customers but 6.5% of revenue; 10+ orders = 8.9% of customers, 52.5% of revenue | [08](../charts/readmes/08_customer_vs_revenue_share_by_order_count.md) |
| 8 | Champions: **25.7%** of customers, **67.9%** of revenue; `Can't Lose Them` + `At Risk` = 15.3% of customers, 9.5% of revenue (about 785k) | [09](../charts/readmes/09_rfm_segments_bubble_chart.md) |
| 9 | Month-1 / 3 / 6 retention 21.3% / 24.6% / 26.9%; Nov 2011 calendar lift 30.5% vs 25.3% | [10](../charts/readmes/10_cohort_retention_heatmap.md) |
| 10 | Order frequency, not basket size, separates high-value customers (orders vs net revenue +0.81; AOV vs orders +0.16) | [11](../charts/readmes/11_spearman_correlation_heatmap.md) |

The full narrative, recommendations and limitations are in [Insights and Results](../INSIGHTS_AND_RESULTS.md).

## How to run

```bash
# from the repository root
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
jupyter lab notebooks/Revenue_Analysis.ipynb
```

The data path in the loading cell is `../data/data.csv` (relative to the `notebooks/` folder). Run the cells top to bottom; the notebook runs end to end without errors.

## Notes and limitations

- **RFM tie-breaking:** `ordinal` ranking breaks ties by row order, so segment sizes can differ by a few customers between runs. The figures in the documentation are the executed outputs stored in this notebook. Sorting `cust_statistic` by `customer_id` before ranking would make them reproducible.
- **Currency** is not stated in the data; GBP is assumed.
- **Revenue, not profit:** there is no cost or margin data.
- **Period:** 13 months, Dec 2011 partial; seasonality cannot be separated from growth.
- **Missing identity:** customer-level results describe the identified 75% of lines (84.6% of net revenue).
- **Association, not causation:** all comparisons are observational.

