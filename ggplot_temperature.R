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
  mutate(Date = paste(Date, Time, sep = "/")) %>% 
  mutate(Date = as_datetime(Date, format = "%m/%d/%Y/%H"))

# Temperature plot --------
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

# Sky plot ----------
xmax <- d %>%
  group_by(Place) %>% 
  tally() %>%
  pull(n) %>%
  max()
xlim <- c(1, xmax)
ymax <- length(files)
ylim <- c(0, ymax) 
plot.new()
#empty plot with correct extent
par(mar = c(3, 1, 1, 1))
plot(seq_len(xmax), 
     seq(0, ymax, length.out = xmax),
     col = rgb(0, 0, 0, 0), axes = FALSE, 
     xlab = "", ylab = "")
abline(h = 0:6)
for (name in files) {
  text(48, -0.5 + which(files == name), 
       gsub("[.]csv", "", name), 
       adj = 0.5, srt = -40)
}
ticks <- rep(unique(d$Time), 2)
ticks <- ticks[seq(1, 48, by = 3)]
axis(side = 1, 
     at = seq(1, 48, by = 3),
     labels = ticks)

sub_d <- filter(d, Time %in% ticks)

clear_sky <- readPNG("Figures/clear_sky.png")
overcast <- readPNG("Figures/overcast.png")
light_rain <- readPNG("Figures/light_rain.png")
broken_clouds <- readPNG("Figures/broken_clouds.png")

for (x in seq_len(length(ticks)) * 2) {
  choice <- as.integer(runif(1, 1, 4))
  img <- switch (choice,
    clear_sky,
    overcast,
    light_rain,
    broken_clouds
  )
  rasterImage(img, 
              3 / 2 * x - 3, 
              0.25, 
              3 / 2 * x - 1,
              0.75)
}
