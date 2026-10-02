# Notebook: `istanbul_analysis.ipynb`

Back to the [main README](../README.md) · Notebook: **[istanbul_analysis.ipynb](istanbul_analysis.ipynb)** · Data: [dataset/README.md](../dataset/README.md) · Charts: [charts/README.md](../charts/README.md)

## Purpose

Prepare the retail invoice data and answer the five business questions listed in the [main README](../README.md): spending by dimension, category ranking, mall × category revenue, yearly trend, and male vs female spending. It ends with five business insights for AVM management.

## Requirements and how to run

- Python **3.12+** (the notebook uses nested same-type quotes inside f-strings) and pandas **2.1+** (`DataFrame.map`).
- Libraries: pandas, NumPy, Matplotlib, Seaborn, SciPy, Jupyter.
- Run from the `notebook/` folder. The data is read with the relative path `../dataset/customer_shopping_data.csv`.

## Workflow

| Section | What happens | Output |
|---|---|---|
| **Libraries** | Imports pandas, NumPy, Matplotlib, Seaborn, `LogNorm`, `scipy.stats` | n/a |
| **Importing data** | Loads the CSV into `raw`; all work is done on `data = raw.copy()` | Shape: 99,457 × 10 |
| **Data cleaning** | Lowercases column names and text values. Checks missing values, duplicates, unique IDs, value ranges and extra spaces | No missing values, no duplicates, no extra spaces |
| **Price tests** | Checks that `price` is fixed per quantity within a category and derives `unit_price` | One unit price per category, so `price` is already the invoice total |
| **Analysis: preparation** | Parses `invoice_date` (day first), creates `year`, `month`, `year_month`, `revenue` and `age_group`, defines total revenue and the date range | Data from 2021-01-01 to 2023-03-08 |
| **1. Spending** | Total revenue, average purchase, invoice count and revenue share by category, mall, payment method and gender | Chart 01 |
| **2. Average purchase per category** | Ranks categories by revenue and by invoice count, with cumulative share | Chart 02 |
| **3. Shopping mall vs category** | Pivot table of revenue (with totals), log-scale heatmap, and each mall's category mix in % | Chart 03 |
| **4. Yearly revenue** | Revenue by category and year, change 2021 → 2022, like-for-like comparison of 1 Jan – 8 Mar across three years, monthly trend | Charts 04, 05 |
| **5. Male vs female** | Revenue, average purchase and invoice count by category and gender; category mix; Welch t-test per category | Chart 06 |
| **6. Insights** | Five insights, each with FACT, ACTION and CONFIDENCE | See [main README](../README.md#five-actionable-business-insights-for-avm-management) |

## Methods worth knowing

- **Revenue.** `revenue = price`. Do not multiply by `quantity`.
- **Partial 2023.** 2023 stops on 8 March, so year-over-year comparisons use full years (2021 vs 2022) or the same 1 Jan – 8 Mar window. March 2023 is blanked in the monthly chart.
- **Statistical test.** Welch t-test (`equal_var=False`, because the groups have different sizes) for female vs male invoice amount in each of the 8 categories. Eight tests are run, so the significance limit is Bonferroni-adjusted: 0.05 / 8 = 0.00625.
- **Mall mix.** Each mall's revenue is divided by its own total to compare category mix independently of mall size. No statistical test is applied to it.
- **Unused column.** `age_group` is created but not analysed in this notebook.

## Key conclusions

Summary only; details and charts are in the other READMEs.

- Three categories generate 94.8% of revenue.
- Malls differ in size (invoice count), not in category mix or average invoice.
- Revenue is flat from 2021 to 2022 (+0.18%); early 2023 is +4.3% vs the same window in 2022.
- Gender and payment method do not change the average invoice; women have more invoices, not higher spending.

## Notes

- The notebook contains saved outputs, so it can be read on GitHub without running it.
- The PNG files in [charts/](../charts/README.md) are the notebook's figures exported at 200 dpi (`plt.savefig(..., dpi=200, bbox_inches='tight')`).

