#!/bin/bash

KEY=8d6db5891cb01949929a32e3c74bd955

LeipzigLat=51.33962
LeipzigLon=12.37129

AarhusLat=56.162939
AarhusLon=10.203921

PratoLat=43.935718
PratoLon=11.094147

meteo_lon_lat() {
	curl -s http://api.openweathermap.org/data/2.5/onecall?lat=$1\&lon=$2\&appid={$KEY}\&units=metric -o tmp.json
	python3.7 -m json.tool tmp.json > tmp.txt
	head -n 9 tmp.txt | tail -n 2 | tr -d ' ' > tmp_sun.txt
	head -n 11 tmp.txt | tail -n 2 | tr -d ' ' > tmp_temp.txt
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
	echo
}

#current date and time
echo
date
echo

echo ' ----------------- Leipzig ----------------- '
meteo_lon_lat $LeipzigLat $LeipzigLon

echo ' ----------------- Aarhus ----------------- '
meteo_lon_lat $AarhusLat $AarhusLon

echo ' ----------------- Prato ----------------- '
meteo_lon_lat $PratoLat $PratoLon

rm tmp*