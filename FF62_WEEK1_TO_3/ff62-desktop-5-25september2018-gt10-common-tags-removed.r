library(stringr)
week1_to_week3_tags_gt_10 <-
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1_TO_3/26september2018-week1-week3-weeknumber-tags.csv") %>% 
  group_by(tag) %>%
  count() %>% 
  filter(n >10)  
week1_to_week3_tags_gt_10_common_tags_removed <-
  week1_to_week3_tags_gt_10 %>% 
  filter(tag != "desktop" &
           tag != "escalate" &
           tag != "beta" &
           !str_detect(tag, "^esr") &
           tag != "linux" &
           !str_detect(tag, "^mac-os-") &
           tag != "needsinfo" &
           tag != "other" &
           tag != "rolandff62experiment" &
           !str_detect(tag, "^windows-") &
           !str_detect(tag, "^firefox-"))

common_tags_removed_plot <- 
  ggplot(data = week1_to_week3_tags_gt_10_common_tags_removed, aes(x=tag, y=n))
common_tags_removed_plot = common_tags_removed_plot + geom_bar(stat = "identity")
common_tags_removed_plot = common_tags_removed_plot + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

