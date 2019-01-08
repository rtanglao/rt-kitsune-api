mongo_get_by_date <- function(m, yyyy, mm, dd) {

  MIN_DATE <- 
    make_datetime(yyyy, mm, dd, 0,0,0, 
                  tz = "America/Vancouver")
  print(MIN_DATE)
  MAX_DATE = MIN_DATE + days(21) - seconds(1)
  print(MAX_DATE)
  
  query_str =
  sprintf(
    '{ "created" : { "$gte" : { "$date" : "%s"}, "$lte" : {"$date" : "%s"}}}',
    strftime(MIN_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    strftime(MAX_DATE, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")  )

return(
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
  ))
}