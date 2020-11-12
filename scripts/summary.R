# This file calculates summary information to be included
library(dplyr)
library(tidyverse)

# import race data
race_data <- read.csv("./data/Race Data Entry - CRDT.csv")

# A function that takes in a dataset and returns a list of info about it:
