library(shiny)
library(plotly)
library(ggplot2)

ui <- navbarPage(
  "Project-Covid",
  
  # First interactive page by Jackie Si
  cases_comparison_panel <- tabPanel(
    "Cases Comparison Chart",
    titlePanel("Compare the number of cases of African Americans in WA/NY/CA 
               between 4.12.2020 to 10.28.2020"),
    dateRangeInput(
      inputId = 'Date',
      lablel = "Select the date range",
      start = min(Date),
      end = max(Date),
      min = min(Date),
      max = max(Date),
      format = "yyyy/mm/dd",
      separator = "-"
    ),
    textOutput("startdate"),
    textOutput("enddate"),
    textOutput("range"),
    
    sidebarLayout(
      checkboxGroupInput(
        inputId = "State", 
        label = "State to show:",
        choices =  c("CA" = "CA",
                     "NY" = "NY",
                     "WA" = "WA"),
        selected = "WA"
      )
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
        "The reason that I included this chart is to "
      )
    )
  )
)


