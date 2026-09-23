# Notebook Guide: `Supermarket_Ədalət_Sadıqov.ipynb`

This document explains how the analysis notebook is organised, which libraries it uses, and which statistical methods it applies and why.

- **Notebook:** [`Supermarket_Ədalət_Sadıqov.ipynb`](.../Supermarket_Ədalət_Sadıqov.ipynb)
- **Data:** [`supermarket_sales - Sheet1.csv`](../supermarket_sales%20-%20Sheet1.csv) (see [dataset documentation](DATASET_README.md))
- **Charts:** [`charts/`](../charts/README.md)

---

## 1. Goal

To explore 1,000 supermarket invoices (Q1 2019, three branches) and answer:

1. Is the data clean and reliable?
2. How do sales differ by branch, product line, customer type, gender, hour of day and payment method?
3. Are any of those differences, or any relationships between variables, statistically meaningful?

---

## 2. Environment and how to run

- **Python 3.12 or newer** (the notebook uses f-strings with nested quotes of the same type, which need Python 3.12+). The saved outputs were produced on Python 3.14 with pandas 3.x.
- Install the dependencies and open the notebook:

```bash
pip install -r requirements.txt
jupyter notebook Supermarket_Ədalət_Sadıqov.ipynb
```

- The CSV must be in the **same folder** as the notebook, because it is read with `pd.read_csv('supermarket_sales - Sheet1.csv')`.
- Run the cells from top to bottom (**Kernel → Restart & Run All**). The notebook was re-executed end to end on a clean kernel and finished with zero errors.

---

## 3. Notebook structure

| Section | What happens |
|---|---|
| **Libraries** | Imports pandas, numpy, plotly and scipy. |
| **Loading Dataset** | Reads the CSV into `data` and previews the first rows. |
| **Exploring data** | Converts column names to `snake_case`; checks shape, column names, `info()` and `describe()`. |
| **Data checking** | Counts missing values (0), duplicate rows (0) and confirms that `invoice_id` is unique (1,000 / 1,000). |
| **Data cleaning** | Works on a copy (`data_copy`); converts `date` to datetime, extracts `hour`, `month`, `dayofweek` and a `weekend` flag. |
| **Analysis → Group analysis** | For branch, product line, customer type and gender: total sales, order count and average order value. |
| **Analysis → Hourly analysis** | Total sales and orders per hour; identifies the busiest hour (19:00). |
| **Analysis → Product lines by revenue** | Top and bottom product line and the gap between them (6,951.10, 14.1%). |
| **Visuals** | Four Plotly charts: product-line bar, customer-type donut, hourly line, branch × product heatmap. |
| **Gross margin analysis** | Shows that the margin is constant (4.76%) and that gross income ranks product lines in the same order as sales. |
| **Statistical analysis** | Correlation, normality test, Member vs Normal test, weekend vs weekday test, chi-square tests and outlier detection. |
| **Additional analysis: payment method** | Sales by payment type and a chi-square test of payment method vs branch. |

The fifth chart (correlation heatmap) is produced inside *Statistical analysis → Correlation analysis*. All five are in [`charts/`](../charts/README.md).

---

## 4. Libraries used

| Library | Used for | Where |
|---|---|---|
| **pandas** | Loading the CSV, cleaning, date/time handling (`to_datetime`, `.dt`), aggregation (`groupby().agg()`), pivot tables, cross-tabulation (`crosstab`), correlation matrix (`.corr()`) | Throughout |
| **plotly.express** | The five interactive charts: `bar`, `pie`, `line`, `imshow` (twice) | Visuals, Correlation analysis |
| **scipy.stats** | All hypothesis tests: `pearsonr`, `shapiro`, `ttest_ind`, `mannwhitneyu`, `chi2_contingency` | Statistical analysis, Payment method |
| **numpy** | Imported, but not used directly in the current cells (pandas and scipy use it internally) | Libraries |
| **plotly.graph_objects**, **plotly.subplots.make_subplots** | Imported for possible custom or multi-panel figures; not used in the current cells | Libraries |

`display()` (used to show a Series or DataFrame) is a built-in of Jupyter and needs no import.

---

## 5. Statistical methods: what, why and what was found

