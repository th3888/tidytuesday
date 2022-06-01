library(tidyverse)
library(ggthemes)
library(RColorBrewer)

poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

poll_avg <- poll %>% 
  group_by(industry, year) %>% 
  summarise(avg_rq = mean(rq), .groups = "drop") %>% 
  filter(!is.na(avg_rq))

theme_set(theme_economist())

poll_avg %>% 
  ggplot() + 
  geom_line(aes(x = year, y = avg_rq, color = industry)) + 
  ggrepel::geom_text_repel(data = poll_avg %>% filter(year == 2017),
            aes(year, avg_rq, color = industry, label = industry),
            size = 3.5) +
  theme(legend.position = "none")
  