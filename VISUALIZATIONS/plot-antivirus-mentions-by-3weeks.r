library(mongolite)
library(tidyverse)
library(lubridate)
library(textclean)
library(directlabels)

source("mongo-get-3weeks-by-date.r")
source("text-clean-kitsune-ff-desktop-questions.r")
source("add-release-week-number.r")
source("antivirus-only.r")

args <- commandArgs(TRUE)
if(length(args) < 8) {
  args <- c("--help")
}
if("--help" %in% args) {
  cat(" 
      Arguments:
      currentrelease currentreleaseweekstart previousrelease previousreleaseweekstart
      --help              - print this text 
      Example:
      Rscript plot-antivirus-mentions-by-week.r FF62 2018 9 5 FF63 2018 10 23\n\n")
  
  q(save="no")
}

previousrelease <- args[1]

m <- mongo("questions",
           url = "mongodb://127.0.0.1:27017/ff62questions")

previous_df <- 
  mongo_get_by_date(
    m,
    as.integer(args[2]),
    as.integer(args[3]),
    as.integer(args[4])
    )
glimpse(previous_df)
previous_df_clean <- 
  text_clean_kitsune_ff_desktop_questions(previous_df)
glimpse(previous_df_clean)
previous_df_release <- 
  previous_df_clean %>%
  mutate(Firefox_Release = previousrelease)
glimpse(previous_df_release)
previous_df_release_release_week_number <-
  add_release_week_number(
    previous_df_release,
    as.integer(args[2]),
    as.integer(args[3]),
    as.integer(args[4])
    )
glimpse(previous_df_release_release_week_number)
glimpse(tail(previous_df_release_release_week_number))

previous_release_3_weeks_antivirus_only <-
  antivirus_only(previous_df_release_release_week_number)
glimpse(previous_release_3_weeks_antivirus_only)

# end of previous release

# start of current release refactored

currentrelease <- args[5]
print(currentrelease)
current_df <- 
  mongo_get_by_date(
    m,
    as.integer(args[6]),
    as.integer(args[7]),
    as.integer(args[8])
  )
glimpse(current_df)
current_df_clean <- 
  text_clean_kitsune_ff_desktop_questions(current_df)
glimpse(current_df_clean)
current_df_release <- 
  current_df_clean %>%
  mutate(Firefox_Release = currentrelease)
glimpse(current_df_release)
current_df_release_release_week_number <-
  add_release_week_number(
    current_df_release,
    as.integer(args[6]),
    as.integer(args[7]),
    as.integer(args[8])
  )
glimpse(current_df_release_release_week_number)
glimpse(tail(current_df_release_release_week_number))

current_release_3_weeks_antivirus_only <-
  antivirus_only(current_df_release_release_week_number)
glimpse(current_release_3_weeks_antivirus_only)
# end of current release refactored

current_previous = bind_rows(
  current_release_3_weeks_antivirus_only, 
  previous_release_3_weeks_antivirus_only)
glimpse(current_previous)
current_previous_to_plot <-
  current_previous %>% 
  group_by(Firefox_Release, release_week_number) %>%
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
           x=release_week_number, y=n, group= Firefox_Release, 
           colour = Firefox_Release, 
           shape = Firefox_Release))
plot = plot +
  geom_line(stat="identity") + 
  geom_point() +
  scale_x_discrete(limits = c("week1", "week2", "week3")) +
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
  "antivirus-3weeks", 
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

