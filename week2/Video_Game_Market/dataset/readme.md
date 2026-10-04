# Dataset: `vgsales.csv`

Video game sales by game and platform, split into four regions. This is the only data source of the project.

- **File:** [`vgsales.csv`](vgsales.csv)
- **Size:** 16,598 rows × 11 columns, about 1.4 MB in memory
- **Grain:** one row = one game on one platform (a game released on 3 platforms has 3 rows)
- **Unit:** all sales columns are in **millions of units sold**, not USD
- **Source:** the public Kaggle *Video Game Sales* file, which is compiled from VGChartz. Check the original page and its licence before republishing the file.

## Purpose and analytical context

The dataset is used to compare **what sells where**: how North America, Europe, Japan and the rest of the world differ by genre, platform, publisher, release year and top games. It is a descriptive dataset. It has no price, marketing, review or release-region information, so it can show *where* sales are concentrated but not *why*.

## Columns

| Column | Raw dtype | Meaning | Notes |
| ------ | --------- | ------- | ----- |
| `Rank` | `int64` | Rank of the row by `Global_Sales` | Max is 16,600 but there are 16,598 rows, so 2 rank values are absent |
| `Name` | `str` | Game title | 11,493 distinct titles |
| `Platform` | `str` | Platform of release (`Wii`, `PS2`, `DS`, `PC`, ...) | 31 platforms |
| `Year` | `float64` | Release year | Float because of missing values; 39 distinct years (1980–2020) |
| `Genre` | `str` | Game genre | 12 genres |
| `Publisher` | `str` | Publishing company | 578 distinct publishers |
| `NA_Sales` | `float64` | Sales in North America (M units) | 0.00 to 41.49 |
| `EU_Sales` | `float64` | Sales in Europe (M units) | 0.00 to 29.02 |
| `JP_Sales` | `float64` | Sales in Japan (M units) | 0.00 to 10.22 |
| `Other_Sales` | `float64` | Sales in the rest of the world (M units) | 0.00 to 10.57 |
| `Global_Sales` | `float64` | Worldwide sales (M units) | 0.01 to 82.74 |

In the notebook, column names are lowercased (`na_sales`, `eu_sales`, ...).

## Sales distribution

| Region | Total (M units) | Mean per game | Median per game | Games with `0.00` sales |
| ------ | --------------: | ------------: | --------------: | ----------------------: |
| North America | 4,392.95 | 0.26 | 0.08 | 27.1% |
| Europe | 2,434.13 | 0.15 | 0.02 | 34.5% |
| Japan | 1,291.02 | 0.08 | 0.00 | 63.0% |
| Other | 797.75 | 0.05 | 0.01 | 39.0% |

Mean is far above the median in every region, so sales are **right-skewed**: a few hits sell a lot and most games sell very little. Values are rounded to 0.01M, so `0.00` means below 5,000 units, not necessarily no sales.

## Missing values and data-quality issues

| Issue | Size | Decision |
| ----- | ---- | -------- |
| `Year` missing | 271 rows (1.6%) | **Not filled.** A made-up year would distort the time analysis; these rows stay in all totals and are left out only of the year-based section |
| `Publisher` missing | 58 rows (0.3%) | Filled with `unknown`, so the games stay in every regional total |
| Incomplete last years | 2016: 344 games (2015: 614); 2017: 3; 2020: 1 | Year-based analysis uses **1980–2015** only (15,979 rows; 619 rows excluded: 271 missing year + 348 after 2015) |
| Repeated `name` + `platform` | 5 pairs (10 rows, 7.52M global sales = 0.08% of the total) | Kept. Some are separate releases (`Need for Speed: Most Wanted`, 2005 vs 2012); others (`Madden NFL 13`, `Sonic the Hedgehog`) may be a second record of one release, which this file cannot prove |
| Fully duplicated rows | 0 | Nothing to remove |
| `Global_Sales` ≠ sum of 4 regions | Gap up to 0.02 per row; net +4.59M (0.05%): `Global_Sales` is higher in 2,484 rows (+24.90M) and lower in 2,027 rows (−20.31M) | Regional shares use the **4-region sum** as 100%, so they always add up to 100%. The cause of the gap is not visible in the file |

## Other limitations to keep in mind

- Sales are **lifetime sales** of a game, grouped by release year. They are not yearly sales.
- The file does not say whether digital or mobile sales are included, so recent years may be undercounted.
- Early Europe and Other values (1980s) may partly reflect how well the source tracked those regions.
- A row is a game-platform pair, so top-game rankings are game-platform rankings.

## Quick load

```python
import pandas as pd

data = pd.read_csv('data/vgsales.csv')
data.columns = data.columns.str.lower()
data['publisher'] = data['publisher'].fillna('unknown')   # year is left missing on purpose
```

