#!/bin/bash

cd ~/Proj/squirry-meteo

echo ' - Getting OpenWeather data'
bash get-opendata.sh

echo ' - Parsing and plotting in python'
python3 process-data.py

evince plot.pdf &