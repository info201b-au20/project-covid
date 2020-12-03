library(shiny)
library(tidyverse)
library(plotly)
black_data <- read.csv("https://github.com/info201b-au20/project-covid/blob/gh-pages/data/Race%20Data%20Entry%20-%20CRDT.csv")
unique(black_data$State)

server <- function(input, output) {
  output$startdate <- renderText({
    as.character(input$daterange[1])
  })
  output$enddate <- renderText({
    as.character(input$daterange[2])
  })
  output$range <- renderText({
    paste("Selected date range is", input$daterange[1], "to", input$daterange[2])
  })
  output$plot <- renderPlotly({
    p <- black_data %>%
      filter(State %in% input$State) %>%
      plot_ly(x = ~Date, y = ~Cases_Black, color = ~State)
    p
  }) %>%
    layout(title = "Compare the number of cases of African Americans in WA/NY/CA")
}