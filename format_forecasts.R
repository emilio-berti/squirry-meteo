d <- read.csv("tmp_hourly.txt", 
              sep = ":", 
              header = FALSE)
if (nrow(d) %% 3 > 0) {
	i <- 1
	while (nrow(d[1:(nrow(d) - i), ]) %% 3 > 0) {
		i <- i + 1
	}
	d <- d[1:(nrow(d) - i), ]
}
d <- tibble::as_tibble(d)
d <- dplyr::transmute_all(d, as.vector)
d <- tidyr::pivot_wider(d, names_from = V1, values_from = V2)
d <- tidyr::unnest(d, cols = c(` dt`, ` feels_like`, ` description`))
readr::write_csv(d, 
          "tmp_hourly.txt", 
          col_names = FALSE)
