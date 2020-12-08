library(shiny)
library(tidyverse)
library(plotly)

race_data <- read.csv("./data/Race Data Entry - CRDT.csv")
unique(race_data$State)

## For the second page by Jackie Si.
# Filtering out useful data for the second page based on selected state.
make_plot <- function(data, color_input, state_selected){
      black_data <- race_data %>%
        filter(State == state_selected)
      black_data$Date <- unique(as.Date(as.character(black_data$Date), format = "%Y%m%d"))
      plot_covid <- ggplot(data = black_data) +
        geom_point(
        mapping = aes_string(x = black_data$Date, y = black_data$Cases_Black),
        color = color_input
      ) +
      scale_x_date(date_breaks = "1 month") +
      ggtitle("Comparison of Total Cases of African Americans in WA & CA") +
      labs(x = "Date", y = "Total Cases")
}

###############################################
## For the first page by GRANT 
build_smooth_num_death <- function(state_name, color_selected){
  state_race_data <- race_data %>%
    filter(State == state_name)
  state_race_data$Date <- as.Date(paste(substr(state_race_data$Date, 1, 4), substr(state_race_data$Date, 5, 6), "01", sep = "-"))
  
  smooth_plot_chart <- ggplot(state_race_data) +
    geom_smooth(aes(x = Date, y = Deaths_Total), color = color_selected, na.rm = TRUE)+
    scale_x_date(date_breaks = "1 month")+
    labs(
      x='Date',
      y='Total Deaths',
      title = "Total Deaths Trend Over Time by State"
    )
}


##############################################
# Server
server <- function(input, output) {
  #####First Page #######
  output$state_plot <- renderPlotly({
    state_plot <- build_smooth_num_death(input$state_name, input$color_selected)
    ggplotly(state_plot)
  })
  
  #####Second Page######
  output$plot <- renderPlotly({
    plot_covid <- make_plot(black_data, input$color_input, input$Statename)
    ggplotly(plot_covid)
  })
  
  #####Third Page######
  filteredData <- reactive({
    data_to_render[data_to_render$Race %in% input$checkboxRaces, ]
  })
  
  output$table <- renderTable(raw_data_table)
  output$chart <- renderPlotly({
    plot_ly(
      data = filteredData(),
      x = ~Date,
      y = ~Cases,
      split = ~Race,
      type = "scatter",
      mode = "lines+markers",
      hovertemplate = "%{y}"
    ) %>%
      layout(title = "COVID-19 Cases by Race in the U.S.",
             xaxis = list(title = "Date",
                          range = input$dateRangeInput,
                          fixedrange = TRUE),
             yaxis = list(title = "Total Cases"),
             showlegend = TRUE,
             hovermode = "x unified"
      )
  })
}
