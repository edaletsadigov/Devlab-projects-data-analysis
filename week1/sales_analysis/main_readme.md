# Sales Data Analysis — Cleaning, Statistics & RFM Customer Segmentation

An end-to-end exploratory data analysis (EDA) and customer segmentation project built on a retail sales transactions dataset. The project covers data cleaning, descriptive statistics, business-driven visual analysis, and an RFM (Recency, Frequency, Monetary) customer segmentation model used to identify high-value customers and churn risk.

## Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Repository Structure](#repository-structure)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [RFM Customer Segmentation](#rfm-customer-segmentation)
- [How to Run](#how-to-run)
- [Tools & Libraries](#tools--libraries)
- [Author](#author)

## Project Overview

The goal of this project is to take a raw, uncleaned sales transactions dataset and turn it into actionable business insight through a complete analytics workflow:

1. **Inspect and clean** the raw data (missing values, data types, duplicates)
2. **Summarize** the dataset with descriptive statistics
3. **Visualize** sales patterns across time, geography, and product lines
4. **Segment customers** using RFM analysis to identify who drives revenue and who is at risk of churning

The analysis intentionally documents its own limitations — where a data gap exists (such as an incomplete year of records) or where a calculation was corrected mid-project, this is called out explicitly rather than glossed over, so that every number in the final conclusion can be trusted.

## Dataset

- **Source:** [Kaggle — Sample Sales Data](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data)
- **File:** `sales_data_sample.csv`
- **Encoding:** `ISO-8859-1` (the file does not load with standard UTF-8 encoding)
- **Size:** 2,823 rows × 25 columns
- **Granularity:** Each row is an **order line item**, not a full order — the dataset contains 307 unique orders (`ORDERNUMBER`) and 92 unique customers (`CUSTOMERNAME`), meaning each order spans roughly 9 line items on average
- **Time range:** 2003–2005. **2005 is an incomplete year** — only January through May are present, which must be accounted for in any year-over-year comparison

### Column Groups

| Group | Columns |
|---|---|
| Order details | `ORDERNUMBER`, `ORDERLINENUMBER`, `ORDERDATE`, `STATUS`, `QTR_ID`, `MONTH_ID`, `YEAR_ID` |
| Sales figures | `QUANTITYORDERED`, `PRICEEACH`, `SALES`, `MSRP`, `DEALSIZE` |
| Product | `PRODUCTLINE`, `PRODUCTCODE` |
| Customer & location | `CUSTOMERNAME`, `PHONE`, `ADDRESSLINE1`, `ADDRESSLINE2`, `CITY`, `STATE`, `POSTALCODE`, `COUNTRY`, `TERRITORY`, `CONTACTLASTNAME`, `CONTACTFIRSTNAME` |

### Missing Values

Missing data is limited to four address-related columns and does not affect the core numeric or categorical analysis:

| Column | Missing Count | Missing % |
|---|---:|---:|
| `ADDRESSLINE2` | 2,521 | 89.3% |
| `STATE` | 1,486 | 52.6% |
| `TERRITORY` | 1,074 | 38.0% |
| `POSTALCODE` | 76 | 2.7% |

All four were filled with the placeholder value `"unknown"` rather than dropped, since dropping rows would have discarded valid sales transactions over an address field.

## Repository Structure

```
.
├── README.md                      <- This file
├── notebooks/
│   └── task1_main_Ədalət.ipynb    <- Full analysis notebook (cleaning → stats → visuals → RFM)
├── data/
│   └── sales_data_sample.csv      <- Raw source dataset
└── charts/
    ├── README.md                  <- Chart-by-chart explanation of every visualization
    ├── 01_sales_distribution.png
    ├── 02_orders_by_year.png
    ├── 03_top5_countries_sales.png
    ├── 04_sales_by_country_productline_top5.png
    ├── 05_sales_by_productline.png
    ├── 06_rfm_segment_overview.png
    └── 07_rfm_scatter_frequency_monetary.png
```

## Methodology

### 1. Data Inspection
Shape, column data types, missing values, duplicate rows, and cardinality (unique value counts per column) were checked before any transformation, to understand the true unit of analysis (order line, not order) and confirm the dataset had no duplicate records.

### 2. Data Cleaning
- Column names standardized to lowercase
- Missing values in `addressline2`, `state`, `postalcode`, `territory` filled with `"unknown"`
- `orderdate` converted from string to `datetime64`
- Duplicate check confirmed: **0 duplicate rows**

### 3. Descriptive Statistics
`describe()` and `value_counts()` were used on the core numeric and categorical columns (`sales`, `status`, `year_id`, `productline`) to establish baseline distributions before deeper analysis.

### 4. Visual & Business Analysis
Sales were analyzed across four dimensions — overall distribution, time (year), geography (country), and product line — using Plotly for interactive exploration during development. See [`charts/README.md`](charts/README.md) for full detail and static exports of every chart.

### 5. RFM Customer Segmentation
Customers were scored on **Recency** (days since last order), **Frequency** (number of unique orders), and **Monetary** (total spend), each split into 5 quantile-based scores (1–5), and mapped into 7 named business segments (Champions, Loyal Customers, At Risk, Hibernating, etc.).

> **Methodological note:** An early version of the RFM scoring step overwrote the raw `recency`/`frequency`/`monetary` columns with their rank values before aggregation, which silently corrupted the revenue and averages reported per segment (e.g. showing "$695" instead of the true ~$4.16M for the Champions segment). This was corrected by computing ranks into separate `_rank` helper columns used only for scoring, while keeping the original values intact for reporting. All figures in this README reflect the corrected calculation.

## Key Findings

| # | Finding |
|---|---|
| 1 | The dataset contains 2,823 order-line rows across 307 unique orders and 92 unique customers |
| 2 | Missing values exist only in 4 address-related columns and do not affect the core analysis |
| 3 | No duplicate rows were found |
| 4 | `SALES` is right-skewed — mean ($3,553.89) is notably higher than the median ($3,184.80), driven by a smaller number of high-value orders |
| 5 | 2005 is an incomplete year (Jan–May only); its lower total sales vs. 2003/2004 is a data coverage artifact, not a real decline |
| 6 | The USA leads all markets with **$3.63M** in sales — roughly 3× the second-largest market, Spain ($1.22M) |
| 7 | **Classic Cars** is the top-selling product line overall ($3.92M), and represents ~33% of total sales within the USA specifically |
| 8 | RFM segmentation shows the **Champions** segment generates **41.5%** of total revenue while representing only 25% of customers |

## RFM Customer Segmentation

| Segment | Customers | Total Revenue | Avg Recency (days) | Avg Frequency (orders) | Revenue Share |
|---|---:|---:|---:|---:|---:|
| **Champions** | 23 | $4,162,105 | 55.6 | 5.3 | **41.5%** |
| Hibernating | 28 | $1,919,521 | 324.3 | 2.0 | 19.1% |
| Potential Loyalists | 14 | $1,125,281 | 73.1 | 2.9 | 11.2% |
| At Risk | 9 | $1,098,652 | 241.2 | 3.3 | 11.0% |
| Loyal Customers | 7 | $880,787 | 173.9 | 3.7 | 8.8% |
| Need Attention | 7 | $560,020 | 185.0 | 3.0 | 5.6% |
| Promising | 4 | $286,262 | 189.0 | 3.0 | 2.9% |

**Business implications:**
- **Champions** are only a quarter of the customer base but drive over 40% of revenue — retention (loyalty perks, early access, dedicated attention) is the highest-leverage action available
- **Hibernating** is the largest single group by customer count (28) and has gone quiet for an average of 324 days — a strong churn signal worth a win-back campaign or a reassessment of continued marketing spend
- **At Risk** customers were previously active (avg. 3.3 orders) but have not ordered in ~241 days on average — a good target for time-limited reactivation offers before they fully churn

## How to Run

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install pandas numpy plotly scipy jupyter
   ```
3. Open the notebook:
   ```bash
   jupyter notebook notebooks/task1_main_Ədalət.ipynb
   ```
4. Run all cells top to bottom (**Kernel → Restart & Run All** is recommended to guarantee clean, reproducible output)

## Tools & Libraries

- **pandas / numpy** — data loading, cleaning, aggregation
- **plotly (express & graph_objects)** — interactive visualizations
- **scipy.stats** — statistical utilities used during analysis
- **matplotlib** — static chart exports for this repository (see `charts/`)

## Author

**Ədalət Sadıqov**
Data Analytics portfolio project — Sales Data Cleaning, EDA & RFM Segmentation

