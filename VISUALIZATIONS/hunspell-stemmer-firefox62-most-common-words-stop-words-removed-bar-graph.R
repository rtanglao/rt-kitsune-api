library(tidyverse)
library(stringr)
library(tokenizers)
library(tidytext)
library(textclean)
library(SnowballC)
library(hunspell)
my_hunspell_stem <- function(token) {
  stem_token <- hunspell_stem(token)[[1]]
  if (length(stem_token) == 0) return(token) else return(stem_token[1])
}
vec_hunspell_stem <- Vectorize(my_hunspell_stem, "token")
# above code (vec_hunspell_stem and my_hunspell_stem) is from:
# https://fivethirtyeight-r.netlify.com/articles/trump_twitter.html
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
  unnest_tokens(word, text)  %>%
  mutate(word = vec_hunspell_stem(word))
  #mutate(word = hunspell_stem(word))
#  mutate(word = wordStem(word, language="en"))
  #mutate_at("word", funs(wordStem((.), language="en")))  
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
# which produces:
# https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/hunspell-stemmer-firefox62-most-common-words-stop-words-removed-bar-graph.png
