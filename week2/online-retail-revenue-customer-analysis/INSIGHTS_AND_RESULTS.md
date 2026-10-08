# Insights and Results

[← Project README](README.md) · [Notebook README](notebooks/README.md) · [Dataset README](data/README.md) · [Chart index](charts/README.md)

Summary of the most important findings of [`Revenue_Analysis.ipynb`](notebooks/Revenue_Analysis.ipynb): revenue patterns, customer behaviour, statistical results and the business actions they support. Every figure comes from the executed notebook; each insight links to the chart that shows it.

## Headline numbers

| Metric | Value | Context |
|---|---:|---|
| Net revenue | **9,771,318** | 13 months, Dec 2010 - 9 Dec 2011 (GBP assumed) |
| Gross sales / returns | 10,001,566 / -230,248 | Returns are **2.3%** of gross value (4.6% if two reversed orders were included) |
| Orders (invoices) | 19,771 | Excludes the two fully reversed orders |
| Identified customers | 4,333 | 4,320 analysed after removing 13 with net revenue <= 0 |
| Order value, mean / median | 506 / 302 | Mean is 1.67x the median: a few very large orders |
| Anonymous lines | 24.8% of lines, 15.4% of net revenue | No `customer_id`; excluded from customer-level analysis |

## 1. Revenue is large and seasonal

![Monthly Net Revenue and Order Count](charts/png/01_monthly_net_revenue_and_orders.png)

- Net revenue is flat to slowly rising from Dec 2010 to Aug 2011 (**482k-758k a month**), then climbs: Sep **1.01M**, Oct **1.06M**, **Nov 1.43M** ([Chart 01](charts/readmes/01_monthly_net_revenue_and_orders.md)).
- **Nov 2011 is 2.25x the Jan-Aug average**; **Sep-Nov hold 37.5%** of the 12 complete months.
- The peak is **order volume**: Nov has **2.03x the orders** of an average Jan-Aug month but only **1.10x the net revenue per order**.
- Like-for-like 1-9 Dec: 401,142 (2010) vs 440,400 (2011), **+9.8%** - an indicative hint only, based on one year of history.

**Meaning:** the autumn peak stresses capacity (stock, picking, staffing) rather than basket size.

## 2. The business is UK-centred but not UK-only

![Top 10 Non-UK Countries by Net Revenue](charts/png/02_top10_non_uk_countries_net_revenue.png)

- The UK brings **84.8%** of net revenue; the top 10 foreign countries together bring **13.0%** ([Chart 02](charts/readmes/02_top10_non_uk_countries_net_revenue.md)).
- Netherlands (9 customers) has **31,498 per customer vs 1,726 in the UK (18x)**; EIRE (3 customers) 82,244; Australia (9 customers) 15,214.
- Germany (95 customers, 2,112) and France (87 customers, 2,085) look like the UK.
- Non-UK customers are **9.6%** of customers (415) and **17.7%** of net revenue; median order value is higher (**388 vs 279**) and mean net revenue per customer is about twice the UK (3,526 vs 1,743), while repeat rate is almost the same (64.1% vs 65.6%).

**Meaning:** Netherlands, EIRE and Australia rest on a handful of large accounts; Germany and France are broad, UK-like markets.

## 3. The catalogue is broad

![Top 10 Products by Net Revenue](charts/png/03_top10_products_net_revenue.png)

![Cumulative Net Revenue Share by Product Rank (Pareto Curve)](charts/png/04_product_pareto_curve.png)

- The **top 10 products make only 8.2%** of net revenue; the leader, `REGENCY CAKESTAND 3 TIER`, makes 1.7% ([Chart 03](charts/readmes/03_top10_products_net_revenue.md)).
- **840 of 3,921 products (21.4%)** make 80% of net revenue, close to an 80/20 Pareto ([Chart 04](charts/readmes/04_product_pareto_curve.md)).
- 19 products have negative net value (more returned than sold within the period).

**Meaning:** no single hit product drives the business; a single product failing would not move total revenue much.

