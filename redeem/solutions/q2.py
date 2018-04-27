#!/usr/bin/python
import sys

data=sys.argv[1]
array=data.split(",")
i=0
for x in array :
	array[i]=int(array[i])
array.sort(key=int)	
#	print '%d is in %d th position' % (array[i],i)
#	i=i+1
def findheight(number):
	" this calculates the height of a balanced bst with given number of nodes"
	if number == 1:
		return 1;
	elif number == 2:
		return 2; 
	newnum=int(number/2)
	return findheight(newnum)+1;	
length=len(array)
#print length
height=findheight(len(array))
# #print height
for i in range(0,height):
	i1=0
	i2=0
	prevj='#'
	j=0
	while(i2<length):
		while(array[i1]=='$'):
		 	i1=i1+1
		i2=i1	
		while(i2<length and array[i2]!='$'):
			i2=i2+1
		i2=i2-1
		j=(i1+i2)/2
		#print i1,i2,j
		if prevj=='#' :
		 	sub=0
		else :
		 	sub=prevj+1
		#print sub	
		for k in range(0,j-sub):
			sys.stdout.write(' ')
		print array[j],
		array[j]='$'
		prevj=j
		if i2==length-1 :
			break
		else :
			i2=i2+1
			if(i2>=length-1):
				break
			while(array[i2]=='$'):
				i2=i2+1
			i1=i2		
	print
#	print array
sys.stdout.flush()
#print array