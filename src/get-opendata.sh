#!/bin/bash

KEY=$(cat src/apikey.txt)

AarhusLat=56.162939
AarhusLon=10.203921

LeipzigLat=51.33962
LeipzigLon=12.37129

MaconLat=46.474214
MaconLon=4.512002

PratoLat=43.53286
PratoLon=11.04407

SchaffhausenLat=47.696607
SchaffhausenLon=8.630870

StaraLat=42.425777
StaraLon=25.634464

meteo_lon_lat() {
	curl -s http://api.openweathermap.org/data/2.5/onecall?lat=$1\&lon=$2\&appid={$KEY}\&units=metric
}

meteo_lon_lat $LeipzigLat $LeipzigLon > data/opendata/leipzig.json
meteo_lon_lat $AarhusLat $AarhusLon > data/opendata/aarhus.json
meteo_lon_lat $MaconLat $MaconLon > data/opendata/macon.json
meteo_lon_lat $PratoLat $PratoLon > data/opendata/prato.json
meteo_lon_lat $SchaffhausenLat $SchaffhausenLon > data/opendata/schaffhausen.json
meteo_lon_lat $StaraLat $StaraLon > data/opendata/stara.json
