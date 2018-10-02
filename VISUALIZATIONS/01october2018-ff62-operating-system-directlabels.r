library(tidyverse)
library(directlabels)
# I found direct labels from this stack overflow thread:
# https://stackoverflow.com/questions/29357612/plot-labels-at-ends-of-lines
# output:
# https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/01october2018-ff62-operating-system-directlabels-Rplot13.png
week1_to_week3_os_tags <-
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1_TO_3/26september2018-week1-week3-weeknumber-tags.csv") %>% 
  filter(
    grepl("^windows-", tag) |
    grepl("^mac-os", tag) |
    (tag == "linux")) %>%
  mutate(os=ifelse(grepl("^windows-", tag), "windows", tag)) %>% 
  mutate(os=ifelse(grepl("^mac-os", tag), "mac-os", tag)) %>% 
  filter(tag != "windows-active-directory") %>% 
  group_by(os, week) %>%
  count()
label_at_end_week1_to_week3_os_line_plot <-
  ggplot(data=week1_to_week3_os_tags, aes(
    x=week, y=n, group= os, colour = os))
label_at_end_week1_to_week3_os_line_plot = label_at_end_week1_to_week3_os_line_plot + 
  geom_line(stat="identity") + 
  labs(color = 'Firefox 62 Desktop OS 5-25Sep2018') +
  scale_x_discrete(limits = c("1", "2", "3")) +
  geom_dl(aes(label = os), method = list(dl.trans(x = x + 0.2), "last.points", cex = 0.8)) +
  geom_dl(aes(label = os), method = list(dl.trans(x = x - 0.2), "first.points", cex = 0.8))
