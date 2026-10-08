# Chart 10 — Monthly Cohort Retention Heatmap

[← Chart 09](09_rfm_segments_bubble_chart.md) · [Chart index](../README.md) · [Chart 11 →](11_spearman_correlation_heatmap.md)

![Monthly Cohort Retention Heatmap](../png/10_cohort_retention_heatmap.png)

| | |
|---|---|
| **Chart file** | [`10_cohort_retention_heatmap.png`](../png/10_cohort_retention_heatmap.png) |
| **Chart type** | Heatmap (`imshow`) with cell labels |
| **Notebook section** | 3.5 Cohort retention ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Monthly cohort retention. Rows are cohorts (month of the customer's first order in the dataset), columns are months since the first order, and each cell is the percentage of the cohort that ordered in that month. Month 0 is 100% by definition.

## Data and method
- December 2011 is partial, so both cohorts and activity stop at **November 2011** (12 cohorts, periods 0-11).
- Customers whose first order falls in Dec 2010 may have bought before the data starts, so that cohort mixes new and existing customers.

## Numbers behind the chart
| Cohort | Size | | Cohort | Size |
|---|---:|---|---|---:|
| 2010-12 | 884 | | 2011-06 | 242 |
| 2011-01 | 415 | | 2011-07 | 187 |
| 2011-02 | 380 | | 2011-08 | 169 |
| 2011-03 | 452 | | 2011-09 | 299 |
| 2011-04 | 300 | | 2011-10 | 357 |
| 2011-05 | 284 | | 2011-11 | 323 |

| Metric | Value |
|---|---:|
| Average retention in month 1 / 3 / 6 | 21.3% / 24.6% / 26.9% |
| Dec 2010 cohort retention at month 11 | 50.2% |
| Month-1 retention of cohorts after Dec 2010 (average) | 19.8% (individual cohorts 15-24%) |
| Nov 2011 cells (11 cohorts), average retention | 30.5% |
| Same cohorts, other months, average retention | 25.3% |

## Key findings
- On average **21.3%** of a cohort orders again in month 1, **24.6%** in month 3 and **26.9%** in month 6: retention drops after the first month and then stays roughly flat instead of decaying.
- The **Dec 2010 cohort** is much larger (884 customers vs 169-452 later) and keeps **50.2%** at month 11, but part of it is existing customers.
- **Calendar effect:** Nov 2011 (the last diagonal of the heatmap) shows **30.5%** average retention vs **25.3%** for the same cohorts in other months.

## Analytical and business meaning
Part of the apparent loyalty of older cohorts is the **seasonal peak, not customer age**. Cohorts after Dec 2010 stay at 15-24% in month 1, so the single-month return rate of new customers is the number to improve. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#5-a-third-of-customers-never-return).

## Caveats
- The colour scale runs to 100% because of month 0, so differences among the later cells look compressed; read the printed cell values.
- Left-censoring: the Dec 2010 cohort cannot show customers' real first orders.
- The notebook plots cohort labels as text; in this PNG both axes are set to category axes so that every label is shown (data unchanged).

---
[← Chart 09](09_rfm_segments_bubble_chart.md) · [Chart index](../README.md) · [Chart 11 →](11_spearman_correlation_heatmap.md)
