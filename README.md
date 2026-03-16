# Island Research Reference Data

Open reference datasets for small island development research, 
maintained by the [University of Aruba](https://www.ua.aw) research 
community. Datasets are formatted for direct use in XLSForm-based 
survey tools (KoboToolbox, ODK) and for integration with R, Python, 
and other analysis environments.

All datasets follow [FAIR data principles](https://www.go-fair.org/fair-principles/): 
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

**Key classifications used**

*SIDS* — follows the official UN Office of the High Representative 
for the Least Developed Countries, Landlocked Developing Countries 
and Small Island Developing States 
([UN OHRLLS](https://www.un.org/ohrlls/content/list-sids)) list. 
Membership is determined by UN recognition, not by size or geographic 
criteria alone.

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

See `countries/NOTES.md` for detailed decisions on edge cases.

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

# Filter to SIDS only
sids <- countries |> filter(is_sids == 1)

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

---

## License

This dataset is released under the 
[Creative Commons Attribution 4.0 International License](LICENSE) 
(CC-BY-4.0). You are free to share and adapt the data for any 
purpose, provided you give appropriate credit.

**Suggested citation:**
> University of Aruba Research. (2026). *Island Research Reference 
> Data* (Version 1.0) [Dataset]. GitHub. 
> https://github.com/University-of-Aruba/island-research-reference-data

---

## Contributing

Corrections and additions are welcome via pull request or by opening 
an issue. Please reference your source when suggesting classification 
changes.

---
