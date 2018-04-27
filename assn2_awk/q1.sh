#!/bin/bash
regex='.*\.c$'
comments=0
strings=0
recurse(){
	cd "$1"
	for line in *
	do 
		if [ -d "$line" ]
		then
			recurse "$line"
			cd ..
		elif [[ -f "$line" && "$line" =~ $regex ]]
		then
		a=`awk -f ~/count.awk "$line" | head -1`
		comments=$((comments+a))
	    b=`awk -f ~/count.awk "$line" | tail -1`
		strings=$((strings+b))
		fi
	done						
}
recurse "$1"
echo "$comments comments , $strings strings"
