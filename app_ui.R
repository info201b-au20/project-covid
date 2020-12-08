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
                      of the overall COVID-19 case counts and 
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
                      COVID-19 cases by racial data of states and territories 
                      in the United States. It contains data about the number 
                      of cases and deaths from COVID-19 by ethnicity. 
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

chart1_intro <- tags$p("The first chart explores the number of deaths across 
                       the different states within the U.S. with respect to 
                       time. The reason in which this interactive chart is 
                       provided is that this provides viewers a good starting 
                       point to see an overview of how each state was influenced 
                       by the 2020 COVID-19 pandemic. One is able to explore 
                       the exact number of death for a state at a designated 
                       date/time by selecting both the desired observed state 
                       and the color of the graph.")
chart2_intro <- tags$p("The second chart delves more so into the racial impacts 
                       of the 2020 COVID-19 pandemic by comparing the number of 
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
chart3_intro <- tags$p("The third and final graph illustrates the cumulative 
                       COVID-19 cases for different races across the United 
                       States over time. This chart was chosen as it is crucial 
                       to visualize how the 2020 COVID-19 pandemic affects 
                       different racial demographics in our country. Observing 
                       the racial impacts became one of our main takeaways for 
                       this project. Viewers can select the races to display 
                       on a single graph for comparison and the range of dates 
                       to display between April to October.")

introduction <- tabPanel(
  title = tags$h2("Introduction"),
  mainPanel(
    tags$h6("Welcome!"),
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
    tags$img(src = "https://psychology.org.au/getmedia/9195dfbe-455a-4ee6-b470-ef8301acc3bd/20InPsych-JunJul-LanguageFear-p16-1000x500.jpg?width=1000&height=500&ext=.jpg"),
    tags$hr(),
    tags$h4("About the Charts:"),
    tags$h5("What are the trends of COVID-19 deaths in different states across 
                    the U.S. throughout the 2020 pandemic?"),
    chart1_intro, 
    tags$h5("How has COVID-19 impacted African American populations 
                    specifically between Washington and California regarding case numbers?"),
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
    data3_intro,
    tags$hr()
  ))

### FIRST PAGE by Grant Y ##############################################
stateNames <- race_data %>%
  select(State) %>% 
  distinct(State)

selectState <- selectInput(
  "state_name",
  label = "State:",
  choices = stateNames
)

selectColor <- selectInput(
  "color_selected",
  label = "Color:",
  choices = list("Purple" = "#865081", "Orange" = "#f69a69", "Red" = "#d32a3f")
)
death_state_comparision <- tabPanel(
  titlePanel("State Death Trends"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p('Select a state and a favorite color.'),
      selectState,
      selectColor
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput('state_plot'),
      p(
        "Source:",
        a("Race Data Entry - CRDT.csv",
          href = "https://github.com/info201b-au20/project-covid/blob/gh-pages/data/Race%20Data%20Entry%20-%20CRDT.csv"
        )
      ),
      p('This interactive chart is intended to explore the number as
        well as the general trend of total deaths across different states 
        with respect to time progression. This gives us a good tool to see an 
        overview of how each state was influenced by the the COVID-19 virus in 
        relation to total deaths. The general trend across states is
        a steady rise in lives lost to the 2020 pandemic.')
    )
  )
)

### SECOND PAGE by Jackie S #############################################
# Color input of the line chart
color_input <- selectInput(
  inputId = "color_input",
  label = "Color:",
  choices = list("Pink" = "#f97a85", "Blue" = "#3c73a9")
)
# State input of the line chart
state_input <- selectInput(
  inputId = "Statename",
  label = "State:",
  choices =  c("CA" = "CA",
               "WA" = "WA"),
  selected = "WA"
)
# Creates the tab panel
cases_comparison_panel <- tabPanel(
  titlePanel("WA/CA Comparison"),
  sidebarLayout(
    sidebarPanel(
      p('Select a state and a color.'),
      state_input,
      color_input
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
        "The two graphs are intended to find out the general trend of the 
        number of COVID-19 cases of African Americans in WA and CA based 
        on the position of the red dots of each month. The general trend 
        shown in each scatterplot graph is very similar in that the number 
        of cases of African Americans in both CA and WA are skyrocketing 
        from April to October."
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
      p("Select data to display."),
      checkboxGroupInput("checkboxRaces",
                         label = "Race:",
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
        label = "Date Range:",
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
      p("The purpose of this graph is to display the cases of COVID-19 by race 
        across the U.S. between April and October of 2020. Though the general 
        trend of this graph is consistent with the other two observations in 
        terms of cases rising all across the country, one should note that not 
        only is the largest data group “unknown,” but that this issue is far 
        too complex in terms of variables and factors that play into the idea 
        of a race being biologically more susceptible. Once again, though, 
        the trend of COVID-19 cases climbing is clear.")
    ))
)


### CONCLUSION by Minjie K ###

conclusion <- tabPanel(
  title = tags$h2("Conclusion"),
  mainPanel(
    tags$h6("Let's Wrap it Up!"),
    tags$h4("Key Takeaways:"),
    tags$h5("COVID-19 is REAL! And it doesn't seem to be slowing down..."),
    tags$p("As we can see from the 'State Death Trends', it shows that there is 
           an increasing number of deaths due to COVID-19.  From this graph we
           can also conclude that the spread of COVID-19 is not slowing down
           rather it is being spread faster than it previously has been. We can
           conclude this based on the number of deaths because as the number of
           deaths increase it must mean that more people are contracting the 
           COVID-19 virus."),
    tags$h5("Just because you're in a different state doesn't mean
            you are safe..."),
    tags$p("We compared 2 different states and how COVID-19 affected one
           particular race(African-American) in both states.  As you all can 
           proabably guess the COVID-19 case trend was similar for both states:
           it had an upward trend and many people got it.  While the physical 
           number of cases were different for both state, that could be due to
           the difference in population between Washington and California.  In 
           general, we can conclude that no matter which state we are in, 
           whether it is a highly populated state or a lowly populated state,
           people should still take precautions against the virus because it 
           doesn't care what state you are in."),
    tags$h5("While we would like to say that a certain race is more
            susceptible to COVID-19, unfortunately we can't conclude that..."),
    tags$p("Based on the 'Cases by Race' graph, we could quickly conclude that
           white people are more susceptible to COVID-19, but that's not 
           neccesarily the case. There might be more cases for white people 
           simply because the majority of people who live in the USA are white.
           Hispanic/Latino people could have more cases than some other races
           becuase there are more people that identify with that race that are
           from areas that are lower in the socio-economic scale and they simply
           don't have the means to have good quality personal protection
           equipment or the means to take time off work.  Bottom line is that we
           are not able to conclude that based on biology a certain race is more
           suseptible to contracting COVID-19; we have to consider other
           factors."),
    tags$hr(),
    tags$h4("Last but not least, remember to:"),
    tags$p(tags$a(
      href = "https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html",
      "CDC: How to Protect Yourself & Others"
    )),
    tags$img(src = "https://pbs.twimg.com/media/EdeeixaXYAADzfC.png"),
    tags$hr(),
    tags$p("Project by Natassja Bartle, Chandra Burnham, Minjie Kim, Jackie Si, & Grant Yang")
  ))
### LAYOUT ###
ui <- navbarPage(
  includeCSS("style.css"),
  title = tags$h1("Project COVID-19"),
  selected = tags$h2("Introduction"),
  introduction,
  death_state_comparision,
  cases_comparison_panel,
  cases_race_comparison,
  conclusion
)
