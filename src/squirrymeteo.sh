#!/bin/bash

cd ~/squirry-meteo

echo ' - Getting OpenWeather data'
bash get-opendata.sh

echo ' - Parsing and plotting in python'
python3 process-data.py

filename=$(date | tr ' ' '_')
cp plot.pdf oldplots/$filename.pdf
# evince plot.pdf &
