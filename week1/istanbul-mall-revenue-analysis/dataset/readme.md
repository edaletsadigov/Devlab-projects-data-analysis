# Dataset: `customer_shopping_data.csv`

Back to the [main README](../optional_2_readme.md).

## Description

One row per retail invoice from 10 shopping malls. Each invoice contains one product category, a quantity, a total price, the customer's gender and age, the payment method and the invoice date.

- **Source:** not documented in the project files.
- **File:** [customer_shopping_data.csv](customer_shopping_data.csv). This is the **raw** file; no cleaned copy is stored. All cleaning happens inside the [notebook](../notebook/istanbul_analysis.ipynb).
- **Currency:** not stated in the data. Values are reported in the dataset's own units.

## Overview

| Item | Value |
|---|---|
| Rows | 99,457 |
| Columns | 10 |
| Date range | 2021-01-01 to 2023-03-08 (797 days; every day has at least one invoice) |
| Invoices per year | 2021: 45,382 · 2022: 45,551 · 2023: 8,524 (partial) |
| Total revenue | 68,551,366 |

## Columns

| Column | Type (raw) | Description | Values / range |
|---|---|---|---|
| `invoice_no` | text | Invoice identifier. Letter `I` + 6 digits. | 99,457 unique values |
| `customer_id` | text | Customer identifier. Letter `C` + 6 digits. | 99,457 unique values (one row per customer) |
| `gender` | text | Customer gender. | Female, Male |
| `age` | integer | Customer age in years. | 18 – 69 |
| `category` | text | Product category of the invoice. | 8 values (see below) |
| `quantity` | integer | Number of units on the invoice. | 1 – 5 |
| `price` | float | **Total** invoice amount (`unit price × quantity`). Not a unit price. | 5.23 – 5,250.00 |
| `payment_method` | text | How the invoice was paid. | Cash, Credit Card, Debit Card |
| `invoice_date` | text | Invoice date, format `d/m/yyyy` (day first). | 01/01/2021 – 08/03/2023 |
| `shopping_mall` | text | Mall where the purchase was made. | 10 values (see below) |

## Data quality

| Check | Result (**FACT**) |
|---|---|
| Missing values | 0 in all 10 columns |
| Fully duplicated rows | 0 |
| `invoice_no` unique | Yes |
| `customer_id` unique | Yes |
| Extra spaces in `gender`, `category`, `payment_method`, `shopping_mall` | 0 |
| Out-of-range values | None: `quantity` is 1–5, `age` is 18–69 |

## Categorical variables

| Variable | Distinct | Levels (invoice count) |
|---|---|---|
| `gender` | 2 | Female (59,482), Male (39,975) |
| `payment_method` | 3 | Cash (44,447), Credit Card (34,931), Debit Card (20,079) |
| `category` | 8 | Clothing (34,487), Cosmetics (15,097), Food & Beverage (14,776), Toys (10,087), Shoes (10,034), Souvenir (4,999), Technology (4,996), Books (4,981) |
| `shopping_mall` | 10 | Mall of Istanbul (19,943), Kanyon (19,823), Metrocity (15,011), Metropol AVM (10,161), Istinye Park (9,781), Zorlu Center (5,075), Cevahir AVM (4,991), Forum Istanbul (4,947), Viaport Outlet (4,914), Emaar Square Mall (4,811) |

**INTERPRETATION:** the mall names match well-known Istanbul shopping malls. The dataset has no city column.

## Numerical variables

| Variable | Mean | Std | Min | 25% | Median | 75% | Max |
|---|---|---|---|---|---|---|---|
| `age` | 43.43 | 14.99 | 18 | 30 | 43 | 56 | 69 |
| `quantity` | 3.00 | 1.41 | 1 | 2 | 3 | 4 | 5 |
| `price` | 689.26 | 941.18 | 5.23 | 45.45 | 203.30 | 1,200.32 | 5,250.00 |

- **FACT:** `quantity` is spread almost evenly over 1 to 5 (19,723 to 20,149 invoices per value).
- **FACT:** `price` is strongly right-skewed (median 203.30 vs mean 689.26) because categories have very different unit prices. The maximum, 5,250.00, is technology: 5 × 1,050.00. It is a valid value, not an outlier. No rows were removed.

## Price structure

**FACT:** dividing `price` by `quantity` gives exactly **one unit price per category**:

| Category | Unit price | Category | Unit price |
|---|---|---|---|
| Technology | 1,050.00 | Cosmetics | 40.66 |
| Shoes | 600.17 | Toys | 35.84 |
| Clothing | 300.08 | Books | 15.15 |
| Souvenir | 11.73 | Food & Beverage | 5.23 |

## Data quality issues and limitations

1. **Mixed date formatting (FACT).** `invoice_date` is text. 61,720 values are zero-padded (`05/08/2022`) and 37,737 are not (`5/8/2022`).
2. **Day-first dates (FACT-based decision).** In 59,428 rows the first number is above 12 and in none is the second number above 12, so the format is day/month/year. Parsing with `%d/%m/%Y` is therefore safe.
3. **Partial 2023 (FACT).** Data stops on 2023-03-08. 2023 must not be compared with full years; the notebook compares the same window (1 Jan – 8 Mar) in all three years.
4. **`price` is a line total (FACT).** Multiplying it by `quantity` again would overstate revenue.
5. **One category per invoice and one invoice per customer (FACT).** Baskets, repeat purchases and customer loyalty cannot be analysed.
6. **Fixed unit prices (FACT).** Price changes and discounts cannot be analysed. Differences in average invoice between groups come only from category mix and quantity.
7. **Very regular patterns (INTERPRETATION).** Category mix, average invoice by gender and by payment method are almost identical across groups. Real retail data is usually less regular, so check how the data was collected before using it for real decisions.
8. **No currency, footfall, floor area, rent or margin data (FACT).** Any explanation of *why* malls differ is a hypothesis.

## Cleaning and preprocessing (done in the notebook)

| Step | Detail |
|---|---|
| Copy | `raw` keeps the file as loaded; all work is done on `data = raw.copy()` |
| Standardise text | Column names and all text values converted to lowercase (e.g. `Credit Card` → `credit card`) |
| Validation | Checked missing values, duplicates, uniqueness of IDs, value ranges, extra spaces |
| Price test | Verified that `price` is constant per `quantity` within a category and that unit price is unique per category |
| Date parsing | `invoice_date` converted to datetime with `format="%d/%m/%Y"` |

**Derived columns**

| Column | Definition |
|---|---|
| `unit_price` | `price / quantity`, rounded to 2 decimals (used for the price test) |
| `year`, `month`, `year_month` | From `invoice_date` (`year_month` as `YYYY-MM`) |
| `revenue` | Equal to `price` (**ASSUMPTION**, supported by the price test: `price` is already the invoice total) |
| `age_group` | Bins 17–24, 25–34, 35–44, 45–54, 55–64, 65–69. Minimum age is 18, so the first group is effectively 18–24. |

Resulting categorical values after lowercasing: gender `female` / `male`; payment `cash` / `credit card` / `debit card`; categories `clothing`, `shoes`, `technology`, `cosmetics`, `toys`, `food & beverage`, `books`, `souvenir`.

