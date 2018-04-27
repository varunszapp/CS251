#!/bin/bash
#author : Sriram Varun Vobilisetty
#date : 21/1/18
#description : this bash script takes an input as an argument and checks whether or not it lies in the range [0,9999,999,999]

let num=$1

calcdig(){
local i=$1
let local j=$(($i-1))
let local pow=10**j
let local d=$num/$pow
let d=$d%10
echo $d
}

print_dig(){
case $1 in
1)name=`echo "$name one"`;;
2)name=`echo "$name two"`;;
3)name=`echo "$name three"`;;
4)name=`echo "$name four"`;;
5)name=`echo "$name five"`;;
6)name=`echo "$name six"`;;
7)name=`echo "$name seven"`;;
8)name=`echo "$name eight"`;;
9)name=`echo "$name nine"`;;
esac
}

addtoname(){
case $1 in
11)	
	local d=`calcdig 11`
	print_dig $d
	name=`echo "$name thousand"`
;;

10)
	local d=`calcdig 10`
	if [ $d -ne 0 ]
	then 
		print_dig $d
		name=`echo "$name hundred"`
	fi
;;

9)
        
	local dig9=`calcdig 9`
	if [ $dig9 -ne 0 ]
	then 
	case $dig9 in 
	1)
		local dig8=`calcdig 8`
		case $dig8 in
		0) name=`echo "$name ten"`;;
		1) name=`echo "$name eleven"`;;
		2) name=`echo "$name twelve"`;;
		3) name=`echo "$name thirteen"`;;
		4) name=`echo "$name fourteen"`;;
		5) name=`echo "$name fifteen"`;;
		6) name=`echo "$name sixteen"`;;
		7) name=`echo "$name seventeen"`;;
		8) name=`echo "$name eighteen"`;;
		9) name=`echo "$name ninteen"`;;
		esac
	;;
	2) name=`echo "$name twenty"` ;;
	3) name=`echo "$name thirty"` ;;
	4) name=`echo "$name forty"`  ;;
	5) name=`echo "$name fifty"`  ;;
        6) name=`echo "$name sixty"`  ;;
	7) name=`echo "$name seventy"`;;
	8) name=`echo "$name eighty"` ;;
	9) name=`echo "$name ninety"` ;;
	esac
	fi
;;

8)	local d=`calcdig 8`
	if ! [[ $d == [0] ]]
	then 
		if [ $l -gt 8 ]
			then
			local dig9=`calcdig 9`
			if [ $dig9 -ne 1 ]
			then	
			print_dig $d	
			fi	
		else
				print_dig $d		
		fi
	fi	
	name=`echo "$name crore"`
;;

7)	
	local dig7=`calcdig 7`
	if [ $dig7 -ne 0 ]
	then 
	case $dig7 in 
	1)
		local dig6=`calcdig 6`
		case $dig6 in
		0) name=`echo "$name ten"`;;
		1) name=`echo "$name eleven"`;;
		2) name=`echo "$name twelve"`;;
		3) name=`echo "$name thirteen"`;;
		4) name=`echo "$name fourteen"`;;
		5) name=`echo "$name fifteen"`;;
		6) name=`echo "$name sixteen"`;;
		7) name=`echo "$name seventeen"`;;
		8) name=`echo "$name eighteen"`;;
		9) name=`echo "$name ninteen"`;;
		esac
	;;
	2) name=`echo "$name twenty"` ;;
	3) name=`echo "$name thirty"` ;;
	4) name=`echo "$name forty"`  ;;
	5) name=`echo "$name fifty"`  ;;
        6) name=`echo "$name sixty"`  ;;
	7) name=`echo "$name seventy"`;;
	8) name=`echo "$name eighty"` ;;
	9) name=`echo "$name ninety"` ;;
	esac
	fi
;;

6)	local d=`calcdig 6`
	if ! [[ $d == [0] ]]
	then 
		if [ $l -gt 6 ]
			then
			local dig7=`calcdig 7`
			if [ $dig7 -ne 1 ]
			then	
			print_dig $d	
			fi	
		else
				print_dig $d		
		fi
	fi	
	name=`echo "$name lakh"`
