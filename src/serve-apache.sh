#!/bin/bash

bash /home/eb97ziwi/squirry-meteo/src/squirrymeteo.sh
cp /home/eb97ziwi/squirry-meteo/plot.pdf /var/www/squirry/
inkscape /var/www/squirry/plot.pdf -d 600 -e /var/www/squirry/plot.png