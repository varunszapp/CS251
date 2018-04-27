docs = doc.log doc.aux doc.out doc.pdf

eps_files = scatter.eps lineplot.eps speedup.eps errorbar.eps

run_test_files= output_1_thread_x.txt output_2_thread_x.txt output_4_thread_x.txt output_8_thread_x.txt output_16_thread_x.txt \
 output_1_thread_y.txt output_2_thread_y.txt output_4_thread_y.txt output_8_thread_y.txt output_16_thread_y.txt

analyse_files= params_line.txt output_1_thread.txt output_2_thread.txt output_4_thread.txt output_8_thread.txt \
output_16_thread.txt output_1_thread_y.txt output_2_thread_y.txt output_4_thread_y.txt output_8_thread_y.txt output_16_thread_y.txt \
thread_1_avgs.txt thread_2_avgs.txt thread_4_avgs.txt thread_8_avgs.txt thread_16_avgs.txt \
1_vars.txt 2_vars.txt 4_vars.txt 8_vars.txt 16_vars.txt \
speedup.txt vars.txt

All: App.exe run_test analyse plot report

App.exe: prog.o thread_function.o
	gcc -o App.exe prog.o thread_function.o -lpthread -lm

prog.o: prog.c common.h
	gcc -c prog.c -o prog.o

thread_function.o: thread_function.c common.h
	gcc -c thread_function.c -o thread_function.o

run_test:$(run_test_files)

$(run_test_files):run.sh params.txt	
	./run.sh params.txt threads.txt

analyse:$(analyse_files)

$(analyse_files):analyse.sh
	./analyse.sh

plot:scatter lineplot barplot errorbarplot

scatter:scatter.eps
scatter.eps:myscatter.p
	gnuplot myscatter.p

lineplot:lineplot.eps
lineplot.eps:mylineplot.p
	gnuplot mylineplot.p

barplot:speedup.eps
speedup.eps:bar.p
	gnuplot	bar.p

errorbarplot:errorbar.eps
errorbar.eps:error_bar.p
	gnuplot error_bar.p			

report:$(docs)

$(docs):doc.tex $(eps_files) 	
	pdflatex doc.tex		

clean:
	rm -f *.o App.exe output* params_* *eps* *avgs* *speedup* *vars* $(docs)
