library(tidyverse)
library(stringr)
library(tokenizers)
library(tidytext)
library(textclean)
ff62_first3weeks =
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/created21october2018-ff62-5-25september-2018-questions-id-content-created-product-tags-topic-firefoxversion.csv"
  )
ff62_first3weeks_title_content_concatenated <-
  ff62_first3weeks %>%
  unite(text, title, content, sep = " ")
ff62_first3weeks_title_content_concatenated <-
  ff62_first3weeks_title_content_concatenated %>%
  mutate(text = replace_html(text))
tidy_ff62_first3weeks <-
  ff62_first3weeks_title_content_concatenated %>%
  unnest_tokens(word, text)
data(stop_words)
tidy_ff62_first3weeks <-
  tidy_ff62_first3weeks %>%
  anti_join(stop_words)
ff62_count <-
  tidy_ff62_first3weeks %>%
  count(word, sort = TRUE)
ff62_count <-
  ff62_count %>%
  filter(n > 100) %>%
  filter(!str_detect(
    word,
    "firefox|1|2|3|4|5|mozilla|7|8|9|ff|https|browser|computer"
  )) %>%
  mutate(word = reorder(word, n))
ff62_count <-
  ff62_count %>%
  mutate(firefoxversion = 62)

# start of Firefox 60
ff60_first3weeks =
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/created21october2018-ff60-9-29may2018-questions-id-content-created-product-tags-topic-firefoxversion.csv")
ff60_first3weeks_title_content_concatenated <-
  ff60_first3weeks %>%
  unite(text, title, content, sep = " ")
ff60_first3weeks_title_content_concatenated <-
  ff60_first3weeks_title_content_concatenated %>%
  mutate(text = replace_html(text))
tidy_ff60_first3weeks <-
  ff60_first3weeks_title_content_concatenated %>%
  unnest_tokens(word, text)
data(stop_words)
tidy_ff60_first3weeks <-
  tidy_ff60_first3weeks %>%
  anti_join(stop_words)
ff60_count <-
  tidy_ff60_first3weeks %>%
  count(word, sort = TRUE)
ff60_count <-
  ff60_count %>%
  filter(n > 100) %>%
  filter(!str_detect(
    word,
    "firefox|1|2|3|4|5|6|mozilla|7|8|9|ff|https|browser|computer"
  )) %>%
  mutate(word = reorder(word, n))
ff60_count <-
  ff60_count %>%
  mutate(firefoxversion = 60)
# end of Firefox 60

# start of Firefox 61
ff61_first3weeks =
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/created21october2018-ff61-26june-16july-2018-questions-id-content-created-product-tags-topic-firefoxversion.csv")
ff61_first3weeks_title_content_concatenated <-
  ff61_first3weeks %>%
  unite(text, title, content, sep = " ")
ff61_first3weeks_title_content_concatenated <-
  ff61_first3weeks_title_content_concatenated %>%
  mutate(text = replace_html(text))
tidy_ff61_first3weeks <-
  ff61_first3weeks_title_content_concatenated %>%
  unnest_tokens(word, text)
data(stop_words)
tidy_ff61_first3weeks <-
  tidy_ff61_first3weeks %>%
  anti_join(stop_words)
ff61_count <-
  tidy_ff61_first3weeks %>%
  count(word, sort = TRUE)
ff61_count <-
  ff61_count %>%
  filter(n > 100) %>%
  filter(!str_detect(
    word,
    "firefox|1|2|3|4|5|mozilla|7|8|9|ff|https|browser|computer"
  )) %>%
  mutate(word = reorder(word, n))
ff61_count <-
  ff61_count %>%
  mutate(firefoxversion = 61)
# end of Firefox 61
ff60_61_62 <- 
  ff60_count %>% 
  bind_rows(ff61_count) %>% 
  bind_rows(ff62_count) %>% 
  mutate(word = reorder(word, n))
  
ggplot(ff60_61_62, aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  facet_wrap(~ firefoxversion)
# which produces Rplot13
