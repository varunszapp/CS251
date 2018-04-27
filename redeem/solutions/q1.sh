#!/bin/bash
file=$1
flag=0
sed -i 's/<\/[^>]*>/\n&\n/g' $file
sed -i 's/<[^>]*>/&\n/g' $file
sed -i '/^$/d' $file
 while read LINE ; do
 	if [[ $LINE =~ ^\<dir\>* ]]
		then 
		flag=1
	elif [[ $LINE =~ ^\<file\>* ]]
		then 
		flag=2
	elif [[ $LINE =~ ^\<name\>* ]] && [[ $flag -eq 1 ]] 
		then 
 		flag=3
 	elif [[ $LINE =~ ^\<name\>* ]] && [[ $flag -eq 2 ]]
		then
		flag=4
	elif [[ $LINE =~ ^\<size\>* ]] 
		then
		flag=5	
	elif [[ $LINE =~ ^\<.file\>* ]] || [[ $LINE =~ ^\<.name\>* ]] || [[ $LINE =~ ^\<.size\>* ]]
		then
		flag=0
	elif [[ $LINE =~ ^\<.dir\>* ]]
		then 
		cd ..
		flag=0		
	elif [[ flag -eq 3 ]] 
		then 
		name=$LINE
		mkdir $name
		cd $name
	elif [[ flag -eq 4 ]]
		then
		name=$LINE
	elif [[ flag -eq 5 ]]
		then
		size=$LINE
		fallocate -l $size $name			
	fi
done < $file
