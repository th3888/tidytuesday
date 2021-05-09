library(tidyverse)
library(skimr)

CEO <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv")

#summary
skim(CEO)

#from departure code to  classifications
CEO <- CEO %>% 
  filter(!is.na(departure_code),
         departure_code %in% 1:7) %>% 
  mutate(departure_code = case_when(departure_code == 1 ~ "Death",
                                    departure_code == 2 ~ "Illness",
                                    departure_code == 3 ~ "Performance dismissal",
                                    departure_code == 4 ~ "Legal dismissal",
                                    departure_code == 5 ~ "Retired",
                                    departure_code == 6 ~ "New opportunity",
                                    departure_code == 7 ~ "Other"))