# Dataset — `data.csv`

[← Project README](../README.md) · [Notebook README](../notebooks/README.md) · [Insights and Results](../INSIGHTS_AND_RESULTS.md)

## Overview

| Property | Value |
|---|---|
| File | `data.csv` (identical copy of the provided `data_1.csv`) |
| Size | about 45.6 MB |
| Rows x columns | **541,909 x 8** |
| Grain | one row per **invoice line** (one product on one invoice) |
| Period | 2010-12-01 08:26 to 2011-12-09 12:50 |
| Invoices | 25,900 distinct `InvoiceNo` |
| Stock codes | 4,070 distinct `StockCode` |
| Countries | 38 distinct `Country` |
| Currency | not stated in the file; **GBP is assumed** in the analysis |
| Encoding | read with `encoding='utf8-lossy'`; some non-ASCII characters (e.g. the currency sign in gift-voucher descriptions) appear as a replacement character |

**Provenance.** The provided files do not state where the data comes from. Its structure matches the public *Online Retail* transaction dataset of a UK-based online retailer; confirm the source and its licence terms before publishing the CSV in a public repository.

## Columns

| Column | Polars type (as loaded) | Example | Description | Nulls |
|---|---|---|---|---:|
| `InvoiceNo` | String | `536365` | Invoice number. A leading **`C`** marks a **cancellation** (return). Loaded as text so the prefix is kept. | 0 |
| `StockCode` | String | `85123A` | Product code (five digits with an optional letter). Also contains **non-product codes** such as `POST`, `DOT`, `M`, `AMAZONFEE`. | 0 |
| `Description` | String | `WHITE HANGING HEART T-LIGHT HOLDER` | Product name. 4,224 distinct values. | 1,454 (0.27%) |
| `Quantity` | Int64 | `6` | Units on the line. Negative for cancellations. Range -80,995 to 80,995. | 0 |
| `InvoiceDate` | String (parsed to datetime in the notebook) | `12/1/2010 8:26` | Invoice timestamp, format `month/day/year hour:minute`. | 0 |
| `UnitPrice` | Float64 | `2.55` | Price per unit. Range -11,062.06 to 38,970 (extreme values are non-product adjustments). | 0 |
| `CustomerID` | Int64 | `17850` | Customer identifier. **Missing for 24.93% of rows**, so customer-level analysis uses identified customers only. | 135,080 (24.93%) |
| `Country` | String | `United Kingdom` | Customer country. 38 distinct values (including `Unspecified`). | 0 |

## Summary statistics (raw data)

| Column | Mean | Std | Min | 25% | 50% | 75% | Max |
|---|---:|---:|---:|---:|---:|---:|---:|
| `Quantity` | 9.55 | 218.08 | -80,995 | 1 | 3 | 10 | 80,995 |
| `UnitPrice` | 4.61 | 96.76 | -11,062.06 | 1.25 | 2.08 | 4.13 | 38,970 |
| `CustomerID` | 15,287.69 | 1,713.60 | 12,346 | 13,953 | 15,152 | 16,791 | 18,287 |

## Data quality profile (raw data)

| Issue | Rows | Handling in the notebook |
|---|---:|---|
| Exact duplicate rows (extra copies) | 5,268 (0.97%) | Dropped. Assumption: export or scan duplicates. |
| Cancellation lines (`InvoiceNo` starts with `C`) | 9,288 | Kept as **returns**, i.e. negative revenue (`net = sales + returns`). |
| Rows with `Quantity <= 0` | 10,624 | Cancellations are kept as returns; non-cancellation lines with `Quantity <= 0` all have `UnitPrice <= 0` and are dropped with them. |
| Rows with `UnitPrice <= 0` | 2,517 | Dropped (2,492 remained after earlier steps): 98.7% have no `CustomerID`, 58.0% have no description. |
| Non-product `StockCode` rows | 2,944 (after dedup) | Dropped: `POST`, `DOT`, `M`, `m`, `C2`, `D`, `S`, `BANK CHARGES`, `AMAZONFEE`, `CRUK`, `B`, `PADS` and `gift_*` vouchers. |
| Rows without `CustomerID` | 135,080 | Kept for revenue analysis, excluded from customer-level analysis. |
| Customers appearing in more than one country | 8 | Assigned to the country where they ordered most often. |
| Two fully reversed orders (customers `12346` and `16446`) | 4 lines | Net effect zero; excluded from order and customer counts (`sales_ex`, `returns_ex`). |

### Row flow through cleaning

| Step | Rows after step |
|---|---:|
| Raw file | 541,909 |
| After removing exact duplicates | 536,641 |
| After removing non-product codes | 533,697 |
| After removing `unit_price <= 0` | 531,205 (522,537 sales lines + 8,668 return lines) |

## Fields derived in the notebook

| Field | Definition |
|---|---|
| `is_cancel` | `invoice_no` starts with `C` |
| `revenue` | `quantity * unit_price` (negative for returns) |
| `month`, `weekday`, `hour` | Calendar parts of `invoice_date` |
| `net_revenue` | Sales + returns |
| Customer table (`cust_statistic`) | Per customer: `orders`, `items`, `products`, `gross_revenue`, `returns_value`, `net_revenue`, `aov`, `first_order`, `last_order`, `country`, `is_uk`, `is_repeat` |
| RFM fields | `recency_days`, `r_score`, `f_score`, `m_score`, `segment` |

## Fields most relevant to each analysis

| Analysis | Fields |
|---|---|
| Revenue and trend | `InvoiceNo`, `InvoiceDate`, `Quantity`, `UnitPrice` |
| Country | `Country`, `CustomerID` |
| Products and returns | `StockCode`, `Description`, `Quantity`, `UnitPrice`, `InvoiceNo` (prefix `C`) |
| Customer-level (concentration, RFM, cohorts, tests) | `CustomerID`, `InvoiceNo`, `InvoiceDate`, `Quantity`, `UnitPrice`, `Country` |

## Analytical purpose

The dataset supports a **revenue and customer-level analysis**: where revenue comes from (time, country, products), how large returns are, and how concentrated, loyal and valuable the customer base is. Results are in [Insights and Results](../INSIGHTS_AND_RESULTS.md); charts are listed in the [chart index](../charts/README.md).

## Limitations of the data

- 13 months, one season; December 2011 is partial (9 days).
- No cost, margin or discount data: results describe **revenue, not profit**.
- No customer-type, return-reason or channel fields.
- 24.8% of cleaned lines (15.4% of net revenue) have no `CustomerID`.
- Customers whose first order is in Dec 2010 may have bought before the data starts.

