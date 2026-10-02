# Week 1 — Data Analysis Projects

## Overview

Week 1 of the Devlab internship focused on building a complete, repeatable analytics workflow — data inspection, cleaning, descriptive statistics, exploratory data analysis (EDA), visualization, and (where relevant) statistical hypothesis testing and customer segmentation — and applying it to three independent retail/sales datasets. Each project is self-contained with its own notebook, dataset, charts, and documentation, and each ends with business-oriented findings rather than just exploratory output.

## Projects / Analyses

### 1. Supermarket Sales Analysis

| | |
|---|---|
| **Description** | End-to-end exploratory and statistical analysis of 1,000 supermarket invoices from three branches (Q1 2019). |
| **Dataset** | [`supermarket_sales - Sheet1.csv`](Supermarket_analysis/dataset/supermarket_sales%20-%20Sheet1.csv) — 1,000 rows × 17 columns, invoice-level, 89-day period ([dataset documentation](Supermarket_analysis/dataset/readme.md)) |
| **Main objective** | Determine whether sales differ meaningfully by branch, product line, customer type, gender, hour of day, and payment method, and test whether any differences are statistically significant. |
| **Main techniques** | Data validation and cleaning, feature engineering (hour/month/day-of-week), grouped aggregation, Pearson correlation, Shapiro-Wilk normality test, t-test, Mann-Whitney U test, chi-square test of independence, IQR outlier detection. |
| **Key findings** | Branch C leads in total sales (110,568.71) despite the fewest orders, due to a higher average invoice. Sales peak at 19:00. Membership status, weekend shopping, and customer rating show **no statistically significant** effect on spending. Payment method is independent of branch (p = 0.51). 9 outlier invoices detected (0.90%). |
| **Notebook** | [`Supermarket_Ədalət_Sadıqov.ipynb`](Supermarket_analysis/notebook/Supermarket_%C6%8Fdal%C9%99t_Sad%C4%B1qov.ipynb) ([notebook guide](Supermarket_analysis/notebook/readme.md)) |
| **Full documentation** | [Project README](Supermarket_analysis/Supermarket%20analysis_readme.md) · [Charts README](Supermarket_analysis/charts/readme.md) |

### 2. Shopping Mall Revenue Analysis (Istanbul)

| | |
|---|---|
| **Description** | Multi-dimensional retail analytics on 99,457 invoices from 10 Istanbul shopping malls and 8 product categories (2021 – Mar 2023), framed as a business problem for mall management. |
| **Dataset** | [`customer_shopping_data.csv`](istanbul-mall-revenue-analysis/dataset/customer_shopping_data.csv) — 99,457 rows × 10 columns ([dataset documentation](istanbul-mall-revenue-analysis/dataset/readme.md)) |
| **Main objective** | Identify where mall revenue comes from (category, mall, payment method, gender, time) and turn the findings into concrete recommendations for mall management. |
| **Main techniques** | Text standardization and date parsing, price-logic validation, feature engineering, revenue-share analysis, Welch's t-test (gender comparison with Bonferroni correction), like-for-like year-over-year comparison, FACT / INTERPRETATION / ASSUMPTION / BUSINESS ACTION labeling of insights. |
| **Key findings** | Clothing, shoes and technology generate 94.8% of revenue. Mall of Istanbul and Kanyon together generate 40.2% of revenue. Average invoice value is nearly identical across malls, payment methods, and genders. Total revenue was flat from 2021 to 2022 (+0.18%); clothing declined 2.05%. No category shows a statistically significant gender difference in spending. |
| **Notebook** | [`istanbul_analysis.ipynb`](istanbul-mall-revenue-analysis/notebook/istanbul_analysis.ipynb) ([notebook guide](istanbul-mall-revenue-analysis/notebook/readme.md)) |
| **Full documentation** | [Project README](istanbul-mall-revenue-analysis/optional_2_readme.md) · [Charts README](istanbul-mall-revenue-analysis/charts/readme.md) |

### 3. Sales Data Analysis — Cleaning, Statistics & RFM Customer Segmentation

| | |
|---|---|
| **Description** | EDA and RFM (Recency, Frequency, Monetary) customer segmentation on a retail sales transactions dataset, aimed at identifying high-value customers and churn risk. |
| **Dataset** | [`sales_data_sample.csv`](sales_analysis/dataset/sales_data_sample.csv) — 2,823 rows × 25 columns, 307 unique orders, 92 unique customers, 2003–2005 (2005 incomplete) ([dataset documentation](sales_analysis/dataset/readme.md)) |
| **Main objective** | Clean a raw sales dataset, summarize it statistically, visualize sales patterns across time/geography/product line, and segment customers by purchase behavior. |
| **Main techniques** | Missing-value handling, duplicate checks, descriptive statistics, time/geography/product-line visual analysis, RFM scoring (quantile-based 1–5 scores) mapped to 7 named business segments. |
| **Key findings** | `SALES` is right-skewed (mean $3,553.89 vs. median $3,184.80). The USA leads all markets with $3.63M in sales — roughly 3× Spain, the second-largest market. Classic Cars is the top-selling product line ($3.92M). The Champions RFM segment is 25% of customers but generates 41.5% of total revenue; Hibernating is the largest segment by customer count with an average recency of 324 days. |
| **Notebook** | [`Sales_analysis_Ədalət.ipynb`](sales_analysis/Sales_analysis_%C6%8Fdal%C9%99t.ipynb) |
| **Full documentation** | [Project README](sales_analysis/main_readme.md) · [Charts README](sales_analysis/charts/Readme.md) |

## Skills & Techniques

