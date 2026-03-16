# =============================================================================
# SIDS criteria matrix
# -----------------------------------------------------------------------------
# Author:      Rendell Ernest de Kort (2026)
# Affiliation: Dutch Caribbean Digital Competence Network (DCDC),
#              University of Aruba
# Repository:  https://github.com/University-of-Aruba/island-research-reference-data
# Description: Produces a criteria matrix testing all 39 sovereign UN OHRLLS
#              SIDS members against the four literal components of the acronym:
#              Small, Island, Developing, Sovereign.
# Output:      sids_criteria_matrix.png (9 x 12 inches, 200 dpi)
# =============================================================================

# ── Dependencies ──────────────────────────────────────────────────────────────
# Install once if needed:
# install.packages(c("tidyverse", "ggtext", "glue"))

library(tidyverse)
library(ggtext)
library(glue)

# ── 1. Data ingestion ─────────────────────────────────────────────────────────
# Reads directly from the public GitHub repository. Requires an internet
# connection. To run offline, download the CSV and replace the URL with
# a local file path: read_csv("path/to/countries_reference_xlsform.csv")

raw_url <- paste0(
  "https://raw.githubusercontent.com/University-of-Aruba/",
  "island-research-reference-data/main/countries/",
  "countries_reference_xlsform.csv"
)

countries <- read_csv(raw_url, locale = locale(encoding = "UTF-8"),
                      show_col_types = FALSE)

# ── 2. Sovereign SIDS subset for criteria matrix ──────────────────────────────
# Filters to sovereign members only. Associate members (Aruba, Curaçao, etc.)
# are excluded because the criterion framework presupposes statehood.

sids <- countries |>
  filter(sids_tier == "Sovereign member", !is.na(sids_tier)) |>
  select(label, criterion_small, criterion_island,
         criterion_developing, criterion_sovereign) |>
  mutate(across(starts_with("criterion_"), as.integer)) |>
  mutate(
    exceptions = rowSums(
      across(starts_with("criterion_"), \(x) 1L - x),
      na.rm = TRUE
    )
  )

# ── 3. Long format ────────────────────────────────────────────────────────────

criterion_labels <- c(
  criterion_small       = "**S** · Small\n*(pop. ≤ 1.5M)*",
  criterion_island      = "**I** · Island\n*(insular territory)*",
  criterion_developing  = "**D** · Developing\n*(non-high income)*",
  criterion_sovereign   = "**S** · Sovereign\n*(independent state)*"
)

sids_long <- sids |>
  pivot_longer(
    cols      = starts_with("criterion_"),
    names_to  = "criterion",
    values_to = "meets"
  ) |>
  mutate(
    criterion = factor(criterion,
                       levels = names(criterion_labels),
                       labels = criterion_labels),
    meets     = factor(meets, levels = c(1L, 0L),
                       labels = c("Meets", "Outside")),
    # descending sort: most exceptions at top of chart
    label     = fct_reorder(label, exceptions, .desc = TRUE)
  )

# ── 4. Palette & theme constants ──────────────────────────────────────────────

col_pass   <- "#749c4c"   # LovelyData green
col_out    <- "#f38439"   # LovelyData orange
col_multi  <- "#44759e"   # LovelyData blue — used for 2+ exception labels
col_bg     <- "white"
col_text   <- "#605b54"   # LovelyData gray-brown
col_stripe <- "#f5f5f0"   # warm gray for alternating row bands

# y-axis label colours: blue for entities with 2+ exceptions
y_order  <- levels(sids_long$label)
y_exc    <- sids |>
  mutate(label = as.character(label)) |>
  arrange(match(label, y_order)) |>
  pull(exceptions)

y_colours <- if_else(y_exc >= 2, col_multi, col_text)

# ── 5. Alternating row bands ──────────────────────────────────────────────────

row_bands <- tibble(
  label = y_order,
  y_pos = seq_along(y_order),
  fill  = if_else(y_pos %% 2 == 0, col_stripe, col_bg)
) |>
  filter(fill != col_bg)

# ── 6. Plot ───────────────────────────────────────────────────────────────────

p <- ggplot(sids_long, aes(x = criterion, y = label)) +

  # alternating row bands behind tiles
  geom_tile(
    data  = row_bands,
    aes(x = 2.5, y = label, width = 4.9, height = 1, fill = fill),
    inherit.aes = FALSE
  ) +
  scale_fill_identity() +

  # main criterion tiles
  geom_tile(aes(fill = meets), color = col_bg, linewidth = 0.9,
            width = 0.88, height = 0.82) +

  # circled cross on "Outside" cells — open circle layer
  geom_point(
    data  = filter(sids_long, meets == "Outside"),
    aes(x = criterion, y = label),
    shape = 21, size = 3.8,
    fill  = "white", color = col_out, stroke = 1.6,
    inherit.aes = FALSE
  ) +
  # cross inside circle
  geom_point(
    data  = filter(sids_long, meets == "Outside"),
    aes(x = criterion, y = label),
    shape = 4, size = 2.0,
    color = col_out, stroke = 1.1,
    inherit.aes = FALSE
  ) +

  scale_color_identity() +

  scale_fill_manual(
    values = c("Meets" = col_pass, "Outside" = col_out),
    name   = NULL,
    labels = c("Meets criterion", "Outside criterion")
  ) +

  scale_x_discrete(position = "top") +
  coord_cartesian(clip = "off") +

  labs(
    title    = "What SIDS actually means",
    subtitle = paste0(
      "39 officially recognised sovereign Small Island Developing States, tested against\n",
      "each component of the acronym they are assigned. Orange = outside criterion.\n",
      "Names in blue fall outside two or more criteria simultaneously."
    ),
    caption  = paste0(
      "Sources: UN OHRLLS SIDS list (39 sovereign members); ",
      "World Bank Atlas Method FY2025 (income groups); ",
      "Commonwealth Secretariat threshold ≤ 1.5M (small states).\n",
      "Note: 18 associate members including Aruba, Curaçao and Sint Maarten ",
      "appear on the full UN OHRLLS list but are not shown here.\n",
      "Rendell Ernest de Kort (2026) — Dutch Caribbean Digital Competence Network (DCDC), University of Aruba"
    )
  ) +

  theme_minimal(base_size = 11) +
  theme(
    plot.background   = element_rect(fill = col_bg, color = NA),
    panel.background  = element_rect(fill = col_bg, color = NA),
    panel.grid        = element_blank(),

    axis.title        = element_blank(),
    axis.text.x       = element_markdown(
                          color = col_text, size = 8.5,
                          lineheight = 1.4, hjust = 0.5
                        ),
    axis.text.y       = element_text(color = y_colours, size = 8.5),

    legend.position   = "bottom",
    legend.key.size   = unit(0.4, "cm"),
    legend.text       = element_text(color = col_text, size = 9),
    legend.spacing.x  = unit(0.3, "cm"),

    plot.title        = element_text(color = col_text, face = "bold",
                                     size = 16, margin = margin(b = 4)),
    plot.subtitle     = element_text(color = col_text, size = 8.5,
                                     lineheight = 1.45,
                                     margin = margin(b = 16)),
    plot.caption      = element_text(color = "#9e9890", size = 7,
                                     hjust = 0, lineheight = 1.35,
                                     margin = margin(t = 10)),
    plot.margin       = margin(16, 30, 12, 16)
  )

# ── 7. Save ───────────────────────────────────────────────────────────────────

ggsave(
  "sids_criteria_matrix.png",
  plot   = p,
  width  = 9,
  height = 12,
  dpi    = 200,
  bg     = col_bg
)

message("Saved: sids_criteria_matrix.png")
