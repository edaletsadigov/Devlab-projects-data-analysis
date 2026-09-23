# Dataset: Supermarket Sales

A detailed description of the dataset used in this project.

- **File:** [`supermarket_sales - Sheet1.csv`](/week1/Supermarket_analysis/dataset/supermarket_sales - Sheet1.csv)
- **Size:** 1,000 rows × 17 columns (about 131 KB)
- **Period:** 1 January 2019 – 30 March 2019 (89 consecutive days, every day present)
- **Granularity:** one row = one invoice (a single product line, unit price and quantity per invoice)
- **Locations:** 3 branches in 3 cities of Myanmar
- **Source:** the widely circulated public *Supermarket sales* dataset (Kaggle). *Add the exact source URL and license here before publishing.*

---

## 1. Contents at a glance

| Item | Value |
|---|---|
| Invoices | 1,000 (all `Invoice ID`s unique) |
| Total sales (`Total`) | 322,966.75 |
| Total cost of goods (`cogs`) | 307,587.38 |
| Total tax (`Tax 5%`) | 15,379.37 |
| Average invoice (`Total`) | 322.97 (median 253.85) |
| Missing values | 0 |
| Duplicate rows | 0 |
| Opening hours observed | 10:00 – 20:59 |
| Currency | **Not stated** in the file |

---

## 2. Data dictionary

| # | Column | Type | Description | Values / range |
|---|---|---|---|---|
| 1 | `Invoice ID` | text | Unique invoice identifier | Pattern `NNN-NN-NNNN`, 1,000 unique values |
| 2 | `Branch` | category | Supermarket branch | `A`, `B`, `C` |
| 3 | `City` | category | City of the branch | `Yangon`, `Mandalay`, `Naypyitaw` |
| 4 | `Customer type` | category | Loyalty status of the buyer | `Member`, `Normal` |
| 5 | `Gender` | category | Gender of the buyer | `Female`, `Male` |
| 6 | `Product line` | category | Product category of the invoice | 6 categories (see below) |
| 7 | `Unit price` | decimal | Price of one unit | 10.08 – 99.96 |
| 8 | `Quantity` | integer | Units bought | 1 – 10 |
| 9 | `Tax 5%` | decimal | 5% tax on the goods value | 0.5085 – 49.65 |
| 10 | `Total` | decimal | Invoice total including tax | 10.6785 – 1,042.65 |
| 11 | `Date` | text | Invoice date, format `M/D/YYYY` | 1/1/2019 – 3/30/2019 |
| 12 | `Time` | text | Invoice time, 24-hour `HH:MM` | 10:00 – 20:59 |
| 13 | `Payment` | category | Payment method | `Cash`, `Ewallet`, `Credit card` |
| 14 | `cogs` | decimal | "Cost of goods sold" | 10.17 – 993.00 |
| 15 | `gross margin percentage` | decimal | Margin percentage | Constant: 4.761905 |
| 16 | `gross income` | decimal | "Gross income" | 0.5085 – 49.65 |
| 17 | `Rating` | decimal | Customer satisfaction rating | 4.0 – 10.0 (one decimal) |

---

## 3. Category distributions

| Column | Value | Invoices | Share |
|---|---|---:|---:|
| `Branch` / `City` | A / Yangon | 340 | 34.0% |
| | B / Mandalay | 332 | 33.2% |
| | C / Naypyitaw | 328 | 32.8% |
| `Customer type` | Member | 501 | 50.1% |
| | Normal | 499 | 49.9% |
| `Gender` | Female | 501 | 50.1% |
| | Male | 499 | 49.9% |
| `Product line` | Fashion accessories | 178 | 17.8% |
| | Food and beverages | 174 | 17.4% |
| | Electronic accessories | 170 | 17.0% |
| | Sports and travel | 166 | 16.6% |
| | Home and lifestyle | 160 | 16.0% |
| | Health and beauty | 152 | 15.2% |
| `Payment` | Ewallet | 345 | 34.5% |
| | Cash | 344 | 34.4% |
| | Credit card | 311 | 31.1% |

---

## 4. Numeric summary

