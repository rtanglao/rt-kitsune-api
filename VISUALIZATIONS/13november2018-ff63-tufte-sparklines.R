library(tidyverse)
library(ggthemes)
roland_d63 <- read_csv("https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/ff63-antivirus-bookmarks-1st3weeks.csv")
# Calculate the min and max values, which.min returns the first (like your example):
mins <- group_by(roland_d63, issue.type) %>% slice(which.min(issue.count))
maxs <- group_by(roland_d63, issue.type) %>% slice(which.max(issue.count))
ends <- group_by(roland_d63, issue.type) %>% filter(daynumber == max(daynumber))
quarts <- roland_d63 %>%
  group_by(issue.type) %>%
  summarize(quart1 = quantile(issue.count, 0.25),
            quart2 = quantile(issue.count, 0.75)) %>%
  right_join(roland_d63)

p = ggplot(roland_d63, aes(x=daynumber, y=issue.count)) + 
  facet_grid(issue.type ~ ., scales = "free_y") + 
  geom_ribbon(data = quarts, aes(ymin = quart1, max = quart2), fill = 'grey90') +
  geom_line(size=0.3) +
  geom_point(data = mins, col = 'blue') +
  geom_text(data = mins, aes(label = issue.count), vjust = -1) +
  geom_point(data = maxs, col = 'red') +
  geom_text(data = maxs, aes(label = issue.count), vjust = 2) +
  geom_text(data = ends, aes(label = issue.count), hjust = 0) +
  geom_text(data = ends, aes(label = issue.type), hjust = 0, nudge_x = 1) +
  expand_limits(x = max(roland_d63$daynumber) + 
        (0.25 * (max(roland_d63$daynumber) - min(roland_d63$daynumber)))) +
  scale_x_continuous(breaks = seq(1, 21, 1)) +
  scale_y_continuous(expand = c(0.1, 0)) +
  theme_tufte(base_size = 15) +
  theme(axis.title=element_blank(),
        axis.text.y = element_blank(), 
        axis.ticks = element_blank(),
        strip.text = element_blank())
p
