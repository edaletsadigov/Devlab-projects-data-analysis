# Dataset Documentation

This document describes `sales_data_sample.csv` in detail — its origin, structure, every column, known data quality issues, and caveats to keep in mind before running any analysis on it.

## Source

- **Name:** Sample Sales Data
- **Provider:** [Kaggle — kyanyoga/sample-sales-data](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data)
- **File:** `sales_data_sample.csv`
- **License / usage:** Public Kaggle dataset, commonly used for BI/analytics practice (originally distributed as a sample dataset for a fictional wholesale distributor of scale-model vehicles)

## File Properties

| Property | Value |
|---|---|
| Rows | 2,823 |
| Columns | 25 |
| Encoding | `ISO-8859-1` (does **not** load with default UTF-8 — will raise a `UnicodeDecodeError`) |
| Format | CSV, comma-delimited |
| Load example | `pd.read_csv('sales_data_sample.csv', encoding='ISO-8859-1')` |

## Unit of Analysis — Read This First

**Each row is an order *line item*, not a complete order.** The dataset contains:

- **307** unique orders (`ORDERNUMBER`)
- **2,823** order-line rows
- → an average of **~9.2 line items per order**

This means any "how many orders" question must use `data['ordernumber'].nunique()`, not `len(data)` — using row count alone overstates order volume by ~9×.

## Time Coverage

- **Range:** 2003-01 to 2005-05
- **2003:** full year (1,000 order lines)
- **2004:** full year (1,345 order lines)
- **2005:** **partial year — January through May only** (478 order lines)

Any year-over-year comparison involving 2005 must account for this, either by excluding 2005 or by annualizing its totals. Treating 2005 as a "down year" without this context produces a misleading conclusion.

## Column Dictionary

| Column | Type (after cleaning) | Description |
|---|---|---|
| `ORDERNUMBER` | int | Unique identifier for an order (307 unique values; multiple rows share the same order number) |
| `QUANTITYORDERED` | int | Units ordered for this line item |
| `PRICEEACH` | float | Unit price for this line item |
| `ORDERLINENUMBER` | int | Sequence number of this line within its order |
| `SALES` | float | Total revenue for this line item (≈ `QUANTITYORDERED × PRICEEACH`) — the primary revenue metric used throughout the analysis |
| `ORDERDATE` | datetime | Date the order was placed (converted from string during cleaning) |
| `STATUS` | category | Order fulfillment status — `Shipped`, `Cancelled`, `Resolved`, `On Hold`, `In Process`, `Disputed` |
| `QTR_ID` | int | Calendar quarter (1–4) |
| `MONTH_ID` | int | Calendar month (1–12) |
| `YEAR_ID` | int | Calendar year — `2003`, `2004`, or `2005` |
| `PRODUCTLINE` | category | Product category — 7 values (see below) |
| `MSRP` | float | Manufacturer's suggested retail price for the product |
| `PRODUCTCODE` | string | Unique product SKU (109 unique values) |
| `CUSTOMERNAME` | string | Company/customer name (92 unique values — the entity used for RFM segmentation) |
| `PHONE` | string | Customer contact phone number |
| `ADDRESSLINE1` | string | Primary address line |
| `ADDRESSLINE2` | string | Secondary address line — **mostly missing (89.3%)**, filled with `"unknown"` |
| `CITY` | string | Customer city |
| `STATE` | string | Customer state/province — **missing 52.6%** (many customers are outside the US and have no state), filled with `"unknown"` |
| `POSTALCODE` | string | Postal/ZIP code — missing 2.7%, filled with `"unknown"` |
| `COUNTRY` | category | Customer country (19 unique values) |
| `TERRITORY` | category | Sales territory grouping — **missing 38.0%**, filled with `"unknown"` |
| `CONTACTLASTNAME` | string | Contact person's last name |
| `CONTACTFIRSTNAME` | string | Contact person's first name |
| `DEALSIZE` | category | Order size bucket — `Small`, `Medium`, `Large` (derived from `SALES` value ranges) |

### Product Lines (7 categories)

`Classic Cars`, `Vintage Cars`, `Motorcycles`, `Planes`, `Trucks and Buses`, `Ships`, `Trains`

## Data Quality Summary

### Missing Values

Only 4 of 25 columns contain missing values — all address-related, none of which affect the core sales/product/customer analysis:

| Column | Missing Count | Missing % |
|---|---:|---:|
| `ADDRESSLINE2` | 2,521 | 89.3% |
| `STATE` | 1,486 | 52.6% |
| `TERRITORY` | 1,074 | 38.0% |
| `POSTALCODE` | 76 | 2.7% |

**Handling:** All four filled with the string `"unknown"`. Rows were not dropped, since doing so would discard valid transaction records over an incidental address field.

### Duplicates

**0 duplicate rows** — confirmed via `data.duplicated().sum()`.

### Distribution Notes

- `SALES` is right-skewed: mean = $3,553.89, median = $3,184.80, min = $482.13, max = $14,082.80
- `STATUS` is heavily imbalanced: 92.7% of rows are `Shipped`; the remaining 7.3% is split across 5 other statuses (largest of which, `Cancelled`, is only 2.1%)

## Known Caveats

1. **Order-line granularity** — see [Unit of Analysis](#unit-of-analysis--read-this-first) above
2. **Incomplete 2005** — see [Time Coverage](#time-coverage) above
3. **`DEALSIZE` is derived from `SALES`**, not an independent variable — any statistical test comparing `SALES` across `DEALSIZE` groups will show a significant difference by construction, since the categories are defined by `SALES` ranges. This is not a genuine finding and should not be reported as one.
4. **No product cost / margin field** — `SALES` and `MSRP` are both revenue-side figures; profitability cannot be assessed from this dataset alone
5. **No marketing, channel, or campaign data** — patterns like the November sales peak (see `charts/README.md`) can be observed but not causally explained with this dataset alone

## Files in This Directory

```
data/
└── sales_data_sample.csv   <- Raw source file, as downloaded from Kaggle (only cleaning applied
                                downstream in the notebook — this file itself is untouched)
```

The cleaned version (missing values filled, `orderdate` typed as datetime, columns lowercased) is produced inside the notebook and is not persisted as a separate file in this repository — see [`notebooks/task1_main_Ədalət.ipynb`](../notebooks/task1_main_Ədalət.ipynb), Cleaning section.
