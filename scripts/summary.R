# This file calculates summary information to be included
library(dplyr)
library(tidyverse)

# import race dataset
race_data <- read.csv("https://raw.githubusercontent.com/info201b-au20/project-covid/gh-pages/data/Race%20Data%20Entry%20-%20CRDT.csv")

# A function that takes in a dataset and returns a list of info about it:
summary_info <- list()
summary_info$num_observations <- nrow(race_data) # number of rows
summary_info$num_features <- ncol(race_data) # number of columns
columns <- colnames(race_data)

# The state that has had the highest number of cases
summary_info$state_highest_cases <- race_data %>%
  filter(Cases_Total == max(Cases_Total, na.rm = T)) %>%
  pull(State)

# The state that has had the highest number of cases of white Americans
summary_info$state_max_white <- race_data %>%
  filter(Cases_White == max(Cases_White, na.rm = T)) %>%
  pull(State)

# The state that has had the highest number of deaths
summary_info$most_deaths <- race_data %>%
  filter(Deaths_Total == max(Deaths_Total, na.rm = T)) %>%
  pull(State)

# The state that has had the highest number of cases of African Americans
summary_info$state_max_black <- race_data %>%
  filter(Cases_Black == max(Cases_Black, na.rm = T)) %>%
  pull(State)

# The state that has had the highest number of cases of Asian Americans
summary_info$state_max_asian <- race_data %>%
  filter(Cases_Asian == max(Cases_Asian, na.rm = T)) %>%
  pull(State)