## 4. Customers are heavily concentrated

![Cumulative Net Revenue Share by Customer Rank](charts/png/07_customer_revenue_concentration_curve.png)

- Mean net revenue per customer **1,914** vs median **650** (2.9x, right-skewed).
- The best **10%** of customers bring **60.1%** of net revenue, the best 20% bring **73.7%**, the bottom half only **8.1%** ([Chart 07](charts/readmes/07_customer_revenue_concentration_curve.md)).
- Customers with 10+ orders are 8.9% of the base and **52.5%** of revenue ([Chart 08](charts/readmes/08_customer_vs_revenue_share_by_order_count.md)).

**Meaning:** losing a handful of top accounts would hurt far more than losing many small ones.

## 5. A third of customers never return

![Share of Customers vs Share of Net Revenue by Number of Orders](charts/png/08_customer_vs_revenue_share_by_order_count.png)

![Monthly Cohort Retention Heatmap](charts/png/10_cohort_retention_heatmap.png)

- **65.4%** of customers ordered at least twice; **34.6% buy once** (1,494 customers, 6.5% of revenue) ([Chart 08](charts/readmes/08_customer_vs_revenue_share_by_order_count.md)).
- Average cohort retention is **21.3% in month 1, 24.6% in month 3 and 26.9% in month 6**: it drops after month 1 and then stays roughly flat ([Chart 10](charts/readmes/10_cohort_retention_heatmap.md)).
- Cohorts after Dec 2010 stay at **15-24%** in month 1. The Dec 2010 cohort (884 customers) keeps 50.2% at month 11, but part of it is existing customers.
- **Calendar effect:** Nov 2011 shows **30.5%** average retention vs **25.3%** for the same cohorts in other months, so part of older cohorts' apparent loyalty is the seasonal peak, not customer age.

**Meaning:** the first-to-second-order step is where about a third of customers stop, and the single-month return rate of new customers is the number to improve.

## 6. About 785k of revenue is in customers who went quiet

![RFM Segments: Recency vs Frequency](charts/png/09_rfm_segments_bubble_chart.png)

| Segment | Customers | Customer share | Revenue share | Avg recency (days) | Avg orders |
|---|---:|---:|---:|---:|---:|
| Champions | 1,109 | 25.7% | 67.9% | 12.9 | 10.1 |
| Can't Lose Them | 297 | 6.9% | 5.9% | 133.6 | 4.8 |
| At Risk | 363 | 8.4% | 3.6% | 162.9 | 2.3 |
| Hibernating | 1,068 | 24.7% | 5.0% | 217.7 | 1.1 |

- Champions + `Can't Lose Them` = **32.5% of customers and 73.8% of net revenue** ([Chart 09](charts/readmes/09_rfm_segments_bubble_chart.md)).
- `Can't Lose Them` + `At Risk` are **15.3% of customers and 9.5% of net revenue (about 785k)** with 134-163 days since the last order.
- `New Customers` and `Potential Loyalists` are small (3.1% and 4.2% of customers): the pipeline of new buyers is thin at the snapshot date.

**Meaning:** the win-back opportunity sits in `Can't Lose Them` and `At Risk`.

## 7. Country group does not explain loyalty, but it does explain order size

- **AOV (Mann-Whitney U):** non-UK customers have a higher AOV distribution (median 388 vs 279, p = 3.75e-22, rank-biserial effect -0.29); a random non-UK customer has the higher AOV in roughly 64% of pairs. This is an association by country group, not a cause.
- **Repeat purchase (chi-square):** 64.1% (non-UK) vs 65.6% (UK), p = 0.589, Cramer's V = 0.008 (negligible).

### Statistical tests

| Test | H0 | Key numbers | Decision (alpha = 0.05) |
|---|---|---|---|
| Mann-Whitney U on customer AOV | Same AOV distribution for UK and non-UK | n = 3,905 UK / 415 non-UK; U = 576,506; p = 3.75e-22; effect -0.289 | **Reject H0** |
| Chi-square, repeat x country group | Repeat purchase independent of UK / non-UK | chi-square = 0.29, dof = 1, p = 0.589; V = 0.008 | **Fail to reject H0** |

