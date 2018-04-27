#!/bin/bash
rm -f output*

for elements in `cat $1`
do
	for threads in `cat $2`
	do
		if [ $threads == 1 ]; then
			for i in {1..100};do
				echo $elements >> output_1_thread_x.txt		
				./App.exe $elements $threads >> output_1_thread_y.txt
			done	
		elif [ $threads == 2 ]; then
			for i in {1..100};do	
				echo $elements >> output_2_thread_x.txt
				./App.exe $elements $threads >> output_2_thread_y.txt
			done	
		elif [ $threads == 4 ]; then
			for i in {1..100};do		
				echo $elements >> output_4_thread_x.txt
				./App.exe $elements $threads >> output_4_thread_y.txt
			done	
		elif [ $threads == 8 ]; then
			for i in {1..100};do	
				echo $elements >> output_8_thread_x.txt
				./App.exe $elements $threads >> output_8_thread_y.txt
			done	
		else [ $threads == 16 ];
			for i in {1..100};do	
				echo $elements >> output_16_thread_x.txt
				./App.exe $elements $threads >> output_16_thread_y.txt
			done	
		fi
	done
done
