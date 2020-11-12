library(tidyverse)
library(readxl)
library(knitr)

race_data <- read.csv("./data/Race Data Entry - CRDT.csv")
county_age_cases <-
  read_excel("./data/PUBLIC_CDC_EVENT_DATE_SARS.xlsx", sheet = 1)

# Weekly new cases in each age group in WA
weekly_county_age_cases <- county_age_cases %>%
  group_by(Date = WeekStartDate) %>%
  summarize(`Age 0-19` = sum(`Age 0-19`),
            `Age 20-39` = sum(`Age 20-39`),
            `Age 40-59` = sum(`Age 40-59`),
            `Age 60-79` = sum(`Age 60-79`),
            `Age 80+` = sum(`Age 80+`))

# Cumulative (total) cases of COVID for racial groups in WA
wa_race_data <- race_data %>%
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
            Unknown = Cases_Unknown)

# Displaying the tables
kable(weekly_county_age_cases)
kable(WA_race_data)
