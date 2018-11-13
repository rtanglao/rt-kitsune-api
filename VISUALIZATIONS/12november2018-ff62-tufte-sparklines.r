library(tidyverse)
library(ggthemes)
roland_d <- read_csv("https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/ff62-antivirus-bookmarks-1st3weeks.csv")
# Calculate the min and max values, which.min returns the first (like your example):
mins <- group_by(roland_d, issue.type) %>% slice(which.min(issue.count))
maxs <- group_by(roland_d, issue.type) %>% slice(which.max(issue.count))
ends <- group_by(roland_d, issue.type) %>% filter(daynumber == max(daynumber))
quarts <- roland_d %>%
  group_by(issue.type) %>%
  summarize(quart1 = quantile(issue.count, 0.25),
            quart2 = quantile(issue.count, 0.75)) %>%
  right_join(roland_d)

p = ggplot(roland_d, aes(x=daynumber, y=issue.count)) + 
  facet_grid(issue.type ~ ., scales = "free_y") + 
  geom_ribbon(data = quarts, aes(ymin = quart1, max = quart2), fill = 'grey90') +
  geom_line(size=0.3) +
  geom_point(data = mins, col = 'blue') +
  geom_text(data = mins, aes(label = issue.count), vjust = -1) +
  geom_point(data = maxs, col = 'red') +
  geom_text(data = maxs, aes(label = issue.count), vjust = 2) +
  geom_text(data = ends, aes(label = issue.count), hjust = 0) +
  geom_text(data = ends, aes(label = issue.type), hjust = 0, nudge_x = 1) +
  expand_limits(x = max(roland_d$daynumber) + 
        (0.25 * (max(roland_d$daynumber) - min(roland_d$daynumber)))) +
  scale_x_continuous(breaks = seq(1, 21, 1)) +
  scale_y_continuous(expand = c(0.1, 0)) +
  theme_tufte(base_size = 15) +
  theme(axis.title=element_blank(),
        axis.text.y = element_blank(), 
        axis.ticks = element_blank(),
        strip.text = element_blank())
p
