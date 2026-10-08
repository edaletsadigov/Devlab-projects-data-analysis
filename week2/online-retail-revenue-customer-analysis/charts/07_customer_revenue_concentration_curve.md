# Chart 07 — Cumulative Net Revenue Share by Customer Rank

[← Chart 06](06_monthly_return_rate.md) · [Chart index](../README.md) · [Chart 08 →](08_customer_vs_revenue_share_by_order_count.md)

![Cumulative Net Revenue Share by Customer Rank](../png/07_customer_revenue_concentration_curve.png)

| | |
|---|---|
| **Chart file** | [`07_customer_revenue_concentration_curve.png`](../png/07_customer_revenue_concentration_curve.png) |
| **Chart type** | Line chart (cumulative share / Lorenz-style curve) with an equality diagonal |
| **Notebook section** | 3.2 Revenue concentration ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Customers are ranked by net revenue (best first). The x-axis is the share of customers and the y-axis is the cumulative share of net revenue. The dashed grey diagonal is perfect equality.

## Data and method
- Customer table (`cust_statistic`): 4,320 identified customers after removing 13 customers whose returns cancel out their purchases.
- Net revenue per customer = sales + returns for that customer.

## Numbers behind the chart
| Metric | Value |
|---|---:|
| Customers analysed | 4,320 |
| Mean net revenue per customer | 1,914 |
| Median net revenue per customer | 650 (mean is 2.9x the median) |
| Top 10% of customers: share of net revenue | 60.1% |
| Top 20% of customers: share of net revenue | 73.7% |
| Bottom 50% of customers: share of net revenue | 8.1% |

## Key findings
- Net revenue per customer is **strongly right-skewed**: mean **1,914** vs median **650**.
- The best **10%** of customers bring **60.1%** of net revenue; the best 20% bring **73.7%**; the bottom half brings only **8.1%**.

## Analytical and business meaning
Losing a handful of top accounts would hurt far more than losing many small ones, which makes account protection and early-warning on top customers a priority. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#4-customers-are-heavily-concentrated) and the [RFM view](09_rfm_segments_bubble_chart.md).

## Caveats
- Only identified customers are included (anonymous lines carry 15.4% of net revenue and are excluded here).

---
[← Chart 06](06_monthly_return_rate.md) · [Chart index](../README.md) · [Chart 08 →](08_customer_vs_revenue_share_by_order_count.md)
