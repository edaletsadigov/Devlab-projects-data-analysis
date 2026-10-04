# Notebook: `Regional_Sales_Breakdown.ipynb`

Regional comparison of video game sales: how North America, Europe, Japan and the rest of the world differ by genre, platform, publisher, release year and top games. The notebook is saved **with outputs** (charts are embedded as images, so they also display on GitHub).

- **Data:** [`../data/vgsales.csv`](../dataset/vgsales.csv), described in [`../data/README.md`](../dataset/readme.md)
- **Charts:** 9 figures, exported separately to [`../charts/`](../charts/readme.md)
- **Run:** open the notebook from the `notebook/` folder (the data path is `../data/vgsales.csv`) and run all cells. Dependencies are in [`../requirements.txt`](../requirements.txt).

## Purpose

Describe where video game sales are concentrated, region by region, and separate what the data **shows** from what it only **suggests**. The analysis is descriptive: the file has no price, marketing or release-region information, so it cannot explain *why* regions differ.

## Main analytical questions

1. How large is each regional market, and how skewed are sales inside it?
2. Does genre taste differ between regions?
3. Which platforms and publishers dominate each region?
4. How do sales and the regional mix change over release years and decades?
5. Which games lead each region?
6. Do games that sell in one region also sell in the others?

## Workflow

| Step | Notebook section | What is done |
| ---- | ---------------- | ------------ |
| 1 | Data overview and first look | shape, columns, dtypes, `info`, `head`, `sample`, `describe`, `nunique` |
| 2 | Cleaning | lowercase column names, missing values, duplicates, sales-column check, year coverage, region setup |
| 3 | Regional statistics | total sales per region, per-game mean/median, share of `0.00` games |
| 4 | Genre by region | totals and within-region shares |
| 5 | Platform by region | top 10 platforms by global sales, regional split, all-platform check for Japan |
| 6 | Publisher by region | top 5 publishers per region with shares |
| 7 | Regional sales over time | release-year lines (1980–2015) and share by decade |
| 8 | Top games by region | top 5 game-platform rows per region |
| 9 | Relationship between regions | Spearman and Pearson correlation, restricted to games sold in both regions |
| 10 | Regional profile and final conclusion | one summary table, key findings, recommendations, limitations |

## Data cleaning and preprocessing

Every decision is shown with a count and a reason in the notebook.

- Column names lowercased (`NA_Sales` → `na_sales`)
- `publisher` (58 missing, 0.3%) filled with `unknown`, so the games stay in all regional totals
- `year` (271 missing, 1.6%) **not** filled: a made-up year would break the time analysis. These rows are left out only of the year-based section
- No fully duplicated rows. 5 repeated `name` + `platform` pairs (0.08% of sales) are kept and explained
- The 4 regions differ from `global_sales` by at most 0.02 per row; net +4.59M (0.05%), with gaps in both directions (+24.90M and −20.31M). Shares therefore use the **4-region sum** as 100%
- Year-based analysis uses **1980–2015** only (15,979 of 16,598 rows): 2016 is incomplete (344 games vs 614 in 2015), 2017 and 2020 have 3 and 1 games

## Exploratory data analysis

- **Market size:** North America 49.3% (4,393.0M), Europe 27.3% (2,434.1M), Japan 14.5% (1,291.0M), Other 8.9% (797.8M)
- **Skew:** mean per game is far above the median in every region (North America 0.26 vs 0.08M); 63.0% of games have `0.00` sales in Japan
- **Taste:** shares are computed inside each region, so market size does not hide taste differences
- **Concentration:** top publishers and platforms are compared by share, not only by total
- **Guards:** partial years are excluded, the small 1980s base is flagged, and the top-10 platform view is cross-checked against all platforms with at least 100M units

## Statistical analysis

No hypothesis tests were run; all comparisons are descriptive. The statistical choices are:

- **Mean vs median** to show right-skewed sales
- **Spearman correlation** between regions instead of Pearson, because a few blockbusters pull Pearson up. Pearson is printed next to it for comparison
- **Restriction to games sold in both regions** (sales above 0), because 63.0% of Japan's values are tied at `0.00` and ties distort rank correlation

| Pair | Spearman, all games | Spearman, games sold in both | Games sold in both |
| ---- | ------------------: | ---------------------------: | -----------------: |
| North America – Europe | 0.68 | 0.68 | 9,744 |
| North America – Other | 0.77 | 0.67 | 9,341 |
| Europe – Other | 0.77 | 0.76 | 8,544 |
| North America – Japan | −0.23 | 0.21 | 2,685 |
| Europe – Japan | −0.18 | 0.13 | 2,524 |
| Japan – Other | −0.07 | 0.02 | 2,843 |

## Visualizations

Nine Plotly charts, each with title, axis labels and a result sentence below it: total sales by region, zero-sales share, genre totals, genre share heatmap, top-10 platform split, top-5 publishers, sales by release year, share by decade, Spearman heatmap. See [`../charts/README.md`](../charts/readme.md) for what each one shows and its main finding.

## Main findings

**Facts**

1. North America is about half of all sales (49.3%); it sells about 1.8 times Europe and 3.4 times Japan
2. Sales are right-skewed in every region. In Japan 63.0% of games have `0.00` sales (27.1% in North America)
3. `Action` is number 1 in North America, Europe and Other. In Japan `Role-Playing` is 27.3% of sales (about 7.5% elsewhere) and `Shooter` only 3.0% (12.9–13.3% elsewhere). Action, Sports and Shooter are 46.2% of all sales
4. `X360` is 61.4% North America; `PC` is 54.1% Europe. Across all platforms with at least 100M units, Japan's share is highest on Nintendo systems: `SNES` 58.3%, `3DS` 39.4%, `NES` 39.3%, `GB` 33.3%
5. `Nintendo` is number 1 in North America, Europe and Japan (35.3% of Japan sales); `Electronic Arts` is number 1 in Other
6. North America, Europe and Other peak in 2008–2009 (by release year), Japan earlier, in 2006
7. Europe's share rises every decade (8.3% → 33.2%), Japan's falls from about 29% (1990s) to 11–12%
8. North America, Europe and Other overlap strongly (Spearman 0.68–0.77). Japan's overlap with them is weak (0.02–0.21 among games sold in both)

**Interpretations (not tested)**

- Many titles are probably specific to one market, which would explain Japan's zeros and weak overlap. The file has no release-region column
- The rise of Europe may partly reflect better tracking of Europe in the source, since the 1980s base is only 205 games
- The decline after 2009 is probably affected by missing digital sales and by newer games having less time to sell, not only by market decline

## Conclusions

- Regional markets differ in size, genre mix, platform mix and publisher structure; **Japan is the most different** in every dimension tested
- Business use: weight a Japan line-up towards `Role-Playing`; test `PC` and `PS4` first for Europe-focused titles (54.1% and 44.5% of their sales are in Europe vs 27.3% for the market as a whole); get release-region data before any Japan launch decision. These are hypotheses to test with a small pilot, because shares do not prove that genre or platform causes the difference
- Limitations: lifetime sales grouped by release year, possible missing digital sales, game-platform rows, and no hypothesis tests. Correlation is not causation

