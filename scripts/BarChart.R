library(tidyverse)
library(readxl)
library(knitr)

race_data <- read.csv("./data/Race Data Entry - CRDT.csv")

cumulative_cases_perrace <- race_data %>%
  group_by(State) %>%
  filter(State == "WA") %>%
  arrange(Date) %>%
  summarize(Date = as.Date(as.character(Date), format = "%Y%m%d"),
            "White" = Cases_White,
            "Black" = Cases_Black,
            "Hispanic/Latino" = Cases_LatinX,
            "Asian" = Cases_Asian,
            "American Indian/Alaska Native" = Cases_AIAN,
            "Native Hawaiian/Pacific Islander" = Cases_NHPI,
            "Multiracial" = Cases_Multiracial,
            "Other" = Cases_Other,
            "Unknown" = Cases_Unknown) %>%
  filter(State == "WA") %>% 
  slice(- (1:9))

cumulative_cases <- top_n(cumulative_cases_perrace,1)

library(ggplot2)
theme_set(theme_classic())
#How to add values above bar/column
plot_two <- ggplot(data = cumulative_cases) + 
  geom_col(mapping = aes(x = "a. Unknown", y = 34668), fill = "mediumorchid") +
  geom_label(mapping = aes(x = "a. Unknown", y = 34668, label = 34668)) +
  geom_col(mapping = aes(x = "b. White", y = 29290), fill = "lightslateblue") + 
  geom_label(mapping = aes(x = "b. White", y = 29290, label = 29290)) +
  geom_col(mapping = aes(x = "c. Hispanic/Latino", y = 27408), fill = "steelblue1") +
  geom_label(mapping = aes(x = "c. Hispanic/Latino", y = 27408, label = 27408)) +
  geom_col(mapping = aes(x = "d. Black", y = 4063), fill = "mediumaquamarine") +
  geom_label(mapping = aes(x = "d. Black", y = 4063, label = 4063)) +
  geom_col(mapping = aes(x = "e. Asian", y = 3499), fill = "lightgreen") + 
  geom_label(mapping = aes(x = "e. Asian", y = 3499, label = 3499)) +
  geom_col(mapping = aes(x = "f. Multiracial", y = 1802), fill = "paleturquoise") + 
  geom_label(mapping = aes(x = "f. Multiracial", y = 1802, label = 1802)) +
  geom_col(mapping = aes(x = "g. Pacific Islander", y = 1619), fill = "lightpink") +
  geom_label(mapping = aes(x = "g. Pacific Islander", y = 1619, label = 1619)) +
  geom_col(mapping = aes(x = "h. Other", y = 1286), fill = "thistle2") + 
  geom_label(mapping = aes(x = "h. Other", y = 1286, label = 1286)) +
  geom_col(mapping = aes(x = "i. American Indian", y = 1108), fill = "mistyrose") +
  geom_label(mapping = aes(x = "i. American Indian", y = 1108, label = 1108)) +
  labs(title="Cumulative Total Cases of COVID-19 Recorded by Racial Group in WA", 
       subtitle="As of October 28th, 2020 (Most Recent Date Available in Dataset)",
       x ="Racial Groups", y ="Cumulative Total Cases Recorded") +
  theme(axis.text.x = element_text(angle= 45, vjust= 0.5))+
  theme(plot.subtitle = element_text(face = "italic"))+
  theme(plot.title = element_text(face = "bold"))
