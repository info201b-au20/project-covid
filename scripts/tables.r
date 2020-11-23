library(tidyverse)
library(readxl)
library(knitr)

race_data <- read.csv("./data/Race Data Entry - CRDT.csv")
county_age_cases <-
  read_excel("./data/PUBLIC_CDC_EVENT_DATE_SARS.xlsx", sheet = 1)

# Weekly new cases by age group in WA
weekly_cases_by_age <- county_age_cases %>%
  group_by(Date = WeekStartDate) %>%
  summarize(`Age 0-19` = sum(`Age 0-19`),
            `Age 20-39` = sum(`Age 20-39`),
            `Age 40-59` = sum(`Age 40-59`),
            `Age 60-79` = sum(`Age 60-79`),
            `Age 80+` = sum(`Age 80+`))

#AVerage weekly new cases by age group in WA
avg_weekly_cases_age <- weekly_cases_by_age %>%
  select(`Age 0-19`,
         `Age 20-39`,
         `Age 40-59`,
         `Age 60-79`,
         `Age 80+`) %>%
  gather(key = age_group, value = weekly_cases)

# Cumulative total cases of COVID by racial group in WA
cumulative_cases_by_race <- race_data %>%
  group_by(State) %>%
  filter(State == "WA") %>%
  arrange(Date) %>%
  summarize(Date = as.Date(as.character(Date), format = "%Y%m%d"),
            White = Cases_White,
            Black = Cases_Black,
            "Hispanic/Latino" = Cases_LatinX,
            Asian = Cases_Asian,
            "American Indian/Alaska Native" = Cases_AIAN,
            "Native Hawaiian/Pacific Islander" = Cases_NHPI,
            Multiracial = Cases_Multiracial,
            Other = Cases_Other,
            Unknown = Cases_Unknown) %>%
  filter(State == "WA") %>%
  # Excluded first 9 rows due to irregularity
  slice(- (1:9))

# Rate of increase of new COVID cases by racial group in WA (percent)
rate_cases_by_race <- race_data %>%
  group_by(State) %>%
  arrange(Date) %>%
  summarize(Date = as.Date(as.character(Date), format = "%Y%m%d"),
            White = ((as.numeric(Cases_White) - as.numeric(
              lag(Cases_White))) / as.numeric(lag(Cases_White))) * 100,
            Black = ((as.numeric(Cases_Black) - as.numeric(
              lag(Cases_Black))) / as.numeric(lag(Cases_White))) * 100,
            "Hispanic/Latino" = ((as.numeric(Cases_LatinX) - as.numeric(
              lag(Cases_LatinX))) / as.numeric(lag(Cases_LatinX))) * 100,
            Asian = ((as.numeric(Cases_Asian) - as.numeric(
              lag(Cases_Asian))) / as.numeric(lag(Cases_Asian))) * 100,
            "American Indian/Alaska Native" = ((
              as.numeric(Cases_AIAN) - as.numeric(
                lag(Cases_AIAN))) / as.numeric(lag(Cases_AIAN))) * 100,
            "Native Hawaiian/Pacific Islander" = ((
              as.numeric(Cases_NHPI) - as.numeric(
                lag(Cases_NHPI))) / as.numeric(lag(Cases_NHPI))) * 100,
            Multiracial = ((
              as.numeric(Cases_Multiracial) - as.numeric(
                lag(Cases_Multiracial))) / as.numeric(
                  lag(Cases_Multiracial))) * 100,
            Other = ((as.numeric(Cases_Other) - as.numeric(
              lag(Cases_Other))) / as.numeric(lag(Cases_Other))) * 100,
            Unknown = ((as.numeric(Cases_Unknown) - as.numeric(
              lag(Cases_Unknown))) / as.numeric(lag(Cases_Unknown))) * 100) %>%
  mutate_if(is.numeric, round, digits = 1) %>%
  filter(State == "WA") %>%
  # Excluded first 9 rows due to irregularity
  slice(- (1:9))

