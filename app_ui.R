library(shiny)
library(plotly)
library(ggplot2)
library(tidyverse)
race_data <- read.csv("./data/Race Data Entry - CRDT.csv")
### INTRODUCTION by Natassja B ###
data1_intro <- tags$p("The first dataset we are using is an XML spreadsheet of 
                      the number of cases of 2020 COVID-19 deaths by week of 
                      illness onset, county, and age in the state of Washington 
                      (categorized by age groups: 0-19, 20-39, 40-59, 60-79, 
                      80+, and unknown). The data spans from March 8, 2020 to 
                      October 11, 2020. The data is current as of October 
                      11th, 2020, and it has been updated every Sunday. 
                      It is collected by the Washington State Department of 
                      Health.")
data2_intro <- tags$p("The second dataset we are using is an XML spreadsheet 
                      of the overall coronavirus cases counts and 
                      hospitalization/death rates by city, health reporting
                      area, and zip code in King County, Washington, 
                      The data is updated as of October 19, 2020. 
                      It has been collected by Public Health - Seattle & King 
                      County epidemiologists and gets reported to the Washington
                      State Department of Health, and is cross-checked by 
                      hospitals and investigators to ensure the accuracy of the 
                      data. Only positive or negative test results are reflected 
                      in the counts and it excludes tests where results are 
                      pending, inconclusive, or that were not performed.")
data3_intro <- tags$p("The third dataset we are using is a CSV file of 
                      coronavirus case racial data of states and territories 
                      in the United States. It contains data about the number 
                      of cases and deaths of coronavirus by ethnicity. 
                      The data spans from April 19, 2020 to October 21, 
                      2020 and is updated twice a week. It has been collected 
                      by the COVID Tracking Project and the Boston University 
                      Center for Antiracist Research, and it is compiled taken 
                      directly from the websites of state/territory public 
                      health authorities. One thing that makes this dataset 
                      unique is it is collected by many volunteers by hand; 
                      that is, volunteers manually update the data by visiting 
                      state/territory public health websites once a day, 
                      annotating any changes to data sources or data anomalies 
                      as they go instead of relying fully on web-scraping and 
                      other automated harvesting methods.")

chart1_intro <- tags$p("The first chart explores the number of death across 
                       the different states within the U.S. with respect to 
                       time. The reason in which this interactive chart is 
                       provided is that this provides viewers a good starting 
                       point to see an overview of how each state was influenced 
                       by the 2020 COVID-19 pandemic. One is able to explore 
                       the exact number of death for a state at a designated 
                       date/time by selecting both the desired observed state 
                       and the color of the graph.")
chart2_intro <- tags$p("The second chart delves more so into the racial impacts 
                       of the 2020 COVID-19 pandemic by examining the number of 
                       African American positive cases in California and 
                       Washington. The two states were chosen for observation 
                       as we were curious about the implications met within our 
                       very of Washington, and California was chosen as it has 
                       been a notable West Coast state throughout the pandemic 
                       with rich data available. This scatter plot displays 
                       the number of African American cases in both states in 
                       each month starting from April to October. Viewers can 
                       select the graph for the state and choose between two 
                       different colors to show the graph.")
chart3_intro <- tags$p("The Third and final graph illustrates the cumulative 
                       COVID-19 cases for different races across the United 
                       States over time. This chart was chosen as it is crucial 
                       to visualize how the 2020 COVID-19 pandemic affects 
                       different racial demographics in our country. It grew to 
                       be one of our main objectives for examination (the 
                       impacts on race). Viewers can select the races to display 
                       on a single graph for comparison and the range of dates 
                       to display between April to October.")
    
introduction <- tabPanel(
    title = tags$h2("Introduction"),
        mainPanel(
            tags$h2("Introduction"),
            tags$img(src = "https://psychology.org.au/getmedia/9195dfbe-455a-4ee6-b470-ef8301acc3bd/20InPsych-JunJul-LanguageFear-p16-1000x500.jpg?width=1000&height=500&ext=.jpg"),
            tags$h4("Project Mission:"),
            tags$p("As not only individuals who are experiencing this 
                   unprecedented time of a global pandemic and emergency, 
                   but as students at the University of Washington, a 
                   university that has notably been forefronting Pandemic 
                   response models, COVID-19 and the current state of its 
                   effects has been all-consuming in our lives through its 
                   impact on our sense of safety and normalcy as it has for 
                   everyone. As we continue to see numbers in cases and deaths 
                   rise, and as tensions grow, this issue and the overall 
                   instance has grown to be a great topic of interest for 
                   our group. It has deeply affected our communities, 
                   predominantly minority populations, and we became eager 
                   to learn and discover more by delving deep into the subject. 
                   Through interacting with the data available and surrounding 
                   this field, we were able to gain a new level of 
                   understanding, perspective, and contextualization to bring 
                   to the metaphorical table of discussion on the critical topic 
                   of COVID-19, especially in regards to the impacts surrounding 
                   race in the U.S."),
            tags$h5("Overall, we hope that our viewers, such as yourself, can 
                    take away newfound knowledge surrounding the 2020 COVID-19 
                    pandemic and its' effects on particular populations. 
                    Thank you, and enjoy!"),
            tags$hr(),
            tags$h4("About the Charts:"),
            tags$h5("How have COVID-19 deaths affected different states across 
                    the U.S. throughout the 2020 pandemic?"),
            chart1_intro, 
            tags$h5("How has COVID-19 impacted African American populations in 
                    specifically Washington and California regarding case numbers?"),
            chart2_intro, 
            tags$h5("How has COVID-19 affected different racial populations 
                    across the U.S.?"),
            chart3_intro,
            tags$hr(),
            tags$h4("About the Data and the Sources:"),
            tags$p(tags$a(
                href = "https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard",
                "Dataset Source 1: Washington State Department of Health"
            )),
            tags$p(tags$a(
                href = "https://www.kingcounty.gov/depts/health/covid-19/data/daily-summary.aspx",
                "Dataset Source 2: King County COVID-19 Data Dashboards"
            )),
            tags$p(tags$a(
                href = "https://covidtracking.com/race",
                "Dataset Source 3: The COVID Tracking Project"
            )),
            data1_intro,
            data2_intro,
            data3_intro
        ))
  
### FIRST PAGE by Grant Y ##############################################
stateNames <- race_data %>%
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
death_state_comparision <- tabPanel(
  titlePanel("Trend in Total Death"),
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

### SECOND PAGE by Jackie S #############################################
# Color input of the line chart
color_input <- selectInput(
      inputId = "color_input",
      label = "Color",
      choices = list("Red" = "red", "Green" = "green")
    )
# State input of the line chart
state_input <- selectInput(
      inputId = "Statename",
      label = "State to show:",
      choices =  c("CA" = "CA",
                   "WA" = "WA"),
      selected = "WA"
    )
# Creates the tab panel
cases_comparison_panel <- tabPanel(
  titlePanel("Comparison"),
  sidebarLayout(
    sidebarPanel(
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
    "The two graphs are intended to find out the general trend of the number of Covid cases of African Americans in WA and CA based on the position of the red dots of each month. The general trend shown in each line chart is very similar in that the number of cases of African Americans in both CA and WA are skyrocketing from April to October."
   )
  )
 )
)

### THIRD PAGE by Chandra B ###

# Cumulative total cases of COVID by racial group
raw_data_table <- race_data %>%
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

data_to_render <- raw_data_table %>%
  gather(key = "Race", value = "Cases", -Date)

cases_race_comparison <- tabPanel(
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


### CONCLUSION by Minjie K ###

### LAYOUT ###
ui <- navbarPage(
    includeCSS("style.css"),
    title = tags$h1("Project COVID-19"),
    selected = tags$h2("Introduction"),
    introduction,
    cases_comparison_panel,
    cases_race_comparison    
)
