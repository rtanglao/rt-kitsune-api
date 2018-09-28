library(tidyverse)
week1_to_week3_os_tags <-
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1_TO_3/26september2018-week1-week3-weeknumber-tags.csv") %>% 
  filter(
    grepl("^windows-", tag) |
    grepl("^mac-os", tag) |
    (tag == "linux")) %>%
  mutate(os=ifelse(grepl("^windows-", tag), "windows", tag)) %>% 
  mutate(os=ifelse(grepl("^mac-os", tag), "mac-os", tag)) %>% 
  filter(tag != "windows-active-directory")
week1_to_week3_os_plot <-
  ggplot(data=week1_to_week3_os_tags, aes(x=week, fill=os))
week1_to_week3_os_plot = week1_to_week3_os_plot + 
  geom_bar(stat="bin", bins = 3,
  position="dodge")
week1_to_week3_os_line_plot <-
  ggplot(data=week1_to_week3_os_tags, aes(
    x=week, fill=os, colour = os))
week1_to_week3_os_line_plot = week1_to_week3_os_line_plot + 
  geom_line(stat="bin", bins = 3) + 
  scale_color_manual(values = c(
    'windows-10' = 'green',
    'linux' = 'purple',
    'mac-os' = 'orange',
    'windows-7' = 'pink',
    'windows-8' = 'blue',
    'windows-81' = 'brown',
    'windows-server-2016' = 'magenta',
    'windows-vista' = 'black',
    'windows-xp' = 'dark green')) +
  labs(color = 'FF62 OS 5-25Sep2018')