;;

5)	local dig5=`calcdig 5`
	if [ $dig5 -ne 0 ]
	then 
	case $dig5 in 
	1)
		local dig4=`calcdig 4`
		case $dig4 in
		0) name=`echo "$name ten"`;;
		1) name=`echo "$name eleven"`;;
		2) name=`echo "$name twelve"`;;
		3) name=`echo "$name thirteen"`;;
		4) name=`echo "$name fourteen"`;;
		5) name=`echo "$name fifteen"`;;
		6) name=`echo "$name sixteen"`;;
		7) name=`echo "$name seventeen"`;;
		8) name=`echo "$name eighteen"`;;
		9) name=`echo "$name ninteen"`;;
		esac
	;;
	2) name=`echo "$name twenty"` ;;
	3) name=`echo "$name thirty"` ;;
	4) name=`echo "$name forty"`  ;;
	5) name=`echo "$name fifty"`  ;;
        6) name=`echo "$name sixty"`  ;;
	7) name=`echo "$name seventy"`;;
	8) name=`echo "$name eighty"` ;;
	9) name=`echo "$name ninety"` ;;
	esac
	fi
;;

4)	local d=`calcdig 4`
	if ! [[ $d == [0] ]]
	then 
		if [ $l -gt 4 ]
			then
			local dig5=`calcdig 5`
			if [ $dig5 -ne 1 ]
			then
			print_dig $d	
			fi	
		else
				print_dig $d		
		fi
	fi	
	name=`echo "$name thousand"`
;;

3)	local d=`calcdig 3`
	if [ $d -ne 0 ]
	then 
		print_dig $d		
	fi
	name=`echo "$name hundred"`
;;	

2)	local dig2=`calcdig 2`
	if [ $dig2 -ne 0 ]
	then 
	case $dig2 in 
	1)
		local dig1=`calcdig 1`
		case $dig1 in
		0) name=`echo "$name ten"`;;
		1) name=`echo "$name eleven"`;;
		2) name=`echo "$name twelve"`;;
		3) name=`echo "$name thirteen"`;;
		4) name=`echo "$name fourteen"`;;
		5) name=`echo "$name fifteen"`;;
		6) name=`echo "$name sixteen"`;;
		7) name=`echo "$name seventeen"`;;
		8) name=`echo "$name eighteen"`;;
		9) name=`echo "$name ninteen"`;;
		esac
	;;
	2) name=`echo "$name twenty"` ;;
	3) name=`echo "$name thirty"` ;;
	4) name=`echo "$name forty"`  ;;
	5) name=`echo "$name fifty"`  ;;
        6) name=`echo "$name sixty"`  ;;
	7) name=`echo "$name seventy"`;;
	8) name=`echo "$name eighty"` ;;
	9) name=`echo "$name ninety"` ;;
	esac
	fi
;;

1) 	
    local d=`calcdig 1`
	if ! [[ $d == [0] ]]
	then 
		if [ $l -gt 1 ]
			then
			local dig2=`calcdig 2`
			if [ $dig2 -ne 1 ]
			then
			print_dig $d	
			fi	
		else
				print_dig $d		
		fi
	fi	

;;
esac
}


if [ $# -ne 1 ]
then	
	echo invalid input #if we give less or more arguments , its an invalid input
	exit
fi

#regex='^0*[1-9]{0,10}$'

echo "$1" | grep -q "[^0-9]"
if [ $? -eq 0 ]
then                            #if there is anythng other than digits , declassify it
echo invalid input
exit
fi 

#now we have only a single string of numbers

echo "$1" | grep -q "^0*$"
if [ $? -eq 0 ]
then                            #if there is only zeroes , print zero and exit
echo zero
exit
fi 

n=`echo "$1" | sed "s/"^0*"//g"` #removing all starting zeroes

l=`echo -n $n | wc -m`

#if [ $l -eq 1 ]
#then 
#print_dig $1
#exit
#fi




# now we have a single number in the given range , all thats left to do is to write it in the word form

for(( int=$l; int>=1;int-- ))
do
	addtoname $int
done

echo $name



