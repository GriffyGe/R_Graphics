# volcano plot ====
## 1. Packages preparation ====
library(tidyverse)
library(ggrepel)


## 2.Data import ====
volcano <- read_delim("data for R/volcano.csv")
ggplot(data = volcano,
       aes(x = `log2(FC)`,
           y = volcano$`FDR(-log10)`)) +
  geom_point() +
  geom_vline(xintercept = c(2, -2)) +
  geom_hline(yintercept = 10)

top10 <- head(reorder(volcano$id, volcano$`FDR(-log10)`,decreasing = TRUE), 10)
volcano$label <- if_else((volcano$id %in% top10), volcano$id, NA)

p1 <- ggplot(data = volcano,
             aes(x = `log2(FC)`,
                 y = `FDR(-log10)`,
                 label = label)) +
  geom_point(aes(color = test)) +
  geom_vline(xintercept = c(-2,2), linetype = "dashed", linewidth = 1.5/.pt) +
  geom_hline(yintercept = 10, linetype = 2, lwd = 1.5/.pt) +
  scale_color_manual(values = c("UP" = "red", "DOWN" = "blue", "NO" = "grey")) +
  coord_cartesian(ylim = c(-5, 250)) +
  labs(x = expression("Log"[2]*"(FC)"),
       y = expression("-Log"[10]*"(FDR)"),
       color = "Change") +
  theme_classic(base_line_size = 2.5/.pt) +
  theme(text = element_text(face = "bold")) +
  geom_text_repel(max.overlaps = Inf)

ggsave("vol_plot.svg", p1, width = , height = )

test <- case_when(
  (volcano$`log2(FC)` < -2 & volcano$`FDR(-log10)` > 10) ~ "DOWN",
  (volcano$`log2(FC)` > 2 & volcano$`FDR(-log10)` > 10) ~ "UP",
  TRUE ~ "NO"
)