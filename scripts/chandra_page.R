library(shiny)
library(tidyverse)
library(plotly)

source("./scripts/tables.r")

# Cumulative total cases of COVID by racial group
data <- race_data %>%
  select(Date, Cases_White, Cases_Black, Cases_LatinX,
         Cases_Asian, Cases_AIAN, Cases_Multiracial,
         Cases_NHPI, Cases_Other, Cases_Unknown) %>%
  group_by(Date) %>%
  summarise(Date = unique(as.Date(as.character(Date), format = "%Y%m%d")),
            "White" = sum(as.numeric(Cases_White), na.rm = TRUE),
            "Black" = sum(as.numeric(Cases_Black), na.rm = TRUE),
            "Hispanic/Latino" = sum(as.numeric(Cases_LatinX), na.rm = TRUE),
            "Asian" = sum(as.numeric(Cases_Asian), na.rm = TRUE),
            "American Indian/Alaska Native" =
              sum(as.numeric(Cases_AIAN), na.rm = TRUE),
            "Native Hawaiian/Pacific Islander" =
              sum(as.numeric(Cases_NHPI), na.rm = TRUE),
            "Multiracial" =
              sum(as.numeric(Cases_Multiracial), na.rm = TRUE),
            "Other" = sum(as.numeric(Cases_Other), na.rm = TRUE),
            "Unknown" = sum(as.numeric(Cases_Unknown), na.rm = TRUE))

data_to_render <- data %>%
  gather(key = "Race", value = "Cases", -Date)

main_page <- fluidPage(
  titlePanel("Cases by Race"),
  br(),
  sidebarLayout(
    sidebarPanel(
      helpText("Select data to display."),
      checkboxGroupInput("checkboxRaces",
                         label = "Race",
                         choices = c("White", "Black", "Hispanic/Latino",
                                     "Asian", "American Indian/Alaska Native",
                                     "Native Hawaiian/Pacific Islander",
                                     "Multiracial", "Other", "Unknown"),
                         selected = c("White", "Black", "Hispanic/Latino",
                                      "Asian", "American Indian/Alaska Native",
                                      "Native Hawaiian/Pacific Islander",
                                      "Multiracial", "Other", "Unknown")),
      dateRangeInput(
        inputId = "dateRangeInput",
        label = "Date range",
        start = "2020-04-12",
        end = "2020-10-28",
        min = "2020-04-12",
        max = "2020-10-28",
        format = "yyyy-mm-dd",
        startview = "month",
        weekstart = 0,
        separator = " to ",
        autoclose = TRUE
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", br(), plotlyOutput("chart")),
        tabPanel("Raw Table", tableOutput("table"))
      )
      ,
      br(),
      
    ))
)

##############################
# server
##############################

ui <- main_page

server <- function(input, output) {
  filteredData <- reactive({
    data_to_render[data_to_render$Race %in% input$checkboxRaces, ]
  })
  
  output$table <- renderTable(data)
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
      layout(title = "Coronavirus Cases by Race in the United States",
             xaxis = list(title = "Date",
                          range = input$dateRangeInput,
                          fixedrange = TRUE),
             yaxis = list(title = "Cases of coronavirus"),
             showlegend = TRUE,
             hovermode = "x unified"
      )
  })
}

# Execute server
shinyApp(ui, server)
