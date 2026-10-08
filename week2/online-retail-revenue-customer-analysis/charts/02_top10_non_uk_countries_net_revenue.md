# Chart 02 — Top 10 Non-UK Countries by Net Revenue

[← Chart 01](01_monthly_net_revenue_and_orders.md) · [Chart index](../README.md) · [Chart 03 →](03_top10_products_net_revenue.md)

![Top 10 Non-UK Countries by Net Revenue](../png/02_top10_non_uk_countries_net_revenue.png)

| | |
|---|---|
| **Chart file** | [`02_top10_non_uk_countries_net_revenue.png`](../png/02_top10_non_uk_countries_net_revenue.png) |
| **Chart type** | Horizontal bar chart, coloured by number of identified customers |
| **Notebook section** | 2.3 Revenue by country ([`Revenue_Analysis.ipynb`](../../notebooks/Revenue_Analysis.ipynb)) |
| **Related documents** | [Insights and Results](../../INSIGHTS_AND_RESULTS.md) · [Notebook README](../../notebooks/README.md) · [Dataset README](../../data/README.md) |

## What the chart shows
The ten non-UK countries with the highest net revenue. Bar length is net revenue (GBP); colour shows the number of identified customers (`customer_id` present) in that country.

## Data and method
- Net revenue by `country` on the cleaned data (sales + returns).
- **Revenue per customer** uses revenue from identified customers only, divided by the number of identified customers in the country.
- The UK is excluded from the chart so the foreign markets are readable; it is reported in the table below.

## Numbers behind the chart
| Country | Net revenue | Identified customers | Revenue per customer |
|---|---:|---:|---:|
| *United Kingdom (not in chart)* | *8,281,390.4* | *3,942* | *1,725.7* |
| Netherlands | 283,479.5 | 9 | 31,497.7 |
| EIRE | 259,380.0 | 3 | 82,244.2 |
| Germany | 200,619.7 | 95 | 2,111.8 |
| France | 182,076.6 | 87 | 2,084.9 |
| Australia | 136,922.5 | 9 | 15,213.6 |
| Switzerland | 52,483.0 | 21 | 2,469.5 |
| Spain | 51,746.6 | 30 | 1,724.9 |
| Belgium | 36,663.0 | 25 | 1,466.5 |
| Japan | 35,419.8 | 8 | 4,427.5 |
| Sweden | 35,166.4 | 8 | n/a in notebook output |

## Key findings
- The **UK brings 84.8%** of net revenue; the **top 10 foreign countries together bring 13.0%**.
- **Netherlands** has 9 customers but **31,498 per customer vs 1,726 in the UK (18x)**.
- EIRE (3 customers, 82,244 per customer) and Australia (9 customers, 15,214 per customer) show the same pattern.
- **Germany** (95 customers, 2,112) and **France** (87 customers, 2,085) look like the UK in value per customer.

## Analytical and business meaning
Netherlands, EIRE and Australia revenue rests on a **handful of large accounts**, while Germany and France are **broad, UK-like markets**. Losing a single account abroad would move a country's figure materially. See [Insights and Results](../../INSIGHTS_AND_RESULTS.md#2-the-business-is-uk-centred-but-not-uk-only).

## Caveats
- Countries with fewer than 10 customers (e.g. EIRE with 3) should not be ranked on per-customer values.
- Revenue per customer excludes anonymous lines (no `customer_id`).

---
[← Chart 01](01_monthly_net_revenue_and_orders.md) · [Chart index](../README.md) · [Chart 03 →](03_top10_products_net_revenue.md)
