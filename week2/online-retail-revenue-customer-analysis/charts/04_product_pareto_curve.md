# Chart 04 — Cumulative Net Revenue Share by Product Rank (Pareto Curve)

[← Chart 03](03_top10_products_net_revenue.md) · [Chart index](../README.md) · [Chart 05 →](05_net_revenue_by_weekday_and_hour.md)

![Cumulative Net Revenue Share by Product Rank (Pareto Curve)](../png/04_product_pareto_curve.png)

| | |
|---|---|
| **Chart file** | [`04_product_pareto_curve.png`](../png/04_product_pareto_curve.png) |
| **Chart type** | Line chart (Pareto / cumulative share curve) with an 80% reference line |
| **Notebook section** | 2.4 Products ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Products are ranked by net revenue (largest first). The x-axis is the share of the catalogue covered and the y-axis is the cumulative share of net revenue. The dashed horizontal line marks **80%**.

## Data and method
- 3,921 products ranked by net revenue; `cum_revenue_share_%` is the running sum divided by total net revenue.
- The number of products needed to reach 80% is the count with a cumulative share below 80%, plus one.

## Numbers behind the chart
| Metric | Value |
|---|---:|
| Products sold | 3,921 |
| Products needed for 80% of net revenue | 840 (21.4% of the catalogue) |
| Share of net revenue from the top 10 products | 8.2% |
| Products with negative net value | 19 |

## Key findings
- **840 of 3,921 products (21.4%)** make 80% of net revenue, close to a classic **80/20 Pareto**.
- The curve rises steadily rather than sharply at the start, which is the visual signature of a broad catalogue.

## Analytical and business meaning
Revenue is spread across the catalogue. Range decisions should be made on groups of products rather than on a few hero items. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#3-the-catalogue-is-broad).

## Caveats
- The curve is based on net revenue over 13 months, including products with negative net value at the tail.

---
[← Chart 03](03_top10_products_net_revenue.md) · [Chart index](../README.md) · [Chart 05 →](05_net_revenue_by_weekday_and_hour.md)