- Python (pandas, NumPy)
- Data Cleaning (missing values, duplicates, type conversion, text/date standardization)
- Feature Engineering
- Exploratory Data Analysis (EDA)
- Descriptive Statistics
- Statistical Hypothesis Testing (t-test, Mann-Whitney U, Welch's t-test, chi-square, Shapiro-Wilk, Pearson correlation)
- Outlier Detection (IQR method)
- Customer Segmentation (RFM analysis)
- Data Visualization (Plotly, Matplotlib, Seaborn)
- Business Analysis & Insight Communication (FACT / ASSUMPTION / INTERPRETATION framing, documented limitations)

## Key Learnings

- Applied a consistent, repeatable analytics workflow (inspect → clean → explore → visualize → test/model → conclude) across three unrelated datasets.
- Practiced distinguishing a statistically significant difference from a merely observed one, using formal hypothesis tests rather than eyeballing group averages.
- Built and debugged an RFM segmentation pipeline, including identifying and correcting a scoring bug where rank values had overwritten raw metrics before aggregation.
- Learned to document dataset limitations explicitly (synthetic-looking data, incomplete years, invoice-level vs. customer-level granularity) so conclusions are not overstated.
- Practiced separating facts from interpretations and assumptions when translating analysis into business recommendations.

## Overall Insights

- **Supermarket Sales Analysis:** The business is highly homogeneous — branch, product line, customer type, and payment method show only minor, statistically non-significant differences in sales. The clearest actionable signal is the 19:00 sales peak.
- **Istanbul Mall Revenue Analysis:** Revenue is concentrated in three categories (clothing, shoes, technology) and two malls, while mall-level differences are driven more by transaction volume than by average spend. Overall revenue growth was essentially flat year-over-year.
- **Sales Data Analysis (RFM):** A small group of "Champions" customers drives a disproportionate share of revenue, while a large "Hibernating" segment represents a concrete churn-risk opportunity. The USA and the Classic Cars product line are the strongest revenue drivers.

These insights are specific to each dataset and are not combined into a single cross-project conclusion.

## Repository Structure

```text
week1/
├── README.md
├── Supermarket_analysis/
│   ├── Supermarket analysis_readme.md
│   ├── charts/
│   │   ├── 01_total_sales_by_product_line.png
│   │   ├── 02_customer_type_distribution.png
│   │   ├── 03_total_sales_by_hour.png
│   │   ├── 04_sales_heatmap_branch_product.png
│   │   ├── 05_correlation_heatmap.png
│   │   └── readme.md
│   ├── dataset/
│   │   ├── readme.md
│   │   └── supermarket_sales - Sheet1.csv
│   └── notebook/
│       ├── Supermarket_Ədalət_Sadıqov.ipynb
│       └── readme.md
├── istanbul-mall-revenue-analysis/
│   ├── optional_2_readme.md
│   ├── charts/
│   │   ├── 01_revenue_by_dimension.png
│   │   ├── 02_category_share_and_avg_purchase.png
│   │   ├── 03_mall_category_revenue_heatmap.png
│   │   ├── 04_yearly_change_and_like_for_like.png
│   │   ├── 05_monthly_revenue_by_year.png
│   │   ├── 06_gender_category_mix_and_share.png
│   │   └── readme.md
│   ├── dataset/
│   │   ├── customer_shopping_data.csv
│   │   └── readme.md
│   └── notebook/
│       ├── istanbul_analysis.ipynb
│       └── readme.md
└── sales_analysis/
    ├── main_readme.md
    ├── Sales_analysis_Ədalət.ipynb
    ├── charts/
    │   ├── 01_sales_distribution.png
    │   ├── 02_orders_by_year.png
    │   ├── 03_top5_countries_sales.png
    │   ├── 04_sales_by_country_productline_top5.png
    │   ├── 05_sales_by_productline.png
    │   ├── 06_rfm_segment_overview.png
    │   ├── 07_rfm_scatter_frequency_monetary.png
    │   └── Readme.md
    └── dataset/
        ├── readme.md
        └── sales_data_sample.csv
```

## Technologies Used

- **Language:** Python 3.12+
- **Core libraries:** pandas, NumPy
- **Statistics:** SciPy (`scipy.stats`)
- **Visualization:** Plotly (Express & Graph Objects), Matplotlib, Seaborn
- **Environment:** Jupyter Notebook

## Navigation

| Project | Notebook | Dataset README | Charts README |
|---|---|---|---|
| [Supermarket Sales Analysis](Supermarket_analysis/Supermarket%20analysis_readme.md) | [Notebook](Supermarket_analysis/notebook/Supermarket_%C6%8Fdal%C9%99t_Sad%C4%B1qov.ipynb) | [Dataset README](Supermarket_analysis/dataset/readme.md) | [Charts README](Supermarket_analysis/charts/readme.md) |
| [Istanbul Mall Revenue Analysis](istanbul-mall-revenue-analysis/optional_2_readme.md) | [Notebook](istanbul-mall-revenue-analysis/notebook/istanbul_analysis.ipynb) | [Dataset README](istanbul-mall-revenue-analysis/dataset/readme.md) | [Charts README](istanbul-mall-revenue-analysis/charts/readme.md) |
| [Sales Data Analysis & RFM Segmentation](sales_analysis/main_readme.md) | [Notebook](sales_analysis/Sales_analysis_%C6%8Fdal%C9%99t.ipynb) | [Dataset README](sales_analysis/dataset/readme.md) | [Charts README](sales_analysis/charts/Readme.md) |

Additional per-project documentation (notebook guides, chart-by-chart explanations) is linked from each row above and from each project's own README.
