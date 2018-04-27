set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Number of elements"
set ylabel "Application speedup"
#set yrange[0:]
set ytic auto
set autoscale
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border

set terminal postscript eps enhanced color size 3.9,2.9
set output "errorbar.eps"
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram

plot 'vars.txt' u 2:6:xticlabels(1) title "2 threads",\
'' u 3:7 title "4 threads" fillstyle pattern 7,\
'' u 4:8 title "8 threads" fillstyle pattern 12,\
'' u 5:9 title "16 threads" fillstyle pattern 14