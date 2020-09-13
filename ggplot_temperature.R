library(tidyverse)
library(lubridate)
library(wesanderson)


d <- bind_rows(
  read_delim("Leipzig.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Leipzig"),
  read_delim("Prato.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Prato"),
  read_delim("Stara_Zagora.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Stara Zagora")
) %>% 
  mutate(Date = paste(Date, Time, sep = "/")) %>% 
  mutate(Date = as_datetime(Date, format = "%m/%d/%Y/%H"))

d %>% 
  ggplot() +
  aes(Date, Temperature, col = Place) +
  geom_point(pch = 21, size = 2) +
  geom_line() +
  scale_x_datetime(date_breaks = "6 hours",
                   date_minor_breaks = "2 hours", 
                   date_labels = "%H:%M\n%A") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5),
        panel.grid.major = element_line(colour = "grey80"),
        panel.grid.minor = element_line(colour = "grey90"))

ggsave(filename = "combined_plot.png")
