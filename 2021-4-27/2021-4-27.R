library(tidyverse)
library(skimr)

CEO <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv")

#summary
skim(CEO)

#from departure code to  classifications
CEO_dep <- CEO %>% 
  filter(!is.na(departure_code),
         departure_code %in% 1:7) %>% 
  mutate(departure_code = case_when(departure_code == 1 ~ "Death",
                                    departure_code == 2 ~ "Illness",
                                    departure_code == 3 ~ "Performance dismissal",
                                    departure_code == 4 ~ "Legal dismissal",
                                    departure_code == 5 ~ "Retired",
                                    departure_code == 6 ~ "New opportunity",
                                    departure_code == 7 ~ "Other"))


CEO_dep %>% 
  mutate(dismissal = ifelse(ceo_dismissal == 1,
                            "dismissal",
                            "not dismissal")) %>% 
  filter(fyear > 1995, fyear < 2019) %>% 
  count(fyear, dismissal) %>% 
  ggplot(aes(fyear, n, color = dismissal)) + 
  geom_line(size = 1, alpha = 0.5) + 
  geom_point(size = 1.5) +
  geom_smooth(method = "lm", lty = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  labs(x = "Year", y = "Number of CEO departures") +
  ggsave("2021-4-27/output/fig1.png")