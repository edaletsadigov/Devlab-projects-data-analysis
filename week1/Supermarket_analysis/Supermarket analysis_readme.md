# Charts

This folder contains the five interactive Plotly charts from the analysis notebook, exported as static PNG images so they can be viewed directly on GitHub.

> **Source:** [`Supermarket_Ədalət_Sadıqov.ipynb`](../Supermarket_%C6%8Fdal%C9%99t_Sad%C4%B1qov.ipynb) · **Data:** [`supermarket_sales - Sheet1.csv`](../supermarket_sales%20-%20Sheet1.csv) ([dataset documentation](../docs/DATASET_README.md))
>
> **Note on currency:** the dataset does not state a currency. The charts label sales with `$`, which is an assumption made in the notebook.

## Index

| # | Chart | Type | File |
|---|-------|------|------|
| 1 | [Total Sales by Product Line](#1-total-sales-by-product-line) | Horizontal bar | [`01_total_sales_by_product_line.png`](01_total_sales_by_product_line.png) |
| 2 | [Customer Type Distribution](#2-customer-type-distribution) | Donut | [`02_customer_type_distribution.png`](02_customer_type_distribution.png) |
| 3 | [Total Sales by Hour of Day](#3-total-sales-by-hour-of-day) | Line with markers | [`03_total_sales_by_hour.png`](03_total_sales_by_hour.png) |
| 4 | [Total Sales by Branch and Product Line](#4-total-sales-by-branch-and-product-line) | Heatmap | [`04_sales_heatmap_branch_product.png`](04_sales_heatmap_branch_product.png) |
| 5 | [Correlation Heatmap](#5-correlation-heatmap) | Heatmap | [`05_correlation_heatmap.png`](05_correlation_heatmap.png) |

---

## 1. Total Sales by Product Line

![Total Sales by Product Line](01_total_sales_by_product_line.png)

[Open full size](01_total_sales_by_product_line.png)

**What it shows.** Total sales (sum of the `total` column) for each of the six product lines, sorted from highest to lowest. Darker bars mean higher sales.

**How to read it.** Each bar's length is the product line's total sales; the number at the end of the bar is the exact value.

| Product line | Total sales | Share of all sales | Orders |
|---|---:|---:|---:|
| Food and beverages | 56,144.84 | 17.4% | 174 |
| Sports and travel | 55,122.83 | 17.1% | 166 |
| Electronic accessories | 54,337.53 | 16.8% | 170 |
| Fashion accessories | 54,305.90 | 16.8% | 178 |
| Home and lifestyle | 53,861.91 | 16.7% | 160 |
| Health and beauty | 49,193.74 | 15.2% | 152 |

**Takeaway.** Sales are spread evenly across the six lines: the top-to-bottom gap is 6,951.10 (14.1% of the lowest line), and the top five lines are within about 4% of each other.

**Worth knowing.**
- Health and beauty is lowest because it has the fewest orders (152 vs 160–178 elsewhere), not because its orders are smaller: its average order value (323.64) is close to the overall average (322.97).
- The notebook does not test whether the differences between product lines are statistically significant, so treat the ranking as descriptive.

---

## 2. Customer Type Distribution

![Customer Type Distribution](02_customer_type_distribution.png)

[Open full size](02_customer_type_distribution.png)

**What it shows.** The share of invoices made by `Member` and `Normal` customers.

**How to read it.** Each slice's label gives the customer type and its percentage of all 1,000 invoices.

| Customer type | Invoices | Share |
|---|---:|---:|
| Member | 501 | 50.1% |
| Normal | 499 | 49.9% |

**Takeaway.** The split is almost exactly 50/50, so roughly half of all transactions come from customers who are not members.

**Worth knowing.**
- The dataset has no customer ID, so these are shares of *invoices*, not of *customers*.
- Members do not spend significantly more per invoice (average 327.79 vs 318.12; t-test p = 0.5344, Mann-Whitney p = 0.5912).

---

## 3. Total Sales by Hour of Day

![Total Sales by Hour of Day](03_total_sales_by_hour.png)

[Open full size](03_total_sales_by_hour.png)

**What it shows.** Total sales for each opening hour (10:00–20:59), summed across all 89 days. The `hour` value is extracted from the `time` column.

**How to read it.** The x-axis is the hour the invoice was issued (10 means 10:00–10:59); the y-axis is total sales in that hour across the whole period.

| Hour | Total sales | Orders |
|---|---:|---:|
| **19** (highest) | 39,699.51 | 113 |
| 13 | 34,723.23 | 103 |
| 10 | 31,421.48 | 101 |
| 15 | 31,179.51 | 102 |
| 14 | 30,828.40 | 83 |
| 11 | 30,377.33 | 90 |
| 12 | 26,065.88 | 89 |
| 18 | 26,030.34 | 93 |
| 16 | 25,226.32 | 77 |
| 17 | 24,445.22 | 74 |
| **20** (lowest) | 22,969.53 | 75 |

**Takeaway.** Sales peak at 19:00, with a second, smaller peak at 13:00; the weakest hours are 16:00–17:00 and 20:00.

**Worth knowing.**
- The y-axis starts at about 22,000, not at zero, which makes the 19:00 peak look larger than it is. In reality 19:00 is roughly 35% above the average hour (29,361).
- The notebook does not test whether the hourly differences are statistically significant. Use the pattern as a hypothesis for staffing or promotion timing, not as a confirmed result.

---

## 4. Total Sales by Branch and Product Line

![Total Sales by Branch and Product Line](04_sales_heatmap_branch_product.png)

[Open full size](04_sales_heatmap_branch_product.png)

**What it shows.** Total sales for every branch × product line combination (3 × 6 = 18 cells). Darker cells mean higher sales.

**How to read it.** Rows are branches (A = Yangon, B = Mandalay, C = Naypyitaw); columns are product lines; each cell shows the sales total.

| Branch | Electronic | Fashion | Food & bev. | Health & beauty | Home & lifestyle | Sports & travel | Branch total |
|---|---:|---:|---:|---:|---:|---:|---:|
| A | 18,317.11 | 16,332.51 | 17,163.10 | 12,597.75 | **22,417.20** | 19,372.70 | 106,200.37 |
| B | 17,051.44 | 16,413.32 | 15,214.89 | **19,980.66** | 17,549.16 | **19,988.20** | 106,197.67 |
| C | **18,968.97** | **21,560.07** | **23,766.85** | 16,615.33 | 13,895.55 | 15,761.93 | 110,568.71 |

Bold marks the leading branch for each product line.

**Takeaway.** No branch dominates: each one leads in different product lines (C in Electronic, Fashion and Food; B in Health and Sports; A in Home).

**Worth knowing.**
- The chi-square test of Branch × Product line shows no significant association (χ² = 11.56, p = 0.3156), so these cell differences are most likely random variation rather than real branch preferences.
- In this dataset `branch` and `city` map one-to-one, so a branch effect cannot be separated from a city effect.

---

## 5. Correlation Heatmap

![Correlation Heatmap](05_correlation_heatmap.png)

[Open full size](05_correlation_heatmap.png)

**What it shows.** Pearson correlation coefficients between the six numeric columns: `unit_price`, `quantity`, `total`, `cogs`, `gross_income` and `rating`.

**How to read it.** Values run from −1 (perfect negative) to +1 (perfect positive); red is positive, blue is negative, near-white is no linear relationship.

| Pair | r | Interpretation |
|---|---:|---|
| `total` / `cogs` / `gross_income` | 1.00 | Identical by construction (see below) |
| `quantity` – `total` | 0.71 | Expected: total is price × quantity × 1.05 |
| `unit_price` – `total` | 0.63 | Expected for the same reason |
| `unit_price` – `quantity` | 0.01 | Customers do not buy more of cheaper items |
| `rating` – everything else | −0.04 to −0.01 | No linear relationship |

**Takeaway.** The strong correlations are arithmetic, not findings; the only informative result is that customer `rating` is unrelated to anything else in the data (`total` vs `rating`: r = −0.0364, p = 0.2496).

**Worth knowing.**
- `cogs` = `unit_price` × `quantity`, `tax_5%` = 5% of `cogs`, `total` = `cogs` + `tax_5%`, and `gross_income` equals `tax_5%` in every row, which is why those columns move together perfectly.
- Correlation describes association, not causation.

---

## How these images were produced

The charts were built with Plotly Express in the notebook. The figures were extracted from the notebook's saved outputs and exported to PNG (2,200 px wide). The data and design are unchanged; the only edit is on chart 1, where the value labels were prevented from being clipped at the plot edge.

