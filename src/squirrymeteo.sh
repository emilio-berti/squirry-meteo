#!/bin/bash

cd ~/squirry-meteo

echo ' - Getting OpenWeather data'
bash src/get-opendata.sh

echo ' - Parsing and plotting in python'
python3 src/process-data.py

filename=$(date | tr ' ' '_')
cp plot.pdf oldplots/$filename.pdf
if [ $# -ne 0 ]
then
  if [[ $1 = "-"*"p"* ]]
  then
    evince plot.pdf &
  fi
fi
