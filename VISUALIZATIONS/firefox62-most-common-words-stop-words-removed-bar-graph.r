library(tidyverse)
library(stringr)
library(tokenizers)
library(tidytext)
library(textclean)
ff62_first3weeks = 
  read_csv(
    "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/VISUALIZATIONS/created-20october2018-5-25september-ff-desktop-questions-id-content-created-product-tags-title-topic.csv")
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
ff62_count %>% 
  filter(n > 100) %>% 
  filter(
    !str_detect(word, "firefox|1|2|3|4|5|mozilla|7|8|9|ff|https|browser|computer")) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() 
# which produces created20october2018-stop-words-removed-firefox62-first-3-weeks-most-common-words.png
# https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/created20october2018-stop-words-removed-firefox62-first-3-weeks-most-common-words.png
