# Dataset notes: country reference list

## Known decisions and edge cases

**BES islands disaggregated**
Bonaire, Sint Eustatius, and Saba are listed as three separate rows 
despite sharing the ISO 3166-1 alpha-2 code BQ. Each carries a unique 
name code (BQ_BO, BQ_SE, BQ_SA) for XLSForm compatibility. The 
iso_code column retains the official ISO subdivision codes 
(BQ-BO, BQ-SE, BQ-SA).

**Netherlands in Dutch Kingdom**
The Netherlands is assigned political_association = "Dutch Kingdom" 
rather than "Independent" to reflect its status as a constituent 
country of the Kingdom of the Netherlands alongside Aruba, Curaçao, 
and Sint Maarten.

**Montserrat as SIDS and SNIJ**
Montserrat is the only non-sovereign territory on the official UN 
OHRLLS SIDS list and is therefore flagged is_sids = 1 and 
is_snij = 1 simultaneously.

**World Bank unclassified territories**
Territories without standalone World Bank classification 
(e.g., Bouvet Island, French Southern Territories, Tokelau) 
carry blank values in wb_region and wb_income_group rather than 
inheriting parent country values.

**SIDS not on official list**
French Polynesia and American Samoa are not flagged as SIDS despite 
frequent appearance in island development literature, because they do 
not appear on the official UN OHRLLS list. Researchers should note 
this distinction.

**Encoding**
This file is UTF-8 encoded. Special characters (Å, ç, é, ã, etc.) 
will display incorrectly if opened with non-UTF-8 encoding. In Excel, 
use Data > From Text/CSV and specify UTF-8 encoding on import.

## SIDS classification criteria columns

Four binary columns have been added to expose the internal logic — and tensions — of the SIDS classification. Each column asks whether a given entity actually satisfies the literal component of the acronym it is assigned to. These columns apply to all rows in the dataset, not only to entities flagged `is_sids = 1`, enabling comparative analysis across the full country and territory list.

| Column | Question asked | Threshold / rule |
|---|---|---|
| criterion_small | Is the population below the small states threshold? | Population ≤ 1.5 million (Commonwealth Secretariat / World Bank small states definition) |
| criterion_island | Is the territory entirely on island or archipelago landmass? | Geographic: no shared continental land border with a larger sovereign territory |
| criterion_developing | Is the economy classified below high income? | World Bank Atlas Method FY2025: any income group other than High income |
| criterion_sovereign | Is the territory a recognised sovereign state? | political_association = "Independent" |

Blank values in criterion columns indicate that the criterion is not meaningfully applicable (e.g., Antarctica, uninhabited territories).

---

### Threshold notes and limitations

**criterion_small** uses the 1.5 million population threshold adopted by the Commonwealth Secretariat and World Bank for their small states programmes. This threshold is grounded in political economy rather than physical geography — it reflects the scale at which structural economic vulnerabilities (limited diversification, high import dependence, exposure to external shocks) typically manifest. An alternative area-based threshold (e.g., ≤ 700 km², as sometimes used in island biogeography) would produce a partially overlapping but distinct set of anomalies and is not used here. Researchers applying area-based definitions should note this distinction.

**criterion_island** is applied strictly. Belize, Guinea-Bissau, Guyana, and Suriname are classified as non-islands because their primary territory is on a continental landmass, despite their recognition as Caribbean SIDS. This reflects a geographic rather than geopolitical reading of "island." The UN OHRLLS list accepts these states on the basis of shared Caribbean economic and environmental vulnerabilities, not strict insularity.

**criterion_developing** follows the World Bank FY2025 income group classification using the Atlas Method. High income economies are treated as not developing for the purposes of this column. The World Bank updates income group thresholds annually each July; this column should be reviewed and updated accordingly.

**criterion_sovereign** is derived directly from the `political_association` column. Entities assigned "Independent" receive a value of 1. Note that the Netherlands is assigned `political_association = "Dutch Kingdom"` rather than "Independent" to reflect its status as a constituent country of the Kingdom of the Netherlands, and therefore receives `criterion_sovereign = 0`. This is a deliberate and internally consistent classification decision; see the Dutch Kingdom note above for further explanation.

---

### Anomalies within the official SIDS list

The following entities are officially recognised as SIDS by the UN OHRLLS but do not satisfy one or more of the literal criteria of the acronym. These cases are not errors in the dataset — they reflect genuine ambiguities in the classification framework and are documented here to support transparent research use.

**Not small** (population > 1.5 million)

| Entity | Approximate population | Note |
|---|---|---|
| Cuba | 11 million | Largest Caribbean island by population and area |
| Dominican Republic | 11 million | |
| Haiti | 11 million | |
| Papua New Guinea | 10 million | Also the largest SIDS by land area |
| Singapore | 6 million | Also fails criterion_developing |
| Jamaica | 3 million | |
| Bahrain | 1.7 million | Borderline; included on the basis of exceeding threshold |

