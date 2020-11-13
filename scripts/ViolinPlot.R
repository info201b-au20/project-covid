library("ggplot2")
source("tables.r")

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
  labs(title = "Distribution of Weekly CoVid Cases for each Age Group",
       x = "Age Group", 
       y = "Weekly Cases")

plot + stat_summary(fun = mean, geom = "point", size = 1, color = "blue") 
  
