text_clean_kitsune_ff_desktop_questions <- function(df, previousrelease) {
  return(
    df  %>%
      unite(text, title, content, sep = " ") %>%
      mutate(text = replace_html(text)) %>%
      mutate(text  = str_replace_all(
        text, pattern = '[bB]ookmark?s', replacement = 'bookmark')) %>%
      mutate(text  = str_replace_all(
        text, pattern = '[fF]irefox', replacement = '')) %>% 
      mutate(Firefox_Release = previousrelease)
  )
}