**Not an island**

| Entity | Note |
|---|---|
| Belize | Continental Central America; included on basis of Caribbean vulnerability profile |
| Guinea-Bissau | West African mainland and archipelago; continental portion is primary territory |
| Guyana | South American mainland |
| Suriname | South American mainland |

**Not developing** (World Bank High income, FY2025)

Antigua and Barbuda, Bahamas, Bahrain, Barbados, Montserrat, Nauru, Palau, Saint Kitts and Nevis, Seychelles, Singapore, Trinidad and Tobago.

Eleven of the 39 sovereign SIDS — more than one in four — are currently classified as High income by the World Bank. This finding reflects the graduation problem in SIDS policy discourse: income metrics do not capture structural vulnerabilities such as debt-to-GDP ratios, climate exposure, or the high cost of resilience investment relative to economic size.

**Not sovereign**

| Entity | Status |
|---|---|
| Cook Islands | Self-governing in free association with New Zealand |
| Montserrat | British Overseas Territory; also fails criterion_developing |
| Niue | Self-governing in free association with New Zealand |

Montserrat is the only non-sovereign territory on the official UN OHRLLS SIDS list, and it simultaneously fails the developing criterion, making it the most anomalous entry relative to the acronym's literal meaning.

**Entities failing multiple criteria**

| Entity | Criteria not met |
|---|---|
| Singapore | criterion_small, criterion_developing |
| Bahrain | criterion_small, criterion_developing |
| Montserrat | criterion_developing, criterion_sovereign |

These double failures are analytically significant. Singapore in particular — a high-income, densely populated city-state — represents the furthest outlier from the conventional SIDS profile, and its continued inclusion on the list is a recurring subject of debate in the small island development literature.

---

### Suggested citation for this analytical framework

The four-criterion decomposition of the SIDS acronym used in this dataset draws on the broader critique of SIDS classification logic discussed in:

> Briguglio, L. (1995). Small island developing states and their economic vulnerabilities. *World Development*, 23(9), 1615–1632.

> Pelling, M. & Uitto, J.I. (2001). Small island developing states: natural disaster vulnerability and global change. *Environmental Hazards*, 3(2), 49–62.

Researchers using these columns in published work should document the thresholds applied and the date of the World Bank income classification used.


## sids_tier column

The `sids_tier` column distinguishes between the two membership categories
within the full UN OHRLLS SIDS list of 57 entries. The `is_sids` column
flags all 57 entries with a value of 1, while `sids_tier` provides the
finer distinction needed for analysis.

| Value | Count | Description |
|---|---|---|
| `Sovereign member` | 39 | UN member states recognised as SIDS |
| `Associate member` | 18 | Non-sovereign territories that are associate members of UN Regional Commissions |
| *(blank)* | — | Not on the UN OHRLLS SIDS list |

**Associate members** are non-sovereign territories recognised under the
SIDS framework through their associate membership of regional intergovernmental
bodies (Caribbean Community, Pacific Islands Forum, Indian Ocean Commission).
They share the structural vulnerabilities of SIDS but lack sovereign UN member
status. The 18 associate members in this dataset are: American Samoa, Anguilla,
Aruba, Bermuda, British Virgin Islands, Cayman Islands, Curaçao, French
Polynesia, Guadeloupe, Guam, Martinique, Montserrat, New Caledonia,
Northern Mariana Islands, Puerto Rico, Sint Maarten, Turks and Caicos Islands,
and US Virgin Islands.

**Note on Montserrat**: Montserrat appears on the official UN OHRLLS list
and was previously flagged `is_sids = 1` in this dataset as a sovereign member.
It is correctly classified as an associate member given its status as a British
Overseas Territory. It remains analytically notable as the only associate member
that would also fail the `criterion_developing` test under the World Bank
FY2025 classification.

**Note on Aruba, Curaçao, and Sint Maarten**: All three are constituent
countries of the Kingdom of the Netherlands and are classified as associate
members. They are assigned `political_association = "Dutch Kingdom"` and
`is_snij = 1` in this dataset, reflecting their dual status as both SIDS
associate members and sub-national island jurisdictions.

### Usage guidance

To filter the full SIDS list: `filter(is_sids == 1)`

To filter sovereign members only: `filter(sids_tier == "Sovereign member")`

To filter associate members only: `filter(sids_tier == "Associate member")`

The criterion columns (`criterion_small`, `criterion_island`,
`criterion_developing`, `criterion_sovereign`) are populated for all rows
where `sids_tier == "Sovereign member"`. They are intentionally left blank
for associate members because sovereignty is a prerequisite for the
criterion framework to be analytically coherent — testing a non-sovereign
territory against a criterion that presupposes statehood produces
misleading results.
