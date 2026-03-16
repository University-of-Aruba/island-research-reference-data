# SIDS criteria matrix: visualization guide

**Author**: Rendell Ernest de Kort (2026)  
**Affiliation**: Dutch Caribbean Digital Competence Network (DCDC), University of Aruba  
**Dataset**: `countries/countries_reference_xlsform.csv` in this repository  
**Code**: `visualizations/sids_criteria_matrix.R`

---

## What this visualization shows

The SIDS criteria matrix tests each of the 39 sovereign member states on
the official UN OHRLLS Small Island Developing States list against the
four literal components of the acronym they are assigned: **S**mall,
**I**sland, **D**eveloping, and **S**overeign.

The motivation is analytical transparency. The SIDS classification is
used to determine eligibility for international development programmes,
climate finance mechanisms, and preferential trade arrangements. Yet the
classification logic is rarely interrogated on its own terms. This
visualization makes that interrogation visible: which entities on the
list actually satisfy each component of the name?

The chart is not a critique of the SIDS framework. It is a diagnostic
tool. Many of the apparent mismatches reflect deliberate policy decisions
— for example, the inclusion of mainland Caribbean states like Suriname
and Guyana on the basis of shared economic vulnerabilities rather than
strict insularity — and understanding those decisions is as important as
identifying the mismatches.

---

## How to read the chart

Each row is one of the 39 sovereign SIDS. Each column tests one
criterion. A green tile indicates the entity meets the criterion. An
orange tile with a circled cross indicates it falls outside the
criterion.

Rows are sorted by the number of criteria not met, descending, so the
most anomalous cases appear at the top. Country names rendered in blue
fall outside two or more criteria simultaneously.

---

## Criteria definitions

| Criterion | Definition | Source |
|---|---|---|
| **S** · Small | Population ≤ 1.5 million | Commonwealth Secretariat / World Bank small states threshold |
| **I** · Island | Territory exists entirely on island or archipelago landmass, with no shared continental land border | Geographic |
| **D** · Developing | World Bank income group is not High income | World Bank Atlas Method FY2025 |
| **S** · Sovereign | Political association = Independent (sovereign UN member state) | UN membership / constitutional status |

### Notes on threshold choices

The population threshold of 1.5 million is used by the Commonwealth
Secretariat and World Bank in their small states programmes and is
grounded in political economy rather than physical size. It reflects
the scale at which structural vulnerabilities — limited diversification,
high import dependence, exposure to external shocks — typically become
binding constraints on development. An area-based threshold (such as
≤ 700 km²) would produce a different but partially overlapping set of
anomalies and is not used here.

The income-based developing criterion uses the World Bank Atlas Method
because it is the most widely cited and consistently updated income
classification in development economics. It does not capture structural
vulnerabilities such as debt-to-GDP ratios, climate exposure, or the
high per-unit cost of resilience investment. The graduation problem —
where SIDS that have formally crossed the high-income threshold
continue to face SIDS-specific vulnerabilities — is an active area of
policy debate and is directly illustrated by this chart.

---

## Key findings

**Outside the small criterion (population > 1.5 million)**: Cuba,
Dominican Republic, Haiti, Jamaica, Papua New Guinea, Singapore, and
Bahrain (borderline at 1.7 million). This is the largest source of
variation within the list.

**Outside the island criterion**: Belize, Guinea-Bissau, Guyana, and
Suriname. All four are included on the basis of Caribbean or Atlantic
vulnerability profiles rather than strict insularity.

**Outside the developing criterion (World Bank High income)**:
Antigua and Barbuda, Bahamas, Bahrain, Barbados, Nauru, Palau,
Saint Kitts and Nevis, Seychelles, Singapore, and Trinidad and Tobago.
More than one in four sovereign SIDS currently hold High income status,
which illustrates the graduation problem directly.

**Outside the sovereign criterion**: Cook Islands and Niue, both
self-governing in free association with New Zealand. These are the only
two sovereign-list members whose political status is not full
UN-recognised independence.

**Outside two or more criteria simultaneously**: Singapore (not small,
not developing), Bahrain (not small, not developing). These are the
most internally anomalous entries relative to the acronym's literal
meaning, and both their continued presence on the list reflects the
political and historical dimensions of SIDS membership that income and
size metrics do not fully capture.

---

## Design notes

The visualization uses the LovelyData color palette:

| Role | Color | Hex |
|---|---|---|
| Meets criterion | Green | `#749c4c` |
| Outside criterion | Orange | `#f38439` |
| Multi-exception label | Blue | `#44759e` |
| Text | Gray-brown | `#605b54` |
| Row bands | Warm gray | `#f5f5f0` |

The criterion column headers bold the relevant letter of the SIDS
acronym using `ggtext::element_markdown`, connecting the column
directly to the concept it tests. Row sorting places the most
anomalous cases at the top without requiring the reader to search for
them. Country names in blue provide a second visual layer for
identifying multi-criterion cases without adding text annotations.

---

## Scope and limitations

This visualization covers the 39 sovereign members of the UN OHRLLS
SIDS list only. The 18 associate members — including Aruba, Curaçao,
Sint Maarten, and 15 other non-sovereign territories — are noted in
the caption but not plotted, because the criterion framework presupposes
statehood and produces analytically misleading results when applied to
non-sovereign entities.

World Bank income group classifications are updated annually each July.
The chart should be regenerated after each annual update to remain
current. The current classification reflects World Bank FY2025 data.

---

## Suggested citation

> de Kort, R.E. (2026). *SIDS criteria matrix* [Data visualization].
> Dutch Caribbean Digital Competence Network (DCDC), University of Aruba.
> GitHub. https://github.com/University-of-Aruba/island-research-reference-data
