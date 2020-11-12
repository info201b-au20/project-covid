# This file calculates summary information to be included
library(dplyr)
library(tidyverse)

# import race dataset
race_data <- read.csv("./data/Race Data Entry - CRDT.csv")
# A function that takes in a dataset and returns a list of info about it:
summary_info <- list()
summary_info$num_observations <- nrow(race_data) # number of rows
summary_info$num_features <- ncol(race_data) # number of columns
columns <- colnames(race_data)
# The state that has had the highest number of cases until 10/28/2020
state_highest_cases <- race_data %>%
  filter(cases == max(Cases_Total)) %>%
  pull(State)
# The state that has had the lowest number of cases until 10/28/2020
state_lowest_cases <- race_data %>%
  filter(date == max(Date)) %>%
  filter(cases == min(Cases_Total)) %>%
  pull(State)
# The state that has had the highest number of deaths until 10/28/2020
most_deaths <- race_data %>%
  filter(cases == max(Deaths_Total)) %>%
  pull(State)
# The state that has had the lowest number of deaths until 10/28/2020
lowest_deaths <- race_data %>%
  filter(cases == min(Deaths_Total)) %>%
  pull(State)
# The total number of white Americans who tested positive for Covid-19 until 10/28/2020
total_cases_white <- race_data %>%
  filter(cases == max(Date)) %>%
  summarise(white_total = sum(Cases_White))
# The total number of African Americans who tested positive for Covid-19 until 10/28/2020
total_cases_black <- race_data %>%
  filter(cases == max(Date)) %>%
  summarise(black_total = sum(Cases_Black))
# The total number of Asian Americans who tested positive for Covid-19 until 10/28/2020
total_cases_asian <- race_data %>%
  filter(cases == max(Date)) %>%
  summarise(asian_total = sum(Cases_Asian))
# The total number of Hispanic Americans who tested positive for Covid-19 until 10/28/2020
total_cases_ethnicity_hispanic <- race_data %>%
  filter(cases == max(Date)) %>%
  summarise(ethnicity_hispanic_total = sum(Cases_Ethnicity_Hispanic))
# The total number of multiracial Americans who tested positive for Covid-19 until 10/28/2020
total_cases_multiracial <- race_data %>%
  filter(cases == max(Date)) %>%
  summarise(multiracial_total = sum(Cases_Multiracial))
