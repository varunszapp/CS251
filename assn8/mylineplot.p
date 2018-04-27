#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "Number of elements"
set ylabel "Average execution time"
set ytic auto
set xtic auto
set autoscale
set logscale x
set logscale y

set key bottom right

set output "lineplot.eps"
plot '1_avgs.txt' using 1:2 title "1 thread" with linespoints,\
		'2_avgs.txt' using 1:2 title "2 thread" with linespoints,\
		'4_avgs.txt' using 1:2 title "4 thread" with linespoints,\
		'8_avgs.txt' using 1:2 title "8 thread" with linespoints,\
		'16_avgs.txt' using 1:2 title "16 thread" with linespoints,\