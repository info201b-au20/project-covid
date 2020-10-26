# **Project Proposal**

## _**Domain of interest**_
- _Why are you interested in this field/domain?_

As not only individuals who are experiencing this unprecedented time of a global pandemic and emergency, but as students at the University of Washington, where fellow peers and others have unfortunately been not so pandemic-friendly in their practices, causing outbreaks to surge, Covid-19 and the current response has been all-consuming in our lives through its impact on our sense of normalcy and safety as it has for everyone. As we continue to see numbers rise and tensions grow, this issue and the overall instance have grown to be a great topic of interest for our group. It has deeply affected our families and us individually, and we are eager to learn and discover more by delving deep into the subject. This topic is not only extremely relevant on a global scale (and local as we wish to work specifically on the case of WA state), but it is incredibly important. By interacting with the data surrounding this field, we feel that that process may give us a new level of understanding, perspective, and contextualization to bring to the metaphorical table of discussion and base of knowledge on the critical topic of Covid-19 and government/policy response. 
  
- _What other examples of data driven project have you found related to this domain (share at least 3)?_

We found a website called [_The COVID Tracking Project_](https://covidtracking.com/) which keeps track of a variety of data. The University of Minnesota has a data driven project that keeps track of the [_hospitalizations that are caused by Covid-19_](https://carlsonschool.umn.edu/mili-misrc-covid19-tracking-project) .  Another data driven project, [_Covid-19 Behind Bars_](https://law.ucla.edu/academics/centers/criminal-justice-program/ucla-covid-19-behind-bars-data-project) , is from UCLA Law, which keeps track of Covid-19 in the prison population 
  
- _What data-driven questions do you hope to answer about this domain (share at least 3)?_

 1. How many people has Covid-19 affected?  
 2. How has Covid-19 affected the lives of people (i.e. job loss, deaths, and etc.)?  
 3. Specifically, how has Covid-19 affected students’ ability to learn effectively? (i.e internet reliability, financial situation, focus/motivation, and etc.)

## _**Finding Data**_

- _Where did you download the data (e.g., a web URL)?_
  - https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard
  - https://www.kingcounty.gov/depts/health/covid-19/data/daily-summary.aspx
  - https://covidtracking.com/race

- _How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?_

The first dataset we are using is an XML spreadsheet of the number of cases of 2020 COVID-19 deaths by week of illness onset, county, and age in the state of Washington (categorized by age groups: 0-19, 20-39, 40-59, 60-79, 80+, and unknown). The data spans from March 8, 2020 to October 11, 2020. The data is current as of October 11th, 2020, and it has been updated every Sunday. It is collected by the Washington State Department of Health.

The second dataset we are using is an XML spreadsheet of the overall coronavirus cases counts and hospitalization/death rates by city, health reporting area, and zip code in King County, Washington, The data is updated as of October 19, 2020. It has been collected by Public Health - Seattle & King County epidemiologists and gets reported to the Washington State Department of Health, and is cross-checked by hospitals and investigators to ensure the accuracy of the data. Only positive or negative test results are reflected in the counts and exclude tests where results are pending, inconclusive or were not performed.

The third dataset we are using is a CSV file of coronavirus case racial data of states and territories in the United States. It contains data about the number of cases and deaths of coronavirus by ethnicity. The data spans from April 19, 2020 to October 21, 2020 and is updated twice a week. It has been collected by the COVID Tracking Project and the Boston University Center for Antiracist Research, and it is compiled taken directly from the websites of state/territory public health authorities. One thing that makes this dataset unique is it is collected by many volunteers by hand; that is, volunteers manually update the data by visiting state/territory public health websites once a day, annotating any changes to data sources or data anomalies as they go instead of relying fully on web-scraping and other automated harvesting methods.

- _How many observations (rows) are in your data?_

There are 1124 rows in the ‘cases’ table, 722 rows in the ‘hospitalizations’ table and 412 rows in the ‘deaths’ table.
There are 2999 rows in the coronavirus case racial data of states and territories in the United States.

- _How many features (columns) are in the data?_

There are 10 columns in the ‘cases’ table, ‘hospitalizations’ table, and ‘deaths’ table, including county, WeekStartDate, NewPos_All, Age 0-19, Age 20-39, Age 40-59, Age 60-79, Age 80+, Positive UnkAge, dtm_updated. 
There are 28 columns in the coronavirus case racial data of states and territories in the United States.
  
- _What questions (from above) can be answered using the data in this dataset?_

  -  Which age group has the most amount of cases?
  - Which area(county) has the most number of cases?
  - Which age group has the highest death rate?
  - What’s the distribution of data with respect to age?
  - What’s the distribution of data with respect to time? 
  - How effective are the policies made by the Washington government in preventing the spread of Covid? Ex. Did closing school/business help the situation? 

