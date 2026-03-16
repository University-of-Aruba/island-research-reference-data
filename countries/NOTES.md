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
