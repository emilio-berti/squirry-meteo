library(tidyverse)
library(lubridate)


files <- list.files(pattern = "[.]csv")
d <- list()
for (f in files) {
   d[[f]] <- read_delim(f, delim = " ",
             col_names = c("Date", "Time", "Temperature")) %>% 
    mutate(Place = gsub("[.]csv", "", f))
}

d <- bind_rows(d) %>% 
  mutate(Date = paste(Date, Time, sep = "/") %>%
  	as.POSIXct(format = "%m/%d/%Y/%H")) %>% 
  mutate(Date = as_datetime(Date))

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
