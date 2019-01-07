library(mongolite)
library(tidyverse)
library(lubridate)
library(textclean)
library(directlabels)

args <- commandArgs(TRUE)
if(length(args) < 8) {
  args <- c("--help")
}
if("--help" %in% args) {
  cat(" 
      Arguments:
      currentrelease currentreleaseweekstart previsousrelease previousreleaseweekstart
      --help              - print this text 
      Example:
      Rscript plot-antivirus-mentions-by-week.r FF62 2018 9 5 FF63 2018 10 23\n\n")
  
  q(save="no")
}

previousrelease <- args[1]
print(previousrelease)
previous_release_start_date <- 
  make_datetime(as.integer(args[2]), as.integer(args[3]),as.integer(args[4]), 0,0,0, 
                                   tz = "America/Vancouver")
print(previous_release_start_date)

PREV_RELEASE_MAX_DATE = previous_release_start_date + days(7) - seconds(1)
print(PREV_RELEASE_MAX_DATE)
PREV_RELEASE_MIN_DATE = previous_release_start_date

m <- mongo("questions",
           url = "mongodb://127.0.0.1:27017/ff62questions")

query_str =
  sprintf(
    '{ "created" : { "$gte" : { "$date" : "%s"}, "$lte" : {"$date" : "%s"}}}',
    strftime(PREV_RELEASE_MIN_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    strftime(PREV_RELEASE_MAX_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")  )

previous_release_7_days_of_data_from_mongo <-
  m$find(
    query = query_str,
    fields =
      '{
    "_id" : 0,
    "id" : 1,
    "title" : 1,
    "content" : 1,
    "created" : 1
    }',
    sort = '{"created": 1}'
  )

base_yday = yday(previous_release_7_days_of_data_from_mongo[1,"created"])
previous_release_7_days_of_data <-
  previous_release_7_days_of_data_from_mongo %>%
  unite(text, title, content, sep = " ") %>%
  mutate(text = replace_html(text)) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[bB]ookmark?s', replacement = 'bookmark')) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[fF]irefox', replacement = '')) %>% 
  mutate(release_week_day_number = yday(created) - base_yday + 1) %>% 
  mutate(Firefox_Release = previousrelease)

glimpse(previous_release_7_days_of_data )
tail(previous_release_7_days_of_data)
print(previous_release_7_days_of_data_from_mongo[1,"created"])

antivirus_previous_release_7_days_of_data <-
  previous_release_7_days_of_data %>% 
  filter(
    grepl("antivirus|anti-virus|anti\\svirus", text, ignore.case = TRUE) |
      grepl("kaspersky|sophos|avast|avg", text, ignore.case = TRUE) |
      grepl("bitdefender|norton|mcafee|secureanywhere", text, ignore.case = TRUE) |
      grepl("trendmicro|trend\\smicro", text, ignore.case = TRUE) 
    )
      
glimpse(antivirus_previous_release_7_days_of_data)

# end of previous release

currentrelease <- args[5]
print(currentrelease)
current_release_start_date <- 
  make_datetime(as.integer(args[6]), as.integer(args[7]),as.integer(args[8]), 0,0,0, 
                tz = "America/Vancouver")
print(current_release_start_date)

CURR_RELEASE_MAX_DATE = current_release_start_date + days(7) - seconds(1)
print(CURR_RELEASE_MAX_DATE)
CURR_RELEASE_MIN_DATE = current_release_start_date

query_str =
  sprintf(
    '{ "created" : { "$gte" : { "$date" : "%s"}, "$lte" : {"$date" : "%s"}}}',
    strftime(CURR_RELEASE_MIN_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    strftime(CURR_RELEASE_MAX_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")  )

current_release_7_days_of_data_from_mongo <-
  m$find(
    query = query_str,
    fields =
      '{
    "_id" : 0,
    "id" : 1,
    "title" : 1,
    "content" : 1,
    "created" : 1
    }',
    sort = '{"created": 1}'
  )

base_yday = yday(current_release_7_days_of_data_from_mongo[1,"created"])
current_release_7_days_of_data <-
  current_release_7_days_of_data_from_mongo %>%
  unite(text, title, content, sep = " ") %>%
  mutate(text = replace_html(text)) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[bB]ookmark?s', replacement = 'bookmark')) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[fF]irefox', replacement = '')) %>% 
  mutate(release_week_day_number = yday(created) - base_yday + 1) %>% 
  mutate(Firefox_Release = currentrelease)

glimpse(current_release_7_days_of_data )
tail(current_release_7_days_of_data)
print(current_release_7_days_of_data_from_mongo[1,"created"])

antivirus_current_release_7_days_of_data <-
  current_release_7_days_of_data %>% 
  filter(
    grepl("antivirus|anti-virus|anti\\svirus", text, ignore.case = TRUE) |
      grepl("kaspersky|sophos|avast|avg", text, ignore.case = TRUE) |
      grepl("bitdefender|norton|mcafee|secureanywhere", text, ignore.case = TRUE) |
      grepl("trendmicro|trend\\smicro", text, ignore.case = TRUE) 
  )

glimpse(antivirus_current_release_7_days_of_data)
current_previous = bind_rows(
  antivirus_current_release_7_days_of_data, 
  antivirus_previous_release_7_days_of_data)
glimpse(current_previous)
current_previous_to_plot <-
  current_previous %>% 
  group_by(Firefox_Release, release_week_day_number) %>%
  count()
current_label <- paste(
  currentrelease,
  paste(
  args[2],
  args[3],
  args[4],
  sep = "-"
  ),
  sep = " "
)
previous_label <- paste(
  previousrelease,
  paste(
    args[6],
    args[7],
    args[8],
    sep = "-"
  ),
  sep = " "
)
plot <-
  ggplot(data=current_previous_to_plot, 
         aes(
           x=release_week_day_number, y=n, group= Firefox_Release, 
           colour = Firefox_Release, 
           shape = Firefox_Release))
plot = plot +
  geom_line(stat="identity") + 
  geom_point() +
  scale_x_discrete(limits = c("day1", "day2", "day3", "day4", "day5", "day6", "day7")) +
  geom_dl(aes(label = Firefox_Release), method = list(dl.trans(x = x + 0.2), "last.points", cex = 0.8)) +
  geom_dl(aes(label = Firefox_Release), method = list(dl.trans(x = x - 0.2), "first.points", cex = 0.8)) +
  scale_colour_discrete(
    name = "Firefox Antivirus Mentions",
    breaks = c(currentrelease, previousrelease),
    labels = c(current_label, previous_label)
  ) +
  scale_shape_discrete(
    name = "Firefox Antivirus Mentions",
    breaks = c(currentrelease, previousrelease),
    labels = c(current_label, previous_label)
  ) +
  scale_y_continuous(
    breaks = function(x) unique(
      floor(pretty(seq(0, (max(x) + 1) * 1.1))))) 
fn <- paste(
  "antivirus-1week", 
  args[1],
  args[2],
  args[3],
  args[4],
  args[5],
  args[6],
  args[7],
  args[8], sep="-"
) 
ggsave(filename = paste(fn, ".png", sep =""), dpi = 320)
quit()

