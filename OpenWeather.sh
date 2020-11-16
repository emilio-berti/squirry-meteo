#!/bin/bash

KEY=$(cat apikey.txt)

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

rm *csv

meteo_lon_lat() {
	curl -s http://api.openweathermap.org/data/2.5/onecall?lat=$1\&lon=$2\&appid={$KEY}\&units=metric -o tmp.json
	python3 -m json.tool tmp.json > tmp.txt
	head -n 9 tmp.txt | tail -n 2 | tr -d ' ' > tmp_sun.txt
	head -n 11 tmp.txt | tail -n 2 | tr -d ' ' > tmp_temp.txt
	main=$(head -n 24 tmp.txt | tail -n 1 | tr -d '",' | cut -d ':' -f 2)
	tail -n +275 tmp.txt | head -n 1010 > tmp_forecast.txt
	grep -wE 'feels_like|description|dt' tmp_forecast.txt | tr -s ' ' | tr -d '",' > tmp_hourly.txt
	R CMD BATCH format_forecasts.R #using tidyverse magic
	# sunrise/set
	while read line
	do
		what=$(echo $line | cut -d ":" -f 1 | tr -d '"')
		what="${what^}" #capitalize
		at=$(echo $line | cut -d ":" -f 2 | tr -d ',')
		echo '    ' $what at $(date -d @$at | cut -d " " -f 5,6)
	done < tmp_sun.txt
	echo 
	# temperature
	while read line
	do
		what=$(echo $line | cut -d ":" -f 1 | tr -d '"')
		if [ $what == 'temp' ]
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
		sky=$(echo $line | cut -d ',' -f 3 | tr ' ' '-')
		echo $(date -d @$at +'%D %H') $temp $sky
	done < tmp_hourly.txt > $3.csv
	cat $3.csv >> $3_long.txt
	# gnuplot -e "filename='$3.csv'" plot_temperature.p
	# feh tmp.png
}

# current date and time
echo
date
echo

if [ -n $1 ]
then
	if [[ $1 == '-v' ]]
	then
		echo ' ----------------- Leipzig ----------------- '
		meteo_lon_lat $LeipzigLat $LeipzigLon Leipzig

		echo ' ----------------- Aarhus ------------------ '
		meteo_lon_lat $AarhusLat $AarhusLon Aarhus
		
		echo ' ----------------- Macon ------------------- '
		#meteo_lon_lat $MaconLat $MaconLon Macon

		echo ' ----------------- Prato ------------------- '
		#meteo_lon_lat $PratoLat $PratoLon Prato

		echo ' ----------------- Schaffhausen ------------ '
		#meteo_lon_lat $SchaffhausenLat $SchaffhausenLon Schaffhausen

		echo ' ----------------- Stara Zagora ------------ '
		#meteo_lon_lat $StaraLat $StaraLon 'StaraZagora'
	else
		meteo_lon_lat $LeipzigLat $LeipzigLon Leipzig > /dev/null
		meteo_lon_lat $AarhusLat $AarhusLon Aarhus > /dev/null
		#meteo_lon_lat $MaconLat $MaconLon Macon > /dev/null
		meteo_lon_lat $PratoLat $PratoLon Prato > /dev/null
		#meteo_lon_lat $SchaffhausenLat $SchaffhausenLon Schaffhausen > /dev/null
		meteo_lon_lat $StaraLat $StaraLon 'StaraZagora' > /dev/null
	fi
fi

R CMD BATCH ggplot_temperature.R
<<<<<<< HEAD
convert combined_plot.png -rotate 90 combined_plot-mobile.png 
eog combined_plot.png &
eog combined_plot-mobile.png &
=======
convert combined_plot.png -rotate 90 combined_plot-mobile.png
convert combined_sky.png -rotate 90 combined_sky-mobile.png

eog -f combined_plot.png &
#eog combined_plot-mobile.png &
eog -f combined_sky.png &
#eog combined_sky-mobile.png &
>>>>>>> f4869568c60ee765d84e08ca68cc73c0e25bf8b6

#rm tmp*
#rm *csv
#rm *Rout
#rm *pdf
