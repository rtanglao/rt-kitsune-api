library(tidyverse)
library(readr)
df = read_csv(
  "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/ff62_operating_system_first3weeks.csv")
p = ggplot(df, aes(fill = group, ymax = percentage, ymin = 0, xmax = 2, xmin = 1)) +
  geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#ece8bd") +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + xlim(c(0, 2)) + ylim(c(0,2)) +
  geom_text(aes(x = 0, y = 0, label = label, colour=group), size=6.5, family="Poppins SemiBold") +
  geom_text(aes(x=1.5, y=1.5, label=title), family="Poppins Light", size=4.2) + 
  facet_wrap(~title, ncol = 7) +
  theme_void() +
  scale_fill_manual(values = c("red"="#C9146C", "orange"="#DA9112", "green"="#129188")) +
  scale_colour_manual(values = c("red"="#C9146C", "orange"="#DA9112", "green"="#129188")) +
  theme(strip.background = element_blank(),
        strip.text.x = element_blank()) +
  guides(fill=FALSE) +
  guides(colour=FALSE)
