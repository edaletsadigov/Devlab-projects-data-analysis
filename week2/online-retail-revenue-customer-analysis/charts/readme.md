# Charts

All 11 charts of the analysis, exported as PNG images from the Plotly figures stored in [`notebooks/Revenue_Analysis.ipynb`](../notebooks/Revenue_Analysis.ipynb). Each chart has its own README that explains what it shows, the numbers behind it, the key findings and the business meaning.

[← Project README](../README.md) · [Insights and Results](../INSIGHTS_AND_RESULTS.md)

## Index

| # | Chart (README) | Notebook section | PNG file |
|---|---|---|---|
| 01 | [Monthly Net Revenue and Order Count](readmes/01_monthly_net_revenue_and_orders.md) | 2.2 Monthly trend | [`01_monthly_net_revenue_and_orders.png`](png/01_monthly_net_revenue_and_orders.png) |
| 02 | [Top 10 Non-UK Countries by Net Revenue](readmes/02_top10_non_uk_countries_net_revenue.md) | 2.3 Revenue by country | [`02_top10_non_uk_countries_net_revenue.png`](png/02_top10_non_uk_countries_net_revenue.png) |
| 03 | [Top 10 Products by Net Revenue](readmes/03_top10_products_net_revenue.md) | 2.4 Products | [`03_top10_products_net_revenue.png`](png/03_top10_products_net_revenue.png) |
| 04 | [Cumulative Net Revenue Share by Product Rank (Pareto Curve)](readmes/04_product_pareto_curve.md) | 2.4 Products | [`04_product_pareto_curve.png`](png/04_product_pareto_curve.png) |
| 05 | [Net Revenue by Weekday and by Hour of Day](readmes/05_net_revenue_by_weekday_and_hour.md) | 2.5 When customers buy | [`05_net_revenue_by_weekday_and_hour.png`](png/05_net_revenue_by_weekday_and_hour.png) |
| 06 | [Monthly Return Rate by Value](readmes/06_monthly_return_rate.md) | 2.6 Returns | [`06_monthly_return_rate.png`](png/06_monthly_return_rate.png) |
| 07 | [Cumulative Net Revenue Share by Customer Rank](readmes/07_customer_revenue_concentration_curve.md) | 3.2 Revenue concentration | [`07_customer_revenue_concentration_curve.png`](png/07_customer_revenue_concentration_curve.png) |
| 08 | [Share of Customers vs Share of Net Revenue by Number of Orders](readmes/08_customer_vs_revenue_share_by_order_count.md) | 3.3 Repeat behaviour | [`08_customer_vs_revenue_share_by_order_count.png`](png/08_customer_vs_revenue_share_by_order_count.png) |
| 09 | [RFM Segments: Recency vs Frequency](readmes/09_rfm_segments_bubble_chart.md) | 3.4 RFM segmentation | [`09_rfm_segments_bubble_chart.png`](png/09_rfm_segments_bubble_chart.png) |
| 10 | [Monthly Cohort Retention Heatmap](readmes/10_cohort_retention_heatmap.md) | 3.5 Cohort retention | [`10_cohort_retention_heatmap.png`](png/10_cohort_retention_heatmap.png) |
| 11 | [Spearman Correlation Between Customer Metrics](readmes/11_spearman_correlation_heatmap.md) | 4.3 Which customer metrics move together? | [`11_spearman_correlation_heatmap.png`](png/11_spearman_correlation_heatmap.png) |

## Folder layout

```
charts/
├── README.md          this index
├── png/               11 PNG images (1200 x 720 px at 2x scale)
└── readmes/           one README per chart
```

## How the PNGs were produced

The notebook stores each chart as an interactive Plotly figure. [`scripts/export_charts.py`](../scripts/export_charts.py) reads those figures from the notebook and writes static PNGs (1200 x 720 px, 2x scale). Chart data and styling are unchanged, with three presentation-only adjustments: charts 01, 06 and 10 use category axes so that every month/cohort label is shown, and chart 10 has extra top margin so the title does not overlap the axis title.

## Gallery

### Chart 01 — Monthly Net Revenue and Order Count
[![Monthly Net Revenue and Order Count](01_monthly_net_revenue_and_orders.png)](readmes/01_monthly_net_revenue_and_orders.md)

### Chart 02 — Top 10 Non-UK Countries by Net Revenue
[![Top 10 Non-UK Countries by Net Revenue](png/02_top10_non_uk_countries_net_revenue.png)](readmes/02_top10_non_uk_countries_net_revenue.md)

### Chart 03 — Top 10 Products by Net Revenue
[![Top 10 Products by Net Revenue](png/03_top10_products_net_revenue.png)](readmes/03_top10_products_net_revenue.md)

### Chart 04 — Cumulative Net Revenue Share by Product Rank (Pareto Curve)
[![Cumulative Net Revenue Share by Product Rank (Pareto Curve)](png/04_product_pareto_curve.png)](readmes/04_product_pareto_curve.md)

### Chart 05 — Net Revenue by Weekday and by Hour of Day
[![Net Revenue by Weekday and by Hour of Day](png/05_net_revenue_by_weekday_and_hour.png)](readmes/05_net_revenue_by_weekday_and_hour.md)

### Chart 06 — Monthly Return Rate by Value
[![Monthly Return Rate by Value](png/06_monthly_return_rate.png)](readmes/06_monthly_return_rate.md)

### Chart 07 — Cumulative Net Revenue Share by Customer Rank
[![Cumulative Net Revenue Share by Customer Rank](png/07_customer_revenue_concentration_curve.png)](readmes/07_customer_revenue_concentration_curve.md)

### Chart 08 — Share of Customers vs Share of Net Revenue by Number of Orders
[![Share of Customers vs Share of Net Revenue by Number of Orders](png/08_customer_vs_revenue_share_by_order_count.png)](readmes/08_customer_vs_revenue_share_by_order_count.md)

### Chart 09 — RFM Segments: Recency vs Frequency
[![RFM Segments: Recency vs Frequency](png/09_rfm_segments_bubble_chart.png)](readmes/09_rfm_segments_bubble_chart.md)

### Chart 10 — Monthly Cohort Retention Heatmap
[![Monthly Cohort Retention Heatmap](png/10_cohort_retention_heatmap.png)](readmes/10_cohort_retention_heatmap.md)

### Chart 11 — Spearman Correlation Between Customer Metrics
[![Spearman Correlation Between Customer Metrics](png/11_spearman_correlation_heatmap.png)](readmes/11_spearman_correlation_heatmap.md)

