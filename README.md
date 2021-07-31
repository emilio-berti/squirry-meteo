Store the OpenWeather API key in `src/apikey.txt`.

Repositoty structure:

```
.
├── data
│   ├── olddata
│   │   ├── 2021-07-18_18:00:36.csv
│   │   ├── 2021-07-18_19:00:19.csv
│   │   ├── 2021-07-18_20:01:34.csv
│   │   ├── 2021-07-18_21:00:35.csv
│   │   ├── 2021-07-18_22:00:27.csv
│   │   ├── 2021-07-19_20:00:42.csv
│   │   ├── 2021-07-19_21:01:06.csv
│   │   ├── 2021-07-20_08:00:21.csv
│   │   ├── 2021-07-20_09:00:31.csv
│   │   ├── 2021-07-20_12:00:17.csv
│   │   ├── 2021-07-20_13:00:13.csv
│   │   ├── 2021-07-20_14:01:06.csv
│   │   ├── 2021-07-20_15:00:42.csv
│   │   ├── 2021-07-20_17:01:43.csv
│   │   ├── 2021-07-20_18:00:33.csv
│   │   ├── 2021-07-20_20:00:36.csv
│   │   ├── 2021-07-20_21:00:14.csv
│   │   ├── 2021-07-20_22:00:37.csv
│   │   ├── 2021-07-21_20:00:29.csv
│   │   ├── 2021-07-21_20:06:54.csv
│   │   ├── 2021-07-21_20:07:55.csv
│   │   ├── 2021-07-21_21:00:31.csv
│   │   ├── 2021-07-22_20:00:34.csv
│   │   ├── 2021-07-22_21:00:38.csv
│   │   ├── 2021-07-22_22:00:41.csv
│   │   ├── 2021-07-24_10:00:18.csv
│   │   ├── 2021-07-24_11:00:08.csv
│   │   ├── 2021-07-24_16:00:31.csv
│   │   ├── 2021-07-24_20:00:43.csv
│   │   ├── 2021-07-24_21:00:44.csv
│   │   ├── 2021-07-24_22:00:05.csv
│   │   ├── 2021-07-25_08:00:57.csv
│   │   ├── 2021-07-25_09:00:06.csv
│   │   ├── 2021-07-25_11:00:06.csv
│   │   ├── 2021-07-25_12:00:27.csv
│   │   ├── 2021-07-25_13:00:40.csv
│   │   ├── 2021-07-25_16:00:05.csv
│   │   ├── 2021-07-25_20:00:29.csv
│   │   ├── 2021-07-25_21:00:05.csv
│   │   ├── 2021-07-30_15:00:09.csv
│   │   ├── 2021-07-30_15:25:24.csv
│   │   ├── 2021-07-31_09:00:44.csv
│   │   ├── 2021-07-31_09:13:41.csv
│   │   └── 2021-07-31_09:16:27.csv
│   └── opendata
│       ├── aarhus.json
│       ├── leipzig.json
│       ├── macon.json
│       ├── prato.json
│       ├── schaffhausen.json
│       └── stara.json
├── figures
│   ├── broken_clouds.png
│   ├── clear_sky.png
│   ├── light_rain.png
│   └── overcast.png
├── oldplots
│   ├── Fri_30_Jul_15:00:09_CEST_2021.pdf
│   ├── Fri_30_Jul_15:25:25_CEST_2021.pdf
│   ├── Fri_30_Jul_21:01:35_CEST_2021.pdf
│   ├── Mon_19_Jul_20:00:42_CEST_2021.pdf
│   ├── Mon_19_Jul_21:01:07_CEST_2021.pdf
│   ├── Sat_24_Jul_10:00:18_CEST_2021.pdf
│   ├── Sat_24_Jul_11:00:08_CEST_2021.pdf
│   ├── Sat_24_Jul_16:00:31_CEST_2021.pdf
│   ├── Sat_24_Jul_20:00:43_CEST_2021.pdf
│   ├── Sat_24_Jul_21:00:45_CEST_2021.pdf
│   ├── Sat_24_Jul_22:00:05_CEST_2021.pdf
│   ├── Sat_24_Jul_23:00:36_CEST_2021.pdf
│   ├── Sat_31_Jul_09:00:44_CEST_2021.pdf
│   ├── Sun_18_Jul_18:00:37_CEST_2021.pdf
│   ├── Sun_18_Jul_19:00:20_CEST_2021.pdf
│   ├── Sun_18_Jul_20:01:34_CEST_2021.pdf
│   ├── Sun_18_Jul_21:00:35_CEST_2021.pdf
│   ├── Sun_18_Jul_22:00:28_CEST_2021.pdf
│   ├── Sun_25_Jul_08:00:58_CEST_2021.pdf
│   ├── Sun_25_Jul_09:00:07_CEST_2021.pdf
│   ├── Sun_25_Jul_11:00:06_CEST_2021.pdf
│   ├── Sun_25_Jul_12:00:27_CEST_2021.pdf
│   ├── Sun_25_Jul_13:00:40_CEST_2021.pdf
│   ├── Sun_25_Jul_16:00:05_CEST_2021.pdf
│   ├── Sun_25_Jul_20:00:30_CEST_2021.pdf
│   ├── Sun_25_Jul_21:00:05_CEST_2021.pdf
│   ├── Thu_22_Jul_19:00:27_CEST_2021.pdf
│   ├── Thu_22_Jul_20:00:34_CEST_2021.pdf
│   ├── Thu_22_Jul_21:00:39_CEST_2021.pdf
│   ├── Thu_22_Jul_22:00:41_CEST_2021.pdf
│   ├── Tue_20_Jul_08:00:22_CEST_2021.pdf
│   ├── Tue_20_Jul_09:00:31_CEST_2021.pdf
│   ├── Tue_20_Jul_10:00:40_CEST_2021.pdf
│   ├── Tue_20_Jul_11:00:24_CEST_2021.pdf
│   ├── Tue_20_Jul_12:00:18_CEST_2021.pdf
│   ├── Tue_20_Jul_13:00:13_CEST_2021.pdf
│   ├── Tue_20_Jul_14:01:06_CEST_2021.pdf
│   ├── Tue_20_Jul_15:00:42_CEST_2021.pdf
│   ├── Tue_20_Jul_16:00:41_CEST_2021.pdf
│   ├── Tue_20_Jul_17:01:44_CEST_2021.pdf
│   ├── Tue_20_Jul_18:00:34_CEST_2021.pdf
│   ├── Tue_20_Jul_20:00:36_CEST_2021.pdf
│   ├── Tue_20_Jul_21:00:14_CEST_2021.pdf
│   ├── Tue_20_Jul_22:00:37_CEST_2021.pdf
│   ├── Wed_21_Jul_20:00:30_CEST_2021.pdf
│   ├── Wed_21_Jul_20:07:01_CEST_2021.pdf
│   ├── Wed_21_Jul_20:07:56_CEST_2021.pdf
│   └── Wed_21_Jul_21:00:32_CEST_2021.pdf
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

6 directories, 113 files
```
