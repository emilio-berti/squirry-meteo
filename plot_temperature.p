set terminal png size 1200, 500
set xdata time
set format x "%d/%H"
set timefmt "%m/%d/%y %H:%M"
set output 'tmp.png'
plot filename using 1:3 with linespoints title filename