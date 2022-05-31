library(tidyverse)

poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

poll_avg <- poll %>% 
  group_by(industry, year) %>% 
  summarise(avg_rq = mean(rq), .groups = "drop") %>% 
  filter(!is.na(avg_rq))

poll_avg %>% 
  ggplot() + 
  geom_line(aes(x = year, y = avg_rq, color = industry)) + 
  geom_text(data = poll_avg %>% filter(year == 2017),
            aes(year, avg_rq, color = industry, label = industry),
            size = 2.75) +
  theme(legend.position = "bottom")
  