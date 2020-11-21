library(tidyverse)
library(dplyr)
library("readxl")    
library("ggplot2")

race_data <- read.csv("https://raw.githubusercontent.com/info201b-au20/project-covid/gh-pages/data/Race%20Data%20Entry%20-%20CRDT.csv")

race_data <- race_data %>% 
  filter(State == "WA")

race_data$Date <- as.Date(paste(substr(race_data$Date, 1, 4), substr(race_data$Date, 5, 6), "01", sep = "-"))

smooth_plot_chart <- ggplot(race_data) +
  geom_smooth(aes(x = Date, y = Deaths_Total))+
  scale_x_date(date_breaks = "1 month")+
  labs(
    x='Time',
    y='Total Death',
    title = "Total Death OverTime"
  )
