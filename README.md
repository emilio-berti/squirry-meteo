Store the OpenWeather API key in `src/apikey.txt`.

Repositoty structure:

```
.
├── data
│   ├── olddata
│   │   ├── 2021-08-03_11:20:42.csv
│   │   └── 2021-08-03_11:20:54.csv
│   └── opendata
│       ├── aarhus.json
│       ├── leipzig.json
│       ├── macon.json
│       ├── prato.json
│       ├── schaffhausen.json
│       └── stara.json
├── oldplots
│   ├── Tue_03_Aug_2021_11:20:42_AM_CEST.pdf
│   └── Tue_03_Aug_2021_11:20:54_AM_CEST.pdf
├── plot.pdf
├── README.md
└── src
    ├── apikey.txt
    ├── calc-error.R
    ├── format_forecasts.R
    ├── get-opendata.sh
    ├── ggplot_temperature.R
    ├── OpenWeather.sh
    ├── plot_temperature.p
    ├── process-data.py
    └── squirrymeteo.sh

5 directories, 21 files
```