Significance level throughout: **α = 0.05**. A small helper function, `interperet(p_value, alpha=0.05)`, labels each p-value as significant or not.

| Method | Function | Question it answers | Why this method | Result |
|---|---|---|---|---|
| **Descriptive statistics** | `describe()`, `groupby().agg()` | What does typical data look like, and how do segments compare? | First look before any testing | Total sales 322,966.75; average order 322.97 |
| **Pearson correlation** | `.corr()`, `st.pearsonr` | Is there a linear relationship between two numeric variables? | Standard measure of linear association, in the range −1 to +1 | `total` vs `rating`: r = −0.0364, p = 0.2496 (not significant) |
| **Shapiro-Wilk normality test** | `st.shapiro` | Are `total` and `rating` normally distributed? | Decides whether parametric tests are reliable | `total`: W = 0.9088, `rating`: W = 0.9582, both p < 0.001 → not normal |
| **Independent two-sample t-test** | `st.ttest_ind` | Do two groups have different **means**? | Standard test for a difference in means | Member vs Normal: t = 0.6215, p = 0.5344. Weekend vs weekday: t = 1.3114, p = 0.1900 |
| **Mann-Whitney U test** | `st.mannwhitneyu` | Do two groups differ in their overall **distributions** (typical rank)? | Non-parametric: does not assume normality, so it suits the skewed `total` (used as the main result after Shapiro-Wilk) | Member vs Normal: U = 127,453.0, p = 0.5912. Weekend vs weekday: U = 111,091.5, p = 0.1086 |
| **Chi-square test of independence** | `pd.crosstab` + `st.chi2_contingency` | Are two **categorical** variables associated? | The right test for counts in a contingency table | Branch × Product line: p = 0.3156. Gender × Product line: p = 0.3319. Customer type × Gender: p = 0.2295. Payment × Branch: p = 0.5090 |
| **IQR outlier rule** | `.quantile()` | Are there unusually large or small invoices? | Simple, distribution-free rule: values beyond Q1 − 1.5·IQR or Q3 + 1.5·IQR | Q1 = 124.42, Q3 = 471.35, IQR = 346.93; fences −395.97 / 991.74; 9 outliers (0.90%) → no special treatment |

### How the results fit together

- `total` and `rating` are not normal → the notebook reports **both** the t-test and the Mann-Whitney U test and treats the non-parametric result as primary.
- Both tests agree in every comparison: **no statistically significant difference** in spending between members and non-members, or between weekends and weekdays.
- **None of the four chi-square tests** finds an association, so the visible patterns in the heatmap (for example Branch C leading in Food and beverages) are likely random variation.
- The lower outlier fence is negative, so no invoice can fall below it; all 9 outliers are unusually **large** invoices.

---

## 6. Methodological notes

- **Correlation is not causation.** All relationships in this observational data are associations only.
- **"Not significant" does not mean "no difference".** With a few hundred invoices per group, only fairly large differences can be detected; small real effects may be missed. Reporting confidence intervals or effect sizes would make this clearer.
- **The t-test uses its default, equal-variance form** (`equal_var=True`); Welch's version is a common alternative when group variances may differ.
- **Shapiro-Wilk is very sensitive at n = 1,000**, so it can flag small departures from normality. The conclusion here is reinforced by the visibly skewed `total`.
- **No multiple-comparison correction** is applied across the several tests. Because none reached significance, this does not change the conclusions, but it would matter if any p-value were close to 0.05.
- **Unit of analysis is the invoice**, not the customer (there is no customer ID).
- **Structural columns.** `cogs`, `tax_5%`, `total` and `gross_income` are mathematically linked, so their correlations (r = 1.00) and `gross_income` "profitability" rankings are not findings.

---

## 7. Possible extensions

- Test differences in spending by **gender** and by **branch** (Mann-Whitney U for gender; Kruskal-Wallis or ANOVA for branch).
- Analyse **month** and **day of week**. These columns are created in the notebook but not yet analysed.
- Test whether the **19:00 peak** is statistically distinguishable from the other hours.
- Analyse `rating` by branch, product line and customer type.
- Add **effect sizes** (Cohen's d) and **confidence intervals** to every comparison, and correct for multiple comparisons.
- Replace the fixed 5% "gross income" with real cost data if a real dataset becomes available.

