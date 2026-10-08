# Online Retail — Revenue and Customer-Level Analysis

A Polars-based analysis of **541,909 invoice lines** (13 months, Dec 2010 - Dec 2011) that shows **where revenue comes from** and **how concentrated, loyal and valuable the customer base is**: monthly trend, country, products, timing, returns, customer concentration, repeat behaviour, RFM segments, cohort retention and statistical tests.

![Monthly Net Revenue and Order Count](charts/01_monthly_net_revenue_and_orders.png)

## Key results

| Metric | Value |
|---|---|
| Net revenue | **9,771,318** (gross 10,001,566, returns 230,248 = **2.3%**) |
| Seasonality | Nov 2011 is **2.25x** the Jan-Aug average; Sep-Nov hold **37.5%** of the 12 complete months |
| Geography | UK brings **84.8%** of net revenue |
| Catalogue | Top 10 products = **8.2%**; 840 of 3,921 products (21.4%) make 80% |
| Concentration | Top 10% of customers = **60.1%** of net revenue |
| Loyalty | **65.4%** repeat rate; one-time buyers 34.6% of customers, 6.5% of revenue |
| Segments | Champions: 25.7% of customers, **67.9%** of revenue; `Can't Lose Them` + `At Risk`: about **785k** (9.5%) |
| Statistics | Non-UK AOV is higher (388 vs 279, p = 3.75e-22); repeat rate does not differ by country group (p = 0.589) |

Full narrative, recommendations and limitations: **[Insights and Results](INSIGHTS_AND_RESULTS.md)**.

## Repository structure

```
online-retail-revenue-customer-analysis/
├── README.md                    this file
├── INSIGHTS_AND_RESULTS.md      findings, statistics, recommendations, limitations
├── requirements.txt             Python dependencies for the notebook
├── .gitignore
├── data/
│   ├── README.md                dataset documentation
│   └── data.csv                 541,909 x 8 invoice lines
├── notebooks/
│   ├── README.md                notebook documentation (methodology, tools, findings)
│   └── Revenue_Analysis.ipynb   the analysis (Polars + Plotly + SciPy)
├── charts/
│   ├── README.md               chart index and gallery
│   ├── charts                     
│   └── readmes                 one README per chart
└── scripts/
    ├── export_charts.py         exports the notebook's Plotly figures to PNG
    └── requirements-export.txt  pinned dependencies for the export script
```

## Documentation

| Document | Content |
|---|---|
| [Insights and Results](INSIGHTS_AND_RESULTS.md) | Key findings, statistical tests, recommendations, limitations |
| [Notebook README](notebooks/README.md) | Purpose, tools, methodology, key findings, how to run |
| [Dataset README](data/README.md) | Columns, types, data quality, derived fields, analytical purpose |
| [Chart index](charts/README.md) | 11 charts with a README each |

## Charts

| | | |
|---|---|---|
| [![Monthly Net Revenue and Order Count](charts/01_monthly_net_revenue_and_orders.png)](charts/readmes/01_monthly_net_revenue_and_orders.md)<br>**01.** Monthly Net Revenue and Order Count | [![Top 10 Non-UK Countries by Net Revenue](charts/02_top10_non_uk_countries_net_revenue.png)](charts/readmes/02_top10_non_uk_countries_net_revenue.md)<br>**02.** Top 10 Non-UK Countries by Net Revenue | [![Top 10 Products by Net Revenue](charts/03_top10_products_net_revenue.png)](charts/readmes/03_top10_products_net_revenue.md)<br>**03.** Top 10 Products by Net Revenue |
| [![Cumulative Net Revenue Share by Product Rank (Pareto Curve)](charts/04_product_pareto_curve.png)](charts/readmes/04_product_pareto_curve.md)<br>**04.** Cumulative Net Revenue Share by Product Rank (Pareto Curve) | [![Net Revenue by Weekday and by Hour of Day](charts/05_net_revenue_by_weekday_and_hour.png)](charts/readmes/05_net_revenue_by_weekday_and_hour.md)<br>**05.** Net Revenue by Weekday and by Hour of Day | [![Monthly Return Rate by Value](charts/06_monthly_return_rate.png)](charts/readmes/06_monthly_return_rate.md)<br>**06.** Monthly Return Rate by Value |
| [![Cumulative Net Revenue Share by Customer Rank](charts/07_customer_revenue_concentration_curve.png)](charts/readmes/07_customer_revenue_concentration_curve.md)<br>**07.** Cumulative Net Revenue Share by Customer Rank | [![Share of Customers vs Share of Net Revenue by Number of Orders](charts/08_customer_vs_revenue_share_by_order_count.png)](charts/readmes/08_customer_vs_revenue_share_by_order_count.md)<br>**08.** Share of Customers vs Share of Net Revenue by Number of Orders | [![RFM Segments: Recency vs Frequency](charts/09_rfm_segments_bubble_chart.png)](charts/readmes/09_rfm_segments_bubble_chart.md)<br>**09.** RFM Segments: Recency vs Frequency |
| [![Monthly Cohort Retention Heatmap](charts/10_cohort_retention_heatmap.png)](charts/readmes/10_cohort_retention_heatmap.md)<br>**10.** Monthly Cohort Retention Heatmap | [![Spearman Correlation Between Customer Metrics](charts/11_spearman_correlation_heatmap.png)](charts/readmes/11_spearman_correlation_heatmap.md)<br>**11.** Spearman Correlation Between Customer Metrics | |

## Quick start

```bash
git clone <your-repository-url>
cd online-retail-revenue-customer-analysis
python -m venv .venv && source .venv/bin/activate     # Windows: .venv\Scripts\activate
pip install -r requirements.txt
jupyter lab notebooks/Revenue_Analysis.ipynb
```

## Tech stack

Polars · pandas · NumPy · Plotly · SciPy · Jupyter

## Notes

- Currency is not stated in the data; **GBP is assumed**.
- Results describe **revenue, not profit** (no cost data) and are **associations, not causes**.
- GitHub does not render interactive Plotly outputs: use the PNGs in [`charts/png`](charts/png).
- Confirm the source and licence terms of the dataset before publishing `data.csv` (see the [dataset README](data/README.md)).

