library(mongolite)
library(tidyverse)
library(lubridate)
library(textclean)

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

MAX_DATE = previous_release_start_date + days(7) - seconds(1)
print(MAX_DATE)
MIN_DATE = previous_release_start_date

m <- mongo("questions",
           url = "mongodb://127.0.0.1:27017/ff62questions")

query_str =
  sprintf(
    '{ "created" : { "$gte" : { "$date" : "%s"}, "$lte" : {"$date" : "%s"}}}',
    strftime(MIN_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    strftime(MAX_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")  )

one_day_of_data_from_mongo <-
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

base_yday = yday(one_day_of_data_from_mongo[1,"created"])
one_day_of_data <-
  one_day_of_data_from_mongo %>%
  unite(text, title, content, sep = " ") %>%
  mutate(text = replace_html(text)) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[bB]ookmark?s', replacement = 'bookmark')) %>%
  mutate(text  = str_replace_all(
    text, pattern = '[fF]irefox', replacement = '')) %>% 
  mutate(release_week_day_number = yday(created) - base_yday + 1)

glimpse(one_day_of_data )
tail(one_day_of_data)
print(one_day_of_data_from_mongo[1,2])
quit()

tidy_23oct <-
  one_day_of_data %>%
  unnest_tokens(word, text)
data(stop_words)
tidy_23oct <-
  tidy_23oct %>%
  anti_join(stop_words)
tidy_23oct <-
  tidy_23oct %>%
  count(word, sort = TRUE)
top150 <- head(tidy_23oct, 150)
names(top150) <- c("word", "freq")
wordcloud2(top150)
# can't export to PNG, it's just SVG but luckily in R studio you can open in firefox and take a screenshot
# isssue is here for this png export bug https://github.com/Lchiffon/wordcloud2/issues/8

