# Island Research Reference Data

Open reference datasets for small island development research,
maintained by the [University of Aruba](https://www.ua.aw) research
community through the [Dutch Caribbean Digital Competence (DCDC) Network](https://dcdc.network/).
Datasets are formatted for direct use in XLSForm-based
survey tools (KoboToolbox, ODK) and for integration with R, Python,
and other analysis environments.

All datasets follow [FAIR data principles](https://dcdc.network/about/fair-and-reproducibility/):
Findable, Accessible, Interoperable, and Reusable.

---

## Available datasets

### countries/
A comprehensive country and territory reference list with research
classifications. Intended as a drop-in choices sheet for XLSForm
surveys requiring country selection, with additional columns to
support filtering and analysis by development category.

**Columns**

| Column | Description | Source |
|---|---|---|
| list_name | XLSForm list identifier | XLSForm standard |
| name | XLSForm-safe unique code | Derived from ISO 3166-1 |
| label | Display name (UTF-8) | ISO 3166-1 / UN standard |
| iso_code | Official ISO 3166-1 alpha-2 code | ISO 3166-1 |
| wb_region | World Bank regional classification | World Bank FY2025 |
| wb_income_group | World Bank income group | World Bank Atlas Method FY2025 |
| political_association | Sovereign or administering authority | UN / constitutional documents |
| is_sids | Small Island Developing State (1 = yes) | UN OHRLLS official list |
| is_snij | Sub-national island jurisdiction (1 = yes) | Baldacchino & Royle (2010) |
| criterion_small | Meets small states population threshold (1 = yes) | Commonwealth Secretariat / World Bank (≤ 1.5M) |
| criterion_island | Territory is entirely insular (1 = yes) | Geographic |
| criterion_developing | Economy is non-high income (1 = yes) | World Bank Atlas Method FY2025 |
| criterion_sovereign | Recognised sovereign state (1 = yes) | UN membership status |
| sids_tier | SIDS membership category | UN OHRLLS |

**Key classifications used**

*SIDS* — follows the official UN Office of the High Representative
for the Least Developed Countries, Landlocked Developing Countries
and Small Island Developing States
([UN OHRLLS](https://www.un.org/ohrlls/content/list-sids)) list,
which comprises 57 entries: 39 sovereign member states and 18
associate members of UN Regional Commissions. The `is_sids` column
flags all 57 entries; the `sids_tier` column distinguishes between
`Sovereign member` and `Associate member`.

*SNIJ* — follows the sub-national island jurisdiction concept as
defined in Baldacchino, G. & Royle, S.A. (2010). Referring to
non-sovereign island territories that maintain a degree of
self-governance under a larger sovereign state.

*World Bank classifications* — reflect the World Bank FY2025
country and lending groups. Territories not independently classified
by the World Bank carry blank values rather than inherited
parent-country values.

*Political association* — uses "Independent" for sovereign states
recognised by the UN, and names the administering or constituent
authority for non-sovereign territories (e.g., "Dutch Kingdom",
"French Republic", "United Kingdom", "United States"). Note that
"Dutch Kingdom" refers to the Kingdom of the Netherlands as a
constitutional entity, of which the Netherlands, Aruba, Curaçao,
and Sint Maarten are constituent countries.

*Criterion columns* — four binary columns testing each SIDS sovereign
member against the literal components of the acronym. Populated for
sovereign members only; blank for all other rows. See the
visualizations section and `countries/NOTES.md` for full methodology.

See `countries/NOTES.md` for detailed decisions on edge cases.

### visualizations/
R-based data visualizations produced from the reference datasets,
with accompanying explainer documentation and reproducible code.

---

## Visualizations

### What SIDS actually means
A criteria matrix testing all 39 sovereign UN OHRLLS SIDS members
against the four literal components of the acronym: Small, Island,
Developing, and Sovereign. Rows are sorted by the number of criteria
not met, making structural anomalies within the classification
immediately visible.

**Files**
- `visualizations/sids_criteria_matrix.R` — reproducible R/ggplot2 code
- `visualizations/sids_criteria_visualization_explainer.md` — methodology,
  findings, design notes, and citation guidance

**Requirements**

R packages: `tidyverse`, `ggtext`, `glue`

```r
install.packages(c("tidyverse", "ggtext", "glue"))
source("visualizations/sids_criteria_matrix.R")
```

The script reads data directly from this repository and saves the output
as `sids_criteria_matrix.png` in your working directory.

![SIDS criteria matrix — which members actually meet all four components of the acronym?](https://raw.githubusercontent.com/University-of-Aruba/island-research-reference-data/main/visualizations/sids_criteria_matrix.png)

*Each row is one of the 39 sovereign SIDS members, sorted by the number of criteria not met.
Green tiles indicate the criterion is satisfied; grey tiles indicate it is not.
The pattern reveals that a meaningful share of members do not meet one or more of the literal
components of the acronym — most commonly the "small" or "developing" thresholds.*

**Citation**
> de Kort, R.E. (2026). *What SIDS actually means* [Data visualization].
> Dutch Caribbean Digital Competence Network (DCDC), University of Aruba.
> GitHub. https://github.com/University-of-Aruba/island-research-reference-data

---

### How many criteria does each SIDS member actually meet?
A radial bar chart showing the number of acronym criteria (Small,
Island, Developing, Sovereign) met by each of the 39 sovereign UN
OHRLLS SIDS members. The circular layout groups countries by
criteria score, making it easy to see at a glance how many members
satisfy all four components versus how many are partial fits.

**Files**
- `visualizations/sids_criteria_radial.R` — reproducible R/ggplot2 code
- `visualizations/sids_criteria_visualization_explainer.md` — methodology,
  findings, design notes, and citation guidance

**Requirements**

R packages: `tidyverse`, `ggtext`, `glue`

```r
install.packages(c("tidyverse", "ggtext", "glue"))
source("visualizations/sids_criteria_radial.R")
```

The script reads data directly from this repository and saves the output
as `sids_criteria_radial.png` in your working directory.

![SIDS criteria radial chart — how many of the four acronym criteria does each sovereign member meet?](https://raw.githubusercontent.com/University-of-Aruba/island-research-reference-data/main/visualizations/sids_criteria_radial.png)

*Each segment represents one of the 39 sovereign SIDS members, arranged radially and coloured
by the number of criteria met. The chart makes it immediately visible how many members satisfy
all four components of the acronym versus how many are partial fits — and in what proportion.*

**Citation**
> de Kort, R.E. (2026). *How many criteria does each SIDS member actually meet?* [Data visualization].
> Dutch Caribbean Digital Competence Network (DCDC), University of Aruba.
> GitHub. https://github.com/University-of-Aruba/island-research-reference-data

---

## How to use in KoboToolbox (XLSForm)

1. Copy the contents of `countries_reference_xlsform.csv` into the
   **choices** sheet of your XLSForm workbook.
2. In your **survey** sheet, create a `select_one countries` question
   where you want the country dropdown.
3. To show only a filtered subset (e.g., SIDS only), use a
   `select_one_from_file` approach or apply a choice filter referencing
   the `is_sids` column.

---

## How to use in R

```r
library(tidyverse)

countries <- read_csv(
  "https://raw.githubusercontent.com/University-of-Aruba/island-research-reference-data/main/countries/countries_reference_xlsform.csv",
  locale = locale(encoding = "UTF-8")
)

# Filter to all SIDS (sovereign + associate members)
sids_all <- countries |> filter(is_sids == 1)

# Filter to sovereign SIDS members only
sids_sovereign <- countries |> filter(sids_tier == "Sovereign member")

# Filter to associate SIDS members only
sids_associate <- countries |> filter(sids_tier == "Associate member")

# Filter to Dutch Kingdom territories
dutch_kingdom <- countries |> filter(political_association == "Dutch Kingdom")
```

---

## Versioning and updates

World Bank income group classifications are updated annually
(July each year). This dataset will be updated accordingly.
Check the commit history for the date of the last classification update.

| Version | Date | Notes |
|---|---|---|
| 1.0 | March 2026 | Initial release |
| 1.1 | March 2026 | Added sids_tier column; 18 associate members now flagged; criterion columns added; visualizations folder added |

---

## License

This dataset is released under the
[Creative Commons Attribution 4.0 International License](LICENSE)
(CC-BY-4.0). You are free to share and adapt the data for any
purpose, provided you give appropriate credit.

**Suggested citation:**
> de Kort, R.E. & University of Aruba Research. (2026). *Island Research
> Reference Data* (Version 1.1) [Dataset]. GitHub.
> https://github.com/University-of-Aruba/island-research-reference-data

---

## Contributing

Corrections and additions are welcome via pull request or by opening
an issue. Please reference your source when suggesting classification
changes.

---

## Contact

Maintained by Rendell Ernest de Kort through the
[Dutch Caribbean Digital Competence (DCDC) Network](https://dcdc.network/),
University of Aruba.
