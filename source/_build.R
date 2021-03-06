# Scape Data and Construct Data Sets

# UPDATE date value
date <- lubridate::mdy("04-21-2020")

# UPDATE city zip's with < 5 or 0 cases
city_lt5 <- c("63105", "63117", "63119", "63125", "63130", "63133", "63137", "63143")

# UPDATE city and county race data
# white, black, asian, 2+
county_race_counts <- c(617, 851, 25, 75)
city_race_counts <- c(204, 615, 18, NA)

# dependencies
library(dplyr)
library(lubridate)
library(purrr)
library(readr)
library(sf)
library(tigris)
library(zoo)

# functions
source("source/functions/get_data.R")
source("source/functions/historic_expand.R")
source("source/functions/wrangle_zip.R")

# workflow
source("source/workflow/build/01_scrape_and_tidy.R")
source("source/workflow/build/02_create_state_msa.R")
source("source/workflow/build/03_add_rates.R")
source("source/workflow/build/04_create_spatial.R")
source("source/workflow/build/05_create_zip.R")
source("source/workflow/build/06_create_individual.R")

# update interactive map
rmarkdown::render(input = "docs/index.Rmd",
                  params = list(
                    date = paste0("Current as of ", as.character(date)),
                    date_val = as.character(date),
                    prior_date_val = as.character(date-7)
                  ))

# update README
rmarkdown::render(input = "README.Rmd",
                  params = list(
                    date_val = as.character(date)
                  ))

# delete README.html
fs::file_delete("README.html")

# clean-up
rm(pal, snapshot, date, zip_snapshot, map_breaks, map_bins, bins, round_any,
   data_table, state_data, stl_city_data, stl_county_data, kc_city_data)