With 4,320 customers the p-value is tiny for almost any difference, so the **effect size** is the number that matters. Spearman correlations ([Chart 11](charts/readmes/11_spearman_correlation_heatmap.md)):

![Spearman Correlation Between Customer Metrics](charts/png/11_spearman_correlation_heatmap.png)

- Orders vs net revenue **+0.81**; products vs net revenue **+0.73**; recency vs orders **-0.56**; AOV vs orders **+0.16**.
- **Order frequency, not basket size, separates high-value customers.** These are associations, not causes: orders and net revenue are linked by construction.

## 8. Data quality shapes the numbers

![Net Revenue by Weekday and by Hour of Day](charts/png/05_net_revenue_by_weekday_and_hour.png)

![Monthly Return Rate by Value](charts/png/06_monthly_return_rate.png)

- **24.8%** of lines (**15.4%** of net revenue) have no `customer_id`.
- Two orders (customers `12346`: 77,184 and `16446`: 168,470) were cancelled within minutes; they would have added 245,653 to gross sales and doubled the apparent return rate (**4.6% vs 2.3%**).
- Monthly return rate ranges **1.2%-6.5%** (peak Apr 2011); the 8 largest returned products carry only **18.8%** of returned value ([Chart 06](charts/readmes/06_monthly_return_rate.md)). Standouts on rate: `PANTRY CHOPPING BOARD` 81.8%, `FAIRY CAKE FLANNEL ASSORTED COLOUR` 36.5%, `TEA TIME PARTY BUNTING` 32.8%.
- Trade is a **weekday-daytime pattern**: 10:00-15:59 holds **75.6%** of net revenue, Thursday **21.3%**, Sunday **8.1%**, no Saturday transactions ([Chart 05](charts/readmes/05_net_revenue_by_weekday_and_hour.md)).

## Interpretation and assumptions

- **[INTERPRETATION]** The weekday-daytime pattern and the large per-customer values abroad suggest many customers are businesses or resellers (the data has no customer-type field).
- **[ASSUMPTION]** Currency is GBP (not stated in the file). Duplicate lines are treated as export errors.
- **[INTERPRETATION]** The Sep-Nov rise is seasonal, but with one year of data seasonality cannot be separated from growth.

## Business recommendations

