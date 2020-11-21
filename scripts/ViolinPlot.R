library("ggplot2")
source("./scripts/tables.R")

#The purpose of including this chart is to see how different age groups are
#affected by Covid-19, and to see which groups contribute most the number of
#cases present. In this plot we are able to that the most mean number of weekly
#cases is from the age 20-39 group, this group is also has the max number of 
#cases in a pparticular week during the time of data collection

# get average cases per week for each age group
avg_weekly_cases_age <- weekly_cases_by_age %>%
  select(`Age 0-19`,
         `Age 20-39`,
         `Age 40-59`,
         `Age 60-79`,
         `Age 80+`) %>%
  gather(key = age_group, value = weekly_cases)

#Making the histogram

plot <- ggplot(data = avg_weekly_cases_age, aes(x = age_group, y = weekly_cases)) + 
  geom_violin() +
  labs(title = "Distribution of Weekly Covid Cases for each Age Group",
       x = "Age Group", 
       y = "Weekly Cases")

plot + stat_summary(fun = mean, geom = "point", size = 1, color = "blue")