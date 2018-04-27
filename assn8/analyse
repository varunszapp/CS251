#!/bin/bash
rm -f params_* *thread.txt *avgs* *vars* *speedup*
for a in `cat params.txt`
	do
		echo $a >> params_line.txt
	done
for thread in `cat threads.txt`
do
	sed -i 's/[^0-9]*//g' output_${thread}_thread_y.txt
	paste output_${thread}_thread_x.txt output_${thread}_thread_y.txt > output_${thread}_thread.txt
	sum=0
	sum_sq=0
	i=0
	while read p; do
  	let i=i+1
  	let sum=sum+$p
  	let sum_sq=sum_sq+$p*$p
  	if (( $i==100 ))
  	then
  		let sum=sum/100
  		let sum_sq=sum_sq/100
  		let var=sum_sq-sum*sum
  		echo $sum >> thread_${thread}_avgs.txt
  		echo $var >> ${thread}_vars.txt
  		let sum=0
  		let sum_sq=0
  		let i=0
  	fi 
	done <output_${thread}_thread_y.txt	

	paste params_line.txt thread_${thread}_avgs.txt > ${thread}_avgs.txt
	
	no_params=`cat params.txt | wc -w`

	let i=1
	while read line;do
		let a[$i]=$line
		let i=i+1
	done <thread_1_avgs.txt
	
	let i=1	
	while read b;do	
		echo `bc -l <<< "scale=2; $b/${a[$i]}"` >> ${thread}_speedup.txt
		let i=i+1
	done<thread_${thread}_avgs.txt
	
	while read line;do
		let b[i]=$line
		let i=i+1
	done <thread_${thread}_avgs.txt

	let i=1
	let sum=0
	while read p; do
  	let i=i+1
  	let sum=sum+$p
  	if (( $i==100 ))
  	then
  		let  sum=sum/100
  		echo $sum >> thread_${thread}_avgs.txt
  		let sum=0
  		let i=0
  	fi 
	done <output_${thread}_thread_y.txt	

done

paste params_line.txt 2_speedup.txt 4_speedup.txt 8_speedup.txt 16_speedup.txt > speedup.txt
paste speedup.txt 2_vars.txt 4_vars.txt 8_vars.txt 16_vars.txt > vars.txt
rm ?_speedup*