library(tidyverse)

poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

poll %>% 
  group_by(industry, year) %>% 
  summarise(avg_rq = mean(rq), .groups = "drop") %>% 
  filter(!is.na(avg_rq)) %>% 
  ggplot() + 
  geom_line(aes(x = year, y = avg_rq, color = industry))
  