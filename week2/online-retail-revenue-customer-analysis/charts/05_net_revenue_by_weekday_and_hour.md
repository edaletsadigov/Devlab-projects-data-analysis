# Chart 05 — Net Revenue by Weekday and by Hour of Day

[← Chart 04](04_product_pareto_curve.md) · [Chart index](../README.md) · [Chart 06 →](06_monthly_return_rate.md)

![Net Revenue by Weekday and by Hour of Day](../png/05_net_revenue_by_weekday_and_hour.png)

| | |
|---|---|
| **Chart file** | [`05_net_revenue_by_weekday_and_hour.png`](../png/05_net_revenue_by_weekday_and_hour.png) |
| **Chart type** | Two bar charts side by side (by weekday, by hour of day) |
| **Notebook section** | 2.5 When customers buy ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Net revenue by weekday (left) and by hour of day (right) for the whole period.

## Data and method
- Weekday and hour are taken from `invoice_date`; revenue is net (sales + returns).
- **There are no Saturday transactions in the data**, so Saturday does not appear. This is a feature of the business, not missing data.
- Trading hours in the cleaned data run from 06:00 to 20:59.

## Numbers behind the chart
**By weekday**

| Day | Net revenue | Orders | Share of net revenue (%) |
|---|---:|---:|---:|
| Mon | 1,622,206.5 | 3,076 | 16.6 |
| Tue | 1,968,073.6 | 3,508 | 20.1 |
| Wed | 1,738,840.8 | 3,667 | 17.8 |
| Thu | 2,080,487.2 | 4,209 | 21.3 |
| Fri | 1,570,910.1 | 3,108 | 16.1 |
| Sun | 790,799.9 | 2,203 | 8.1 |

**By hour of day (net revenue, GBP)**

| Hour | 06 | 07 | 08 | 09 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Net revenue | -281.3 | 30,419.3 | 277,468.7 | 771,743.6 | 1,296,167.4 | 1,163,170.5 | 1,393,573.4 | 1,179,446.6 | 1,095,621.9 | 1,254,960.2 | 689,596.6 | 422,397.3 | 134,944.6 | 46,166.6 | 15,922.7 |

## Key findings
- **10:00-15:59 holds 75.6%** of net revenue.
- **Thursday is the strongest day (21.3%)** and **Sunday the weakest (8.1%)**.
- There are **no Saturday transactions**; evening trade after 18:00 is marginal.

## Analytical and business meaning
Trade follows a **weekday-daytime pattern**, which is consistent with a business-customer base. The data has no customer-type field, so this is an interpretation, not a tested fact. Operational planning (picking, support, dispatch) can be concentrated on weekday daytime. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#interpretation-and-assumptions).

## Caveats
- The data has no customer-type field to confirm a business-customer base.
- Net revenue at 06:00 is slightly negative (-281) because returns are included.

---
[← Chart 04](04_product_pareto_curve.md) · [Chart index](../README.md) · [Chart 06 →](06_monthly_return_rate.md)
