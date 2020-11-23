library("ggplot2")
source("./scripts/tables.r")

#The purpose of including this chart is to see how different age groups are
#affected by Covid-19, and to see which groups contribute most the number of
#cases present. In this plot we are able to that the most mean number of weekly
#cases is from the age 20-39 group, this group is also has the max number of 
#cases in a pparticular week during the time of data collection


#Making the histogram

plot <- ggplot(data = avg_weekly_cases_age, aes(x = age_group, y = weekly_cases)) + 
  geom_violin() +
  labs(title = "Distribution of Weekly Covid Cases for each Age Group",
       x = "Age Group", 
       y = "Weekly Cases")

plot + stat_summary(fun = mean, geom = "point", size = 1, color = "blue")
