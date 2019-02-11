library(tidyverse)
library(lubridate)
library(textclean)
library(directlabels)
suppressPackageStartupMessages(library(gmailr))
suppressPackageStartupMessages(library(purrr))
library(readr)

avast_avg_antirus_only <- 
  function(clean_df) {
    return(
      clean_df %>% 
        filter(
          grepl("avast|avg", text, ignore.case = TRUE)
          )
    )
}

script_main <- function()
{
args <- commandArgs(TRUE)
if(length(args) < 2) {
  args <- c("--help")
}
if("--help" %in% args) {
  cat("
      Arguments:
      csvfile emailflagyesorno
      --help              - print this text
      Example:
      Rscript plot-avg-and-avast-mentions-1st-week.r ff58-64.csv emailflag\n\n")

  q(save="no")
}

emailflag = FALSE
#debug(mongo_get_by_date)
if(args[2] == "yes") { emailflag = TRUE }

csvfile <- args[1]
print(csvfile)
print(emailflag)
raw_df <- read_csv(csvfile)
text_cleaned_df <- 
  raw_df %>% 
  unite(text, title, content, sep = " ") %>%
  mutate(text = replace_html(text))
avast_avg_only_df <- avast_avg_antirus_only(text_cleaned_df)
plot_avast_avg_only_df <- avast_avg_only_df %>% 
  mutate(firefoxversion = as.character(firefoxversion)) %>% 
  group_by(firefoxversion, day) %>%
  count()

plot <-
  ggplot(data=plot_avast_avg_only_df, 
         aes(
           x=day, y=n, group= firefoxversion, 
           colour = firefoxversion, 
           shape = firefoxversion))
plot = plot +
  geom_line(stat="identity") + 
  geom_point() +
  scale_x_discrete(limits = c("1", "2", "3", "4", "5", "6", "7")) 
q(save="no")
}

debug(script_main)
script_main()


# previous_df <-
#   mongo_get_by_date(
#     m,
#     as.integer(args[2]),
#     as.integer(args[3]),
#     as.integer(args[4])
#     )
# glimpse(previous_df)
# previous_df_clean <-
#   text_clean_kitsune_ff_desktop_questions(previous_df, previousrelease)
# glimpse(previous_df_clean)
# previous_df_release <-
#   previous_df_clean %>%
#   mutate(Firefox_Release = previousrelease)
# glimpse(previous_df_release)
# previous_df_release_release_week_number <-
#   add_release_week_number(
#     previous_df_release,
#     as.integer(args[2]),
#     as.integer(args[3]),
#     as.integer(args[4])
#     )
# glimpse(previous_df_release_release_week_number)
# glimpse(tail(previous_df_release_release_week_number))

# previous_release_3_weeks_antivirus_only <-
#   antivirus_only(previous_df_release_release_week_number)
# glimpse(previous_release_3_weeks_antivirus_only)

# # end of previous release

# # start of current release refactored

# currentrelease <- args[5]
# print(currentrelease)
# current_df <-
#   mongo_get_by_date(
#     m,
#     as.integer(args[6]),
#     as.integer(args[7]),
#     as.integer(args[8])
#   )
# glimpse(current_df)
# current_df_clean <-
#   text_clean_kitsune_ff_desktop_questions(current_df, currentrelease)
# glimpse(current_df_clean)
# current_df_release <-
#   current_df_clean %>%
#   mutate(Firefox_Release = currentrelease)
# glimpse(current_df_release)
# current_df_release_release_week_number <-
#   add_release_week_number(
#     current_df_release,
#     as.integer(args[6]),
#     as.integer(args[7]),
#     as.integer(args[8])
#   )
# glimpse(current_df_release_release_week_number)
# glimpse(tail(current_df_release_release_week_number))

# current_release_3_weeks_antivirus_only <-
#   antivirus_only(current_df_release_release_week_number)
# glimpse(current_release_3_weeks_antivirus_only)
# # end of current release refactored

# current_previous = bind_rows(
#   current_release_3_weeks_antivirus_only,
#   previous_release_3_weeks_antivirus_only)
# glimpse(current_previous)
# current_previous_to_plot <-
#   current_previous %>%
#   group_by(Firefox_Release, release_week_number) %>%
#   count()
# current_label <- paste(
#   currentrelease,
#   paste(
#   args[2],
#   args[3],
#   args[4],
#   sep = "-"
#   ),
#   sep = " "
# )
# previous_label <- paste(
#   previousrelease,
#   paste(
#     args[6],
#     args[7],
#     args[8],
#     sep = "-"
#   ),
#   sep = " "
# )
# plot <-
#   ggplot(data=current_previous_to_plot,
#          aes(
#            x=release_week_number, y=n, group= Firefox_Release,
#            colour = Firefox_Release,
#            shape = Firefox_Release))
# plot = plot +
#   geom_line(stat="identity") +
#   geom_point() +
#   scale_x_discrete(limits = c("week1", "week2", "week3")) +
#   geom_dl(aes(label = Firefox_Release), method = list(dl.trans(x = x + 0.2), "last.points", cex = 0.8)) +
#   geom_dl(aes(label = Firefox_Release), method = list(dl.trans(x = x - 0.2), "first.points", cex = 0.8)) +
#   scale_colour_discrete(
#     name = "Firefox Antivirus Mentions",
#     breaks = c(currentrelease, previousrelease),
#     labels = c(current_label, previous_label)
#   ) +
#   scale_shape_discrete(
#     name = "Firefox Antivirus Mentions",
#     breaks = c(currentrelease, previousrelease),
#     labels = c(current_label, previous_label)
#   ) +
#   scale_y_continuous(
#     breaks = function(x) unique(
#       floor(pretty(seq(0, (max(x) + 1) * 1.1)))))
# fn <- paste(
#   "antivirus-3weeks",
#   args[1],
#   args[2],
#   args[3],
#   args[4],
#   args[5],
#   args[6],
#   args[7],
#   args[8], sep="-"
# )
# t = now()
# fn_uniq <- paste0(paste(fn, "generated", year(t), month(t), day(t),hour(t),minute(t),
#       as.integer(second(t)),sep="-"), ".png")
# print(fn_uniq)
# ggsave(filename = paste(fn_uniq, ".png", sep =""), dpi = 320)
# if(emailflag) {
#   source("to_address.r")
#   email_sender <- 'rolandt@gmail.com'
#   use_secret_file("../rt-graphs.json")
#   mime() %>%
#     to(to_address) %>%
#     from(email_sender) %>%
#     #html_body(paste0(
#     #  "3 week FF Desktop antivirus mention comparison ", fn)) %>%
#     # flickr doesn't seem to parse text_body or html_body
#     text_body("generated by: https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/plot-antivirus-mentions-by-3weeks.r") -> html_msg
#   html_msg %>%
#     subject(
#       sprintf(
#         'FF Desktop Antivirus 3 weeks %s tags:%s %s antivirus antivirus3weeks firefox firefoxdesktop',
#         fn_uniq, previousrelease, currentrelease)) %>%
#     attach_file(paste0(fn_uniq, ".png")) -> file_attachment

#   send_message(file_attachment)
# }
# }
# debug(script_main)
# script_main()
