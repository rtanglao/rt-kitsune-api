library(mongolite)
library(tidyverse)
m <- mongo("questions",
           url = "mongodb://127.0.0.1:27017/ff62questions")
MIN_DATE = strptime("2018-10-23 00:00:00 -0700", format = '%Y-%m-%d %H:%M:%S %z',
                    tz = "UTC")
MIN_DATE_STR = strftime(MIN_DATE, "%Y-%m-%dT%H:%M:%SZ", 'UTC')
MAX_DATE = strptime("2018-10-23 23:59:59 -0700",  format = '%Y-%m-%d %H:%M:%S %z',
                    tz = "UTC")
MAX_DATE_STR = strftime(MAX_DATE, "%Y-%m-%dT%H:%M:%SZ", 'UTC')
query_str =
  sprintf(
    '{ "created" : { "$gt" : { "$date" : "%s"}, "$lte" : {"$date" : "%s"}}}',
    MIN_DATE_STR,
    MAX_DATE_STR
  )

one_day_of_data <-
  m$find(
    query = query_str,
    fields =
      '{
    "_id" : 0,
    "id" : 1,
    "tags" : 1,
    "title" : 1,
    "content" : 1,
    "created" : 1
    }'
  )
