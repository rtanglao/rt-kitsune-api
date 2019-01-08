add_release_day_number <- function(
  df_release,
  yyyy,
  mm,
  dd
) 
{
  
  START_DATE <- 
  make_datetime(
    yyyy, mm, dd, 0,0,0, 
    tz = "America/Vancouver"
    )
  
  return (
    df_release %>% 
      mutate(
        release_week_day_number = 
        floor(
            interval(START_DATE, created) / days(1)
            ) + 1
        )
  )
}