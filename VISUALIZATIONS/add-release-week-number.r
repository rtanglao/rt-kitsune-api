add_release_week_number <- function(
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
        release_week_number = 
        floor(
            interval(START_DATE, created) / days(7)
            ) + 1
        )
  )
}