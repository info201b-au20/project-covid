library(shiny)
library(tidyverse)
library(plotly)

race_data <- read.csv("../data/Race Data Entry - CRDT.csv")
unique(race_data$State)

## For the second page by Jackie Si.
# Filtering out useful data for the second page based on selected state.
make_plot <- function(data, color_input, state_selected){
      black_data <- race_data %>%
        filter(State == state_selected)
      black_data$Date <- as.Date(paste(substr(black_data$Date, 1, 4), substr(black_data$Date, 5, 6), "01", sep = "-"))
 # Make plot using ggplot
      plot_covid <- ggplot(data = black_data) +
        geom_smooth(
        mapping = aes_string(x = black_data$Date, y = black_data$Cases_Black),
        color = color_input
      ) +
      ggtitle("Compare the number of cases of African Americans in WA/CA from April to October 2020") +
      labs(x = "Date(month)", y = "Cases")
}

# Server
server <- function(input, output) {
  
  output$plot <- renderPlotly({
    plot_covid <- make_plot(black_data, input$color_input, input$Statename)
    ggplotly(plot_covid)
  })
}
