# Chart 09 — RFM Segments: Recency vs Frequency

[← Chart 08](08_customer_vs_revenue_share_by_order_count.md) · [Chart index](../README.md) · [Chart 10 →](10_cohort_retention_heatmap.md)

![RFM Segments: Recency vs Frequency](../png/09_rfm_segments_bubble_chart.png)

| | |
|---|---|
| **Chart file** | [`09_rfm_segments_bubble_chart.png`](../png/09_rfm_segments_bubble_chart.png) |
| **Chart type** | Bubble scatter plot |
| **Notebook section** | 3.4 RFM segmentation ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
The eight RFM segments. The x-axis is average recency (days since last order; **axis reversed**, so recent customers are on the right), the y-axis is average orders per customer, bubble size is the number of customers and colour is the segment's share of net revenue.

## Data and method
- Snapshot date = last invoice date + 1 day (**2011-12-10 12:50**). Recency = days since the last order (min / median / max: 1 / 51 / 374 days); Frequency = number of orders; Monetary = net revenue.
- Each metric is scored 1-5 with `qcut` on the rank (`ordinal` rank breaks ties by row order).
- Segments are rule-based on the R and F scores and written as a vectorised `when/then` chain in the notebook.

## Numbers behind the chart
| Segment | Customers | Customer share (%) | Net revenue | Revenue share (%) | Avg recency (days) | Avg orders |
|---|---:|---:|---:|---:|---:|---:|
| Champions | 1,109 | 25.7 | 5,614,253.9 | 67.9 | 12.9 | 10.1 |
| Loyal Customers | 823 | 19.1 | 1,188,557.3 | 14.4 | 37.1 | 3.7 |
| Can't Lose Them | 297 | 6.9 | 488,529.4 | 5.9 | 133.6 | 4.8 |
| Hibernating | 1,068 | 24.7 | 416,433.6 | 5.0 | 217.7 | 1.1 |
| At Risk | 363 | 8.4 | 296,366.5 | 3.6 | 162.9 | 2.3 |
| Need Attention | 347 | 8.0 | 150,500.6 | 1.8 | 52.6 | 1.2 |
| Potential Loyalists | 181 | 4.2 | 74,553.4 | 0.9 | 16.3 | 1.4 |
| New Customers | 132 | 3.1 | 40,442.6 | 0.5 | 19.7 | 1.0 |

## Key findings
- **Champions are 25.7% of customers (1,109) and bring 67.9% of net revenue**, ordering 10.1 times on average with the last order 12.9 days before the snapshot.
- Champions + `Can't Lose Them` = **32.5% of customers and 73.8% of net revenue**.
- `Can't Lose Them` (297 customers, 134 days since last order) and `At Risk` (363 customers, 163 days) together are **15.3% of customers and 9.5% of net revenue (about 785k)**: customers who used to buy often and went quiet.
- `Hibernating` is the largest low-value group (24.7% of customers, 5.0% of revenue).
- `New Customers` and `Potential Loyalists` are small (3.1% and 4.2% of customers), so the pipeline of new buyers is thin at the snapshot date.

## Analytical and business meaning
The base splits into a small, very valuable active core and a long tail of low-value or lapsed customers. The win-back opportunity sits in `Can't Lose Them` and `At Risk`. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#6-about-785k-of-revenue-is-in-customers-who-went-quiet).

## Caveats
- `ordinal` ranking breaks ties by row order, so customers with identical values (for example many with `orders = 1`) can land in neighbouring score bins. Segment sizes are therefore approximate and may differ by a few customers if the notebook is re-run; the figures here are the executed outputs stored in the notebook.
- Segment labels are rule-based and illustrative, not statistically derived clusters.

---
[← Chart 08](08_customer_vs_revenue_share_by_order_count.md) · [Chart index](../README.md) · [Chart 10 →](10_cohort_retention_heatmap.md)
