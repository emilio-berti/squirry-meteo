library(tidyverse)
library(lubridate)
library(png)


files <- list.files(pattern = "[.]csv")
d <- list()
for (f in files) {
  d[[f]] <- read_delim(f, delim = " ",
                       col_names = c("Date", "Time", 
                                     "Temperature", "Sky")) %>% 
    mutate(Sky = gsub("^ ", "", gsub("-", " ", Sky)),
           Place = gsub("[.]csv", "", f))
}

d <- bind_rows(d) %>% 
  mutate(Date = paste(Date, Time, sep = "/") %>%
           as.POSIXct(format = "%m/%d/%Y/%H")) %>% 
  mutate(Date = as_datetime(Date))

# Temperature plot --------
d %>% 
  ggplot() +
  aes(Date, Temperature, col = Place) +
  geom_point(pch = 20, size = 1.25) +
  geom_line(size = 0.25) +
  scale_x_datetime(date_breaks = "6 hours",
                   date_minor_breaks = "2 hours", 
                   date_labels = "%H:%M\n%A") +
  scale_y_continuous(breaks = seq(floor(min(d$Temperature)), ceiling(max(d$Temperature)), by = 2)) +
  scale_color_brewer(palette = "Set3") +
  xlab("") +
  ylab("Feel temperature") +
  #ylim(c(floor(min(d$Temperature)), ceiling(max(d$Temperature)))) +
  theme_minimal() +
  theme(text = element_text(colour = "white"),
        axis.text = element_text(colour = "white"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.x = element_line(colour = "grey90", size = 0.1),
        panel.grid.major.y = element_line(colour = "grey90", size = 0.1),
        panel.grid.minor.y = element_blank(),
        #panel.grid.minor.y = element_line(colour = "grey95", size = 0.1),
        plot.background = element_rect(fill = "grey15"))

ggsave(filename = "combined_plot.png", width = 8, height = 4)

# Sky plot ----------
xmax <- d %>%
  group_by(Place) %>% 
  tally() %>%
  pull(n) %>%
  max() + 1
xlim <- c(1, xmax)
ymax <- length(files)
ylim <- c(0, ymax) 
plot.new()
png("combined_sky.png", 
	width = 8*10^2.2, 
	height = length(unique(d$Place)) * 10^2.1)
#empty plot with correct extent
par(mar = c(3, 1, 1, 1))
plot(seq_len(xmax), 
     seq(0, ymax, length.out = xmax),
     col = rgb(0, 0, 0, 0), axes = FALSE, 
     xlab = "", ylab = "")
abline(h = 0:length(unique(d$Place)))
for (name in files) {
  l <- str_length(name)
  text(xmax, -0.5 + which(files == name), 
       gsub("[.]csv", "", name), 
       adj = 0.5, srt = 90, 
       font = 2, cex = 2 * 10 / l)
}
ticks <- rep(unique(d$Time), 2)
ticks <- ticks[seq(1, 48, by = 3)]
axis(side = 1, 
     at = seq(1, 48, by = 3),
     labels = ticks, cex.axis = 2)

sub_d <- filter(d, Time %in% ticks) %>% 
  mutate(Place = factor(Place))

clear <- readPNG("Figures/clear_sky.png")
overcast <- readPNG("Figures/overcast.png")
light_rain <- readPNG("Figures/light_rain.png")
broken_clouds <- readPNG("Figures/broken_clouds.png")

for (place in levels(sub_d$Place)) {
  sky <- sub_d %>% 
    filter(Place == place) %>% 
    pull(Sky)
  for (x in seq_len(length(ticks)) * 2) {
    if (!is.na(sky[x / 2])) {
      img <- switch (sky[x / 2],
                     "clear sky" = clear,
                     "broken clouds" = broken_clouds,
                     "scattered clouds" = broken_clouds,
                     "few clouds" = broken_clouds,
                     "light rain" = light_rain,
                     "moderate rain" = light_rain,
                     "overcast clouds" = overcast
      )
      rasterImage(img, 
                  3 / 2 * x - 3, 
                  0.25 + which(levels(sub_d$Place) == place) - 1, 
                  3 / 2 * x - 1,
                  0.75 + which(levels(sub_d$Place) == place) - 1)
    }
  }
}
dev.off()
