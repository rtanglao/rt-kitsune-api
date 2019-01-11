antivirus_only <- 
  function(previous_df_release_release_week_day_number)
    {
      return(
      previous_df_release_release_week_day_number %>% 
        filter(
        grepl("antivirus|anti-virus|anti\\svirus", text, ignore.case = TRUE) |
        grepl("kaspersky|sophos|avast|avg", text, ignore.case = TRUE) |
        grepl("bitdefender|norton|mcafee|secureanywhere", text, ignore.case = TRUE) |
        grepl("trendmicro|trend\\smicro", text, ignore.case = TRUE) |
        grepl("nod32|avira|secureanywhere|fsecure|f-secure|symantec", 
              text, ignore.case = TRUE)
        )
      )
  }