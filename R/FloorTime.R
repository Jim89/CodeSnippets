# FloorTime - Round a time DOWN with arbitrary precision
# source: http://stackoverflow.com/questions/16803867/round-a-date-in-r-to-an-arbitrary-level-of-precision
FloorTime <- function (x, k = 1, unit = c("second", "minute", "hour", "day",
                                          "week", "month", "year")) {
# Function requires lubridate - load it
  library(lubridate, quietly=T)

  nmax <- NULL

  switch(unit, second = {nmax <- 60},
               minute = {nmax <- 60},
               hour = {nmax <- 24})

  cuts <- seq(from = 0, to = nmax - 1, by = k)

# Rounds times down to the nearest kth unit interval
  rounded <-switch(unit,
            second = update(x, seconds = cuts[findInterval(second(x), cuts)]),
            minute = update(x, minutes = cuts[findInterval(minute(x), cuts)],
                               seconds = 0),
            hour   = update(x, hours = cuts[findInterval(hour(x), cuts)],
                               minutes = 0, seconds = 0),
            day    = update(x, hours = 0, minutes = 0, seconds = 0),
            week   = update(x, wdays = 1, hours = 0, minutes = 0, seconds = 0),
            month  = update(x, mdays = 1, hours = 0, minutes = 0, seconds = 0),
            year   = update(x, ydays = 1, hours = 0, minutes = 0, seconds = 0))
  return(rounded)
}