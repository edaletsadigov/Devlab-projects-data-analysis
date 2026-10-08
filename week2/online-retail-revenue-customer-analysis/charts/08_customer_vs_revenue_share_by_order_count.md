# Chart 08 — Share of Customers vs Share of Net Revenue by Number of Orders

[← Chart 07](07_customer_revenue_concentration_curve.md) · [Chart index](../README.md) · [Chart 09 →](09_rfm_segments_bubble_chart.md)

![Share of Customers vs Share of Net Revenue by Number of Orders](../png/08_customer_vs_revenue_share_by_order_count.png)

| | |
|---|---|
| **Chart file** | [`08_customer_vs_revenue_share_by_order_count.png`](../png/08_customer_vs_revenue_share_by_order_count.png) |
| **Chart type** | Grouped bar chart |
| **Notebook section** | 3.3 Repeat behaviour ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
For each group of customers by number of orders, two bars: the share of customers (blue) and the share of net revenue (orange).

## Data and method
- Customers are bucketed by their number of orders: 1, 2, 3-4, 5-9, 10+.
- Repeat rate = share of customers with 2 or more orders.

## Numbers behind the chart
| Orders per customer | Customers | Net revenue | Customer share (%) | Revenue share (%) |
|---|---:|---:|---:|---:|
| 1 order | 1,494 | 536,419.4 | 34.6 | 6.5 |
| 2 orders | 828 | 540,174.5 | 19.2 | 6.5 |
| 3-4 orders | 897 | 1,152,247 | 20.8 | 13.9 |
| 5-9 orders | 715 | 1,696,926.2 | 16.6 | 20.5 |
| 10+ orders | 386 | 4,343,870.2 | 8.9 | 52.5 |

## Key findings
- **65.4%** of customers ordered at least twice (repeat rate).
- **One-time buyers are 34.6% of customers but only 6.5% of revenue.**
- **Customers with 10+ orders are 8.9% of customers but 52.5% of revenue.**

## Analytical and business meaning
Revenue depends on a small group of frequent buyers, and the step from first to second order is where about a third of customers stop. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#5-a-third-of-customers-never-return).

## Caveats
- Order counts cover a 13-month window; customers with one order may have bought before the data starts or may still return later.

---
[← Chart 07](07_customer_revenue_concentration_curve.md) · [Chart index](../README.md) · [Chart 09 →](09_rfm_segments_bubble_chart.md)
