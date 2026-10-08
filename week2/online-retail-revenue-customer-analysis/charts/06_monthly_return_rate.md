# Chart 06 — Monthly Return Rate by Value

[← Chart 05](05_net_revenue_by_weekday_and_hour.md) · [Chart index](../README.md) · [Chart 07 →](07_customer_revenue_concentration_curve.md)

![Monthly Return Rate by Value](../png/06_monthly_return_rate.png)

| | |
|---|---|
| **Chart file** | [`06_monthly_return_rate.png`](../png/06_monthly_return_rate.png) |
| **Chart type** | Line chart with markers |
| **Notebook section** | 2.6 Returns ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
Monthly return rate by value: returns as a percentage of gross sales, **excluding the two fully reversed orders** (customers `12346` and `16446`). Dec 2011 is partial.

## Data and method
- Return rate = returned value / gross sales for each month, using `sales_ex` and `returns_ex` (the two reversed orders removed from both sides).
- Including them, the overall return rate would be 4.6% instead of **2.3%**.

## Numbers behind the chart
**Monthly return rate (%)**

| Month | 2010-12 | 2011-01 | 2011-02 | 2011-03 | 2011-04 | 2011-05 | 2011-06 | 2011-07 | 2011-08 | 2011-09 | 2011-10 | 2011-11 | 2011-12 (partial) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Return rate | 2.3 | 2.4 | 1.6 | 1.5 | **6.5** | 1.2 | 1.9 | 1.7 | 3.2 | 1.7 | 3.8 | 1.7 | 1.3 |

**Eight largest returned products by value** (table output from the notebook)

| Stock code | Product | Returned value | Returned units | Gross value | Return rate (%) |
|---|---|---:|---:|---:|---:|
| 22423 | REGENCY CAKESTAND 3 TIER | 9,697.0 | 855 | 174,156.5 | 5.6 |
| 85123A | WHITE HANGING HEART T-LIGHT HOLDER | 6,624.3 | 2,578 | 104,462.8 | 6.3 |
| 21108 | FAIRY CAKE FLANNEL ASSORTED COLOUR | 6,591.4 | 3,150 | 18,056.3 | 36.5 |
| 23113 | PANTRY CHOPPING BOARD | 4,803.1 | 946 | 5,868.5 | 81.8 |
| 48185 | DOORMAT FAIRY CAKE | 4,554.9 | 674 | 23,872.9 | 19.1 |
| 21175 | GIN + TONIC DIET METAL SIGN | 3,775.3 | 2,030 | 27,030.0 | 14.0 |
| 47566B | TEA TIME PARTY BUNTING | 3,692.9 | 1,424 | 11,275.3 | 32.8 |
| 22273 | FELTCRAFT DOLL MOLLY | 3,512.6 | 1,447 | 12,001.6 | 29.3 |

## Key findings
- The monthly return rate ranges **1.2%-6.5%**, with the peak in **April 2011**.
- The 8 largest returned products carry only **18.8%** of returned value, so returns are **spread rather than caused by a few products**.
- Some products stand out on rate: `PANTRY CHOPPING BOARD` **81.8%** (4,803 returned vs 5,869 sold), `FAIRY CAKE FLANNEL ASSORTED COLOUR` **36.5%** and `TEA TIME PARTY BUNTING` **32.8%**.

## Analytical and business meaning
Overall returns are modest (2.3% of gross value) and stable apart from isolated months. Product-level rates are a **screening signal** for listing or quality problems, not a verdict. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#8-data-quality-shapes-the-numbers).

## Caveats
- The file has no return reason, and a cancellation can refer to a purchase made before the period, so product-level rates are indicative.
- The notebook plots months as text labels; in this PNG the x-axis is set to a category axis so that every month is labelled (data unchanged).

---
[← Chart 05](05_net_revenue_by_weekday_and_hour.md) · [Chart index](../README.md) · [Chart 07 →](07_customer_revenue_concentration_curve.md)
