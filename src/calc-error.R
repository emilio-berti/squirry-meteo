suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))

setwd("~/squirry-meteo")

files <- list.files("olddata")
dates <- str_split(files, "_", simplify = TRUE)[, 1] %>%
  date()
times <- str_split(files, "_", simplify = TRUE)[, 2] %>%
  gsub(".csv", "", .) %>%
  hms()

datetimes <- ymd_hms(paste(dates, times))

for (f in files) 

test <- function(file, dts) {
  d <- read_csv(paste0("olddata/", file))
  f_datetimes <- sapply(d$date, function(x) {
    gsub("(-\\d\\d)(\\d\\d)", "\\1-\\2", x)
    })
  f_datetimes <- ymd_hm(f_datetimes)
  ids <- which(round_date(dts, unit = "minute") %in% round_date(f_datetimes, unit = "minute"))
  
  read_csv(paste0("olddata/", files[ids][1]))


  delta <- difftime(f_datetimes, datetime, units = "hours") %>%
    as.vector()

  ans <- tibble(delta.t = delta, temp = d$Leipzig) %>%
    filter(delta > 0)
  return(ans)
}

test(files[1], datetimes[1])

