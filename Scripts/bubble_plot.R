# 1. Packages preparation ====
library(tidyverse)
library(rio)

# 2. Data import ====
kegg_enrich <- import("Example_file/bubble_plot_data.xlsx")

# 3. Data visualization ====
ggplot(data = kegg_enrich,
       mapping = aes(x = interest_gene_set/background_gene,
                     y = reorder(Pathway, interest_gene_set/background_gene))) +
  geom_point(aes(size = interest_gene_set,
                 color = Qvalue)) +
  scale_size(range = c(4,10), 
             breaks = seq(10,50,20)) +
  scale_color_gradient(low = "#e84133",
                       high = "#1f78b4") +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0,1,0.2)) +
  labs(x = "Rich Factor",
       y = "KEGG Pathway",
       size = "Gene Number",
       color = "qvalue") +
  facet_grid(rows = vars(kegg_enrich$group),
             scales = "free",space = "free",
             #as.table -> change the relative position of subplots
             #Here, "down" is the upper panel by default. -> Set: as.table = FALSE -> "down" becomes the bottom panel
             as.table = FALSE) +
  theme_bw()