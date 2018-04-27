set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

#set format y "10^{%L}"
set xlabel "Number of Elements"
set ylabel "Time in microsecs"
set yrange[0:60000]
set xrange[0:1000000]
set ytic auto
set xtic auto
set autoscale
set logscale x

set output "scatter.eps"
plot 'output_1_thread.txt' using 1:2 title "1 thread" with points pt 1 ps 1.5,\
 'output_2_thread.txt' using 1:2 title "2 threads" with points pt 1 ps 1.5,\
 'output_4_thread.txt' using 1:2 title "4 threads" with points pt 1 ps 1.5,\
 'output_8_thread.txt' using 1:2 title "8 threads" with points pt 1 ps 1.5,\
 'output_16_thread.txt' using 1:2 title "16 threads" with points pt 1 ps 1.5
