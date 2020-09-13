#!/bin/bash

KEY=$(cat apikey.txt)

LeipzigLat=51.33962
LeipzigLon=12.37129

AarhusLat=56.162939
AarhusLon=10.203921

PratoLat=43.935718
PratoLon=11.094147

StaraLat=42.425777
StaraLon=25.634464

meteo_lon_lat() {
	curl -s http://api.openweathermap.org/data/2.5/onecall?lat=$1\&lon=$2\&appid={$KEY}\&units=metric -o tmp.json
	python3.7 -m json.tool tmp.json > tmp.txt
	head -n 9 tmp.txt | tail -n 2 | tr -d ' ' > tmp_sun.txt
	head -n 11 tmp.txt | tail -n 2 | tr -d ' ' > tmp_temp.txt
	main=$(head -n 24 tmp.txt | tail -n 1 | tr -d '",' | cut -d ':' -f 2)
	tail -n +275 tmp.txt | head -n 1010 > tmp_forecast.txt
	grep -wE 'feels_like|description|dt' tmp_forecast.txt | tr -s ' ' | tr -d '",' > tmp_hourly.txt
	R CMD BATCH format_forecasts.R #using tidyverse magic
	#sunrise/set
	while read line
	do
		what=$(echo $line | cut -d ":" -f 1 | tr -d '"')
		what="${what^}" #capitalize
		at=$(echo $line | cut -d ":" -f 2 | tr -d ',')
		echo '    ' $what at $(date -d @$at | cut -d " " -f 5,6)
	done < tmp_sun.txt
	echo 
	#temperature
	while read line
	do
		what=$(echo $line | cut -d ":" -f 1 | tr -d '"')
		if [ $what == temp ]
		then
			what="Temperature"
		else
			what="Feel temperature"
		fi
		value=$(echo $line | cut -d ":" -f 2 | tr -d ',' | cut -d '.' -f 1)
		echo '    ' $what is $value degrees
	done < tmp_temp.txt
	echo
	echo '     Situation is:' $main
	echo
	echo "     Today's forecasts:"
	echo
	while read line
	do
		at=$(echo $line | cut -d ',' -f 1)
		temp=$(echo $line | cut -d ',' -f 2 | tr -d ' ')
		what=$(echo $line | cut -d ',' -f 3)
		echo '    At' $(date -d @$at | cut -d " " -f 2-3,5-6) ':' $what ', '$temp 'degrees'
	done < tmp_hourly.txt
	while read line
	do
		at=$(echo $line | cut -d ',' -f 1)
		temp=$(echo $line | cut -d ',' -f 2 | tr -d ' ')
		echo $(date -d @$at +'%D %H') $temp
	done < tmp_hourly.txt > $3.csv
	gnuplot -e "filename='$3.csv'" plot_temperature.p
	feh tmp.png
}

#current date and time
echo
date
echo

echo ' ----------------- Leipzig ----------------- '
meteo_lon_lat $LeipzigLat $LeipzigLon Leipzig

echo ' ----------------- Aarhus ------------------ '
meteo_lon_lat $AarhusLat $AarhusLon Aarhus

echo ' ----------------- Prato ------------------- '
meteo_lon_lat $PratoLat $PratoLon Prato

echo ' ----------------- Stara Zagora ------------ '
meteo_lon_lat $StaraLat $StaraLon 'StaraZagora'

#rm tmp*
R CMD BATCH ggplot_temperature.R
eog combined_plot.png