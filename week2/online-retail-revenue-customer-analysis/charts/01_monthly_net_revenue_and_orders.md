# Chart 01 — Monthly Net Revenue and Order Count

[Chart index](../README.md) · [Chart 02 →](02_top10_non_uk_countries_net_revenue.md)

![Monthly Net Revenue and Order Count](../png/01_monthly_net_revenue_and_orders.png)

| | |
|---|---|
| **Chart file** | [`01_monthly_net_revenue_and_orders.png`](../png/01_monthly_net_revenue_and_orders.png) |
| **Chart type** | Combo chart: bar (net revenue, left axis) + line with markers (orders, right axis) |
| **Notebook section** | 2.2 Monthly trend ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Net revenue per calendar month (bars, GBP) and the number of orders (invoices, line) for the 13 months of data, December 2010 to December 2011. The grey bar is **December 2011**, which is a partial month because the data ends on **9 December 2011**.

## Data and method
- **Net revenue** = sales + returns (cancellations enter as negative revenue) on the cleaned data.
- **Orders** = distinct invoices, excluding the two fully reversed orders described in the notebook (customers `12346` and `16446`).
- Dec 2011 is excluded from all month-over-month comparisons and from ranking.

## Numbers behind the chart
| Month | Period | Net revenue | Orders | Net revenue per order | MoM change (%) |
|---|---|---:|---:|---:|---:|
| 2010-12 | Complete | 758,090.5 | 1,550 | 489.1 | n/a |
| 2011-01 | Complete | 578,855.2 | 1,080 | 536.0 | -23.6 |
| 2011-02 | Complete | 499,464.4 | 1,093 | 457.0 | -13.7 |
| 2011-03 | Complete | 679,329.2 | 1,440 | 471.8 | 36.0 |
| 2011-04 | Complete | 482,061.9 | 1,235 | 390.3 | -29.0 |
| 2011-05 | Complete | 731,004.8 | 1,668 | 438.3 | 51.6 |
| 2011-06 | Complete | 723,845.1 | 1,525 | 474.7 | -1.0 |
| 2011-07 | Complete | 676,812.1 | 1,452 | 466.1 | -6.5 |
| 2011-08 | Complete | 701,289.9 | 1,339 | 523.7 | 3.6 |
| 2011-09 | Complete | 1,011,339.7 | 1,818 | 556.3 | 44.2 |
| 2011-10 | Complete | 1,061,701.2 | 2,005 | 529.5 | 5.0 |
| 2011-11 | Complete | 1,427,124.5 | 2,751 | 518.8 | 34.4 |
| 2011-12 | **Partial (9 days)** | 440,399.6 | 815 | 540.4 | -69.1 (not meaningful) |

## Key findings
- Net revenue is flat to slowly rising from Dec 2010 to Aug 2011 (**482k-758k a month**), then climbs: Sep **1.01M**, Oct **1.06M** and **Nov 1.43M**.
- **Nov 2011 is 2.25x the Jan-Aug 2011 monthly average**, and Sep-Nov hold **37.5%** of the 12 complete months.
- The peak is a **volume effect**: Nov has **2.03x** the orders of an average Jan-Aug month but only **1.10x** the net revenue per order.
- Like-for-like check for the partial month: net revenue for **1-9 Dec** was **401,142 in 2010** and **440,400 in 2011 (+9.8%)**.

## Analytical and business meaning
Revenue growth in the autumn comes from more orders, not from bigger baskets, so capacity (stock, picking, staffing) rather than pricing or basket-building is what the seasonal peak stresses. The +9.8% like-for-like December window is only an indicative hint because it is based on one year of history. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#1-revenue-is-large-and-seasonal).

## Caveats
- Dec 2011 covers 9 days only; do not read the drop as a decline.
- One year of data cannot separate seasonality from growth.
- The notebook plots months as text labels; in this PNG the x-axis is set to a category axis so that every month is labelled (data unchanged).

---
[Chart index](../README.md) · [Chart 02 →](02_top10_non_uk_countries_net_revenue.md)
