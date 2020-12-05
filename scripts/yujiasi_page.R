library(shiny)
library(plotly)
library(tidyverse)

######### UI #######

color_input <- selectInput(
      inputId = "color_input",
      label = "Color",
      choices = list("Red" = "red", "Green" = "green")
    )


state_input <- selectInput(
      inputId = "Statename",
      label = "State to show:",
      choices =  c("CA" = "CA",
                   "WA" = "WA"),
      selected = "WA"
    )

ui <- navbarPage(
  "Project-Covid",
  cases_comparison_panel <- tabPanel(
    "Cases Comparison Chart",
    titlePanel("Compare the number of cases of African Americans in WA/CA
               between 4.12.2020 to 10.28.2020"),
    color_input,
    state_input
  ),
  
  mainPanel(
    plotlyOutput('plot'),
    p(
      "Source:",
      a("Race Data Entry - CRDT.csv",
        href = "https://github.com/info201b-au20/project-covid/blob/gh-pages/data/Race%20Data%20Entry%20-%20CRDT.csv"
      )
    ),
    p(
      "The reason that I included this chart is to     "
    )
  )
)

######### Server #######

black_data <- read.csv("../data/Race Data Entry - CRDT.csv")
unique(black_data$State)


make_point_plot <- function(data, color_input, state_selected){
      black_data <- data %>% 
        filter(State == state_selected)
  
      plot_covid <- ggplot(data = black_data) +
        geom_smooth(
        mapping = aes_string(x = black_data$Date, y = black_data$Cases_Black),
        color = color_input
      ) +
      ggtitle("Compare the number of cases of African Americans in WA/CA") +
      labs(x = "Date", y = "Cases")
}



server <- function(input, output) {
  black_data$Date <- as.Date(paste(substr(black_data$Date, 1, 4), substr(black_data$Date, 5, 6), "01", sep = "-"))

  
  output$plot <- renderPlotly({
    plot_covid <- make_point_plot(black_data, input$color_input, input$Statename)
    ggplotly(plot_covid)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
