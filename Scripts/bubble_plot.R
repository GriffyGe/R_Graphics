library(tidyverse)
library(rio)

kegg_enrich <- import("kegg_data.xlsx", sheet = 6)

ggplot(data = kegg_enrich,
       mapping = aes(x = kegg_enrich$`out (109)`/kegg_enrich$`All (1250)`,
                     y = reorder(kegg_enrich$Pathway, kegg_enrich$`out (109)`/kegg_enrich$`All (1250)`))) +
  geom_point(aes(size = kegg_enrich$`out (109)`,
                 color = kegg_enrich$Qvalue)) +
  scale_size(range = c(4,10), breaks = seq(10,50,20)) +
  scale_color_gradient(low = "#e84133",
                       high = "#1f78b4") +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0,1,0.2)) +
  labs(x = "Rich Factor",
       y = "KEGG Pathway",
       size = "Gene Number",
       color = "qvalue") +
  facet_grid(rows = vars(kegg_enrich$group),scales = "free",space = "free",
             as.table = FALSE) +
  theme_bw()
  

theme(panel.grid = element_blank())


geom_text(aes(label = sprintf("%0.2f", 
                                GeneRatio_in_background),
                x = GeneRatio_in_background + 20))