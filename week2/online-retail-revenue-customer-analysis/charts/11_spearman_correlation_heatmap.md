# Chart 11 — Spearman Correlation Between Customer Metrics

[← Chart 10](10_cohort_retention_heatmap.md) · [Chart index](../README.md)

![Spearman Correlation Between Customer Metrics](../png/11_spearman_correlation_heatmap.png)

| | |
|---|---|
| **Chart file** | [`11_spearman_correlation_heatmap.png`](../png/11_spearman_correlation_heatmap.png) |
| **Chart type** | Correlation heatmap (`imshow`, `RdBu_r`, range -1 to 1) |
| **Notebook section** | 4.3 Which customer metrics move together? ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Spearman rank correlations between five customer-level metrics: `orders`, `products` (distinct products bought), `aov` (average order value), `recency_days` and `net_revenue`.

## Data and method
- Spearman is used because every metric is right-skewed (see [Chart 07](07_customer_revenue_concentration_curve.md)).
- Computed on the customer table (4,320 customers).

## Numbers behind the chart
| | orders | products | aov | recency_days | net_revenue |
|---|---:|---:|---:|---:|---:|
| **orders** | 1.00 | 0.65 | 0.16 | -0.56 | 0.81 |
| **products** | 0.65 | 1.00 | 0.41 | -0.46 | 0.73 |
| **aov** | 0.16 | 0.41 | 1.00 | -0.13 | 0.68 |
| **recency_days** | -0.56 | -0.46 | -0.13 | 1.00 | -0.48 |
| **net_revenue** | 0.81 | 0.73 | 0.68 | -0.48 | 1.00 |

## Key findings
- Orders and net revenue move together (**rho +0.81**), as do distinct products bought and net revenue (**+0.73**).
- More recent customers order more often (**recency vs orders -0.56**).
- AOV is almost unrelated to the number of orders (**+0.16**), so order frequency, not basket size, separates high-value customers.

## Analytical and business meaning
Frequency is the main lever behind customer value in this data. **These are associations on observational data, not causes:** orders and net revenue are linked by construction, and orders vs recency only shows that active buyers order more. Only a controlled experiment (for example a win-back offer) could show that more orders cause more revenue. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#statistical-tests).

## Caveats
- Correlation is not causation.
- Spearman measures monotonic association only.

---
[← Chart 10](10_cohort_retention_heatmap.md) · [Chart index](../README.md)