| Theme | Recommendation | Basis |
|---|---|---|
| **Retention** | Protect Champions (1,109 customers, 67.9% of revenue): account owner, early access to seasonal ranges, a service-level check before November. | [Chart 09](charts/readmes/09_rfm_segments_bubble_chart.md) |
| | Run a **win-back test** on `Can't Lose Them` and `At Risk` (660 customers, about 785k net revenue) with a **control group**, because the data cannot show that an offer would cause a return. | [Chart 09](charts/readmes/09_rfm_segments_bubble_chart.md) |
| | Test a **second-order trigger** for one-time buyers (1,494 customers): a timed message or offer inside the first 30 days, since month-1 retention is about 20%. | [Chart 08](charts/readmes/08_customer_vs_revenue_share_by_order_count.md), [Chart 10](charts/readmes/10_cohort_retention_heatmap.md) |
| **Seasonal operations** | Build stock and staffing plans around **Sep-Nov (37.5% of the year)** and weekday daytime; Sunday carries 8.1% of revenue and Saturday none. | [Chart 01](charts/readmes/01_monthly_net_revenue_and_orders.md), [Chart 05](charts/readmes/05_net_revenue_by_weekday_and_hour.md) |
| **International** | Assign account management to Netherlands, EIRE and Australia (3-9 accounts each). Treat Germany and France as the scalable markets (95 and 87 customers at UK-like value per customer). | [Chart 02](charts/readmes/02_top10_non_uk_countries_net_revenue.md) |
| **Returns and data** | Review products with extreme return rates (`PANTRY CHOPPING BOARD` 81.8%, `FAIRY CAKE FLANNEL` 36.5%) for listing or quality problems, and record a return reason. | [Chart 06](charts/readmes/06_monthly_return_rate.md) |
| | Capture `customer_id` at checkout (24.8% of lines are anonymous) and add an alert for single orders above about 50,000 units. | [Notebook cleaning](notebooks/README.md#1-data-overview-and-cleaning) |

## Limitations

- **Period:** 13 months, one season, Dec 2011 partial. No second year for year-over-year comparison.
- **Left-censored cohorts:** customers whose first order is in Dec 2010 may be older customers, so the Dec 2010 cohort mixes new and existing buyers.
- **Revenue, not profit:** no cost, margin or discount data, so segment value is revenue value only.
- **Missing identity:** 24.8% of lines have no `customer_id`; customer-level results describe the identified 75% of lines (84.6% of net revenue).
- **RFM scoring:** `ordinal` rank breaks ties by row order, so customers with identical orders can fall into neighbouring score bins; segment sizes are approximate.
- **Returns:** a cancellation is dated at the return, not the original sale, and has no reason, so product-level return rates are indicative.
- **Association, not causation:** every comparison is observational, and the effects of any recommended action need a controlled test.

## Chart index

| # | Chart | PNG |
|---|---|---|
| 01 | [Monthly Net Revenue and Order Count](charts/readmes/01_monthly_net_revenue_and_orders.md) | [`01_monthly_net_revenue_and_orders.png`](charts/png/01_monthly_net_revenue_and_orders.png) |
| 02 | [Top 10 Non-UK Countries by Net Revenue](charts/readmes/02_top10_non_uk_countries_net_revenue.md) | [`02_top10_non_uk_countries_net_revenue.png`](charts/png/02_top10_non_uk_countries_net_revenue.png) |
| 03 | [Top 10 Products by Net Revenue](charts/readmes/03_top10_products_net_revenue.md) | [`03_top10_products_net_revenue.png`](charts/png/03_top10_products_net_revenue.png) |
| 04 | [Cumulative Net Revenue Share by Product Rank (Pareto Curve)](charts/readmes/04_product_pareto_curve.md) | [`04_product_pareto_curve.png`](charts/png/04_product_pareto_curve.png) |
| 05 | [Net Revenue by Weekday and by Hour of Day](charts/readmes/05_net_revenue_by_weekday_and_hour.md) | [`05_net_revenue_by_weekday_and_hour.png`](charts/png/05_net_revenue_by_weekday_and_hour.png) |
| 06 | [Monthly Return Rate by Value](charts/readmes/06_monthly_return_rate.md) | [`06_monthly_return_rate.png`](charts/png/06_monthly_return_rate.png) |
| 07 | [Cumulative Net Revenue Share by Customer Rank](charts/readmes/07_customer_revenue_concentration_curve.md) | [`07_customer_revenue_concentration_curve.png`](charts/png/07_customer_revenue_concentration_curve.png) |
| 08 | [Share of Customers vs Share of Net Revenue by Number of Orders](charts/readmes/08_customer_vs_revenue_share_by_order_count.md) | [`08_customer_vs_revenue_share_by_order_count.png`](charts/png/08_customer_vs_revenue_share_by_order_count.png) |
| 09 | [RFM Segments: Recency vs Frequency](charts/readmes/09_rfm_segments_bubble_chart.md) | [`09_rfm_segments_bubble_chart.png`](charts/png/09_rfm_segments_bubble_chart.png) |
| 10 | [Monthly Cohort Retention Heatmap](charts/readmes/10_cohort_retention_heatmap.md) | [`10_cohort_retention_heatmap.png`](charts/png/10_cohort_retention_heatmap.png) |
| 11 | [Spearman Correlation Between Customer Metrics](charts/readmes/11_spearman_correlation_heatmap.md) | [`11_spearman_correlation_heatmap.png`](charts/png/11_spearman_correlation_heatmap.png) |
