# Chart 03 — Top 10 Products by Net Revenue

[← Chart 02](02_top10_non_uk_countries_net_revenue.md) · [Chart index](../README.md) · [Chart 04 →](04_product_pareto_curve.md)

![Top 10 Products by Net Revenue](../png/03_top10_products_net_revenue.png)

| | |
|---|---|
| **Chart file** | [`03_top10_products_net_revenue.png`](../png/03_top10_products_net_revenue.png) |
| **Chart type** | Horizontal bar chart |
| **Notebook section** | 2.4 Products ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
The ten products with the highest net revenue (GBP). Product labels are the most frequent description per `stock_code`, truncated to 30 characters in the chart.

## Data and method
- Net revenue and net units per `stock_code` on the cleaned data (non-product codes such as postage and fees are removed).
- 3,921 products were sold; 19 have negative net value (more returned than sold within the period).

## Numbers behind the chart
| Rank | Product | Net revenue |
|---:|---|---:|
| 1 | REGENCY CAKESTAND 3 TIER | 164,459.5 |
| 2 | PARTY BUNTING | 98,243.9 |
| 3 | WHITE HANGING HEART T-LIGHT HOLDER | 97,838.4 |
| 4 | JUMBO BAG RED RETROSPOT | 92,175.8 |
| 5 | RABBIT NIGHT LIGHT | 66,661.6 |
| 6 | PAPER CHAIN KIT 50'S CHRISTMAS | 63,715.2 |
| 7 | ASSORTED COLOUR BIRD ORNAMENT | 58,792.4 |
| 8 | CHILLI LIGHTS | 53,746.7 |
| 9 | PICNIC BASKET WICKER SMALL | 51,023.5 |
| 10 | POPCORN HOLDER | 50,967.9 |

## Key findings
- The **top 10 products make only 8.2%** of net revenue.
- The leader, `REGENCY CAKESTAND 3 TIER`, makes **1.7%**.

## Analytical and business meaning
There is no single hit product the business depends on: a single product failing would not move total revenue much. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#3-the-catalogue-is-broad) and the cumulative view in [Chart 04](04_product_pareto_curve.md).

## Caveats
- Net revenue includes returns; rankings can differ from gross sales rankings.

---
[← Chart 02](02_top10_non_uk_countries_net_revenue.md) · [Chart index](../README.md) · [Chart 04 →](04_product_pareto_curve.md)
