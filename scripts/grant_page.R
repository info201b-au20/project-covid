#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)


data <- read.csv("../data/Race Data Entry - CRDT.csv")

build_smooth_num_death <- function(data, state_name, color_selected){
    race_data <- data %>% 
         filter(State == state_name)
    race_data$Date <- as.Date(paste(substr(race_data$Date, 1, 4), substr(race_data$Date, 5, 6), "01", sep = "-"))

    smooth_plot_chart <- ggplot(race_data) +
        geom_smooth(aes(x = Date, y = Deaths_Total), color = color_selected, na.rm = TRUE)+
        scale_x_date(date_breaks = "1 month")+
        labs(
            x='Time',
            y='Total Death',
            title = "Total Death OverTime"
        )
    
}


###UI#####

stateNames <- data %>% 
    select(State) %>% 
    distinct(State)
    
selectState <- selectInput(
    "state_name",
    label = "Select A State",
    choices = stateNames
)

selectColor <- selectInput(
    "color_selected",
    label = "What is your favorie Color",
    choices = c("Yellow", "Red","Blue")
)
###




# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Total Number of Death Over Time for State"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectState,
            selectColor
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput('plot')
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


    output$plot <- renderPlotly({
        plot <- build_smooth_num_death(data, input$state_name, input$color_selected)
        ggplotly(plot)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)




