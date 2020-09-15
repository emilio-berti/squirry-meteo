library(tidyverse)
library(lubridate)
library(wesanderson)


d <- bind_rows(
  read_delim("Aarhus.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Aarhus"),
  read_delim("Leipzig.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Leipzig"),
  read_delim("Prato.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Prato"),
  read_delim("StaraZagora.csv", delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = "Stara Zagora")
) %>% 
  mutate(Date = paste(Date, Time, sep = "/")) %>% 
  mutate(Date = as_datetime(Date, format = "%m/%d/%Y/%H"))

d %>% 
  ggplot() +
  aes(Date, Temperature, col = Place) +
  geom_point(pch = 20, size = 2) +
  geom_line(size = 0.75) +
  scale_x_datetime(date_breaks = "6 hours",
                   date_minor_breaks = "2 hours", 
                   date_labels = "%H:%M\n%A") +
  scale_color_brewer(palette = "Set3") +
  xlab("") +
  ylab("Feel temperature") +
  theme_minimal() +
  theme(text = element_text(colour = "white"),
        axis.text = element_text(colour = "white"),
        axis.text.x = element_text(angle = 90,
                                   vjust = 0.5),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_line(colour = "grey95"),
        plot.background = element_rect(fill = "grey15"))

ggsave(filename = "combined_plot.png", width = 8, height = 4)