| Column | Mean | Median | Std | Min | Max |
|---|---:|---:|---:|---:|---:|
| `Unit price` | 55.67 | 55.23 | 26.49 | 10.08 | 99.96 |
| `Quantity` | 5.51 | 5 | 2.92 | 1 | 10 |
| `Tax 5%` | 15.38 | 12.09 | 11.71 | 0.51 | 49.65 |
| `Total` | 322.97 | 253.85 | 245.89 | 10.68 | 1,042.65 |
| `cogs` | 307.59 | 241.76 | 234.18 | 10.17 | 993.00 |
| `gross income` | 15.38 | 12.09 | 11.71 | 0.51 | 49.65 |
| `Rating` | 6.97 | 7.0 | 1.72 | 4.0 | 10.0 |

`Total`, `cogs` and `Tax 5%` are right-skewed (mean above median), and `Total` is not normally distributed (Shapiro-Wilk p < 0.001).

---

## 5. Built-in relationships between columns

These identities hold in **every one of the 1,000 rows**:

```
cogs                    = Unit price × Quantity
Tax 5%                  = 0.05 × cogs
Total                   = cogs + Tax 5%   (= 1.05 × cogs)
gross income            = Tax 5%
gross margin percentage = Tax 5% / Total × 100 = 4.761905   (constant)
```

Consequences for analysis:

1. **`gross income` is the tax amount, not profit.** The file contains no real cost data, so profitability cannot be analysed. Rankings by `gross income` are identical to rankings by `Total`.
2. **`gross margin percentage` has zero variance**, so it carries no information and should not be used for grouping or comparison.
3. **`Total`, `cogs`, `Tax 5%` and `gross income` are perfectly correlated** (r = 1.00). Use only one of them in any model or correlation study.
4. **Correlations between `Unit price`, `Quantity` and `Total` are arithmetic**, not behavioural findings.

---

## 6. Data quality

| Check | Result |
|---|---|
| Missing values | None in any column |
| Fully duplicated rows | 0 |
| Duplicate `Invoice ID` | 0 |
| `Date` parses as `M/D/YYYY` | Yes, all rows |
| `Time` within opening hours | 10:00 – 20:59 |
| Outliers in `Total` (IQR rule) | 9 rows (0.90%), all on the high side; upper fence 991.74 |

The dataset is clean and needs no imputation or row removal.

---

## 7. Limitations and things to keep in mind

- **Invoice level, no customer ID.** Customer-level questions (repeat purchases, retention, lifetime value) cannot be answered. "Member share" means share of invoices.
- **One product line per invoice.** Each invoice has a single unit price and quantity, so this is not a market-basket dataset.
- **`Branch` and `City` are redundant** (A = Yangon, B = Mandalay, C = Naypyitaw), so branch effects and city effects cannot be separated.
- **No currency is given.** The notebook and charts use `$` as an assumption.
- **Short window.** 89 days in one season: no year-over-year comparison and no reliable seasonality.
- **The data looks synthetic.** `Unit price` is spread evenly between about 10 and 100, each `Quantity` from 1 to 10 occurs 85–119 times, and `Rating` is spread evenly between 4 and 10. Almost every segment comparison is statistically indistinguishable. This pattern is typical of simulated data rather than real till data, so results should be presented as a demonstration of method, not as evidence about a real business.

---

## 8. Columns added in the notebook

| Column | Derived from | Meaning |
|---|---|---|
| `hour` | `time` | Hour of day (10–20) |
| `month` | `date` | Month number (1–3) |
| `dayofweek` | `date` | Lower-case weekday name |
| `weekend` | `dayofweek` | `True` for Saturday and Sunday |

The notebook also renames all columns to `snake_case` (for example `Customer type` → `customer_type`, `Tax 5%` → `tax_5%`).

---

## 9. Loading the data

```python
import pandas as pd

df = pd.read_csv("supermarket_sales - Sheet1.csv")
df.columns = df.columns.str.lower().str.replace(" ", "_")
df["date"] = pd.to_datetime(df["date"], format="%m/%d/%Y")
df["hour"] = pd.to_datetime(df["time"], format="%H:%M").dt.hour

print(df.shape)  # (1000, 18)
```

---

## 10. Questions this dataset can and cannot answer

| Can answer | Cannot answer |
|---|---|
| Sales and average invoice by branch, product line, customer type, gender, payment method | Customer retention, repeat purchase, lifetime value |
| Hourly, daily and weekly sales patterns within Q1 2019 | Year-over-year growth or annual seasonality |
| Relationships between price, quantity and rating | True profitability (no real cost data) |
| Whether segment differences are statistically distinguishable | Causes of any difference (observational data only) |

---

## License and attribution

Check the license of the original dataset source and add it here. If you redistribute the CSV in your repository, keep the original attribution.

