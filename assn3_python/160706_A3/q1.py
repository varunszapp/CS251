#!/usr/bin/python
from __future__ import division
from __future__ import print_function
import sys
base=0
for x in sys.argv[2]:
     base=base*10+(ord(x)-ord('0'))
if base < 2 or base > 36 :
	print ("invalid input")
	quit()
dots=0
negative=0
if sys.argv[1][0]=='-':
	negative+=1
	sys.argv[1]=sys.argv[1][1:]
for y in sys.argv[1]:
	n=ord(y)
	if y == '.':dots+=1
	else: 
		if base<11:
			if not (n>47 and n<48+base):
				print ("invalid input")
				quit()
		left=base-10
		if not ((n>47 and n<58) or (n>64 and n<65+left)):
			 print ("invalid input")           
                	 quit()		
if dots>1:
	print ("invalid input")
	quit()
if sys.argv[1][0]=='.':
	print ("invalid input")
        quit()
index=0
dotaftrzero=0
for x in sys.argv[1]:
	if x!='0':
		if x=='.':dotaftrzero+=1
		break
	index+=1
sys.argv[1]=sys.argv[1][index:]
if dotaftrzero==1:sys.argv[1]='0'+sys.argv[1]
indexofdot=0
if dots==1:
	for x in sys.argv[1]:
		if x=='.':
			break
		indexofdot+=1
#print indexofdot
#print sys.argv[1]
if negative!=0: print ('-',end='')
i=0
if dots==1:i=indexofdot
else : i=len(sys.argv[1])
ans=0
for x in sys.argv[1][0:i]:
	pres=ord(x)
	if pres>47 and pres<58:pres=pres-ord('0')
	else : pres=pres-ord('A')+10
	ans=ans*base+pres
print (ans,end='')
if dots!=0:
	string=sys.argv[1][indexofdot+1:][::-1]
	ans=0
	for x in string:
		pres=ord(x)
       		if pres>47 and pres<58:pres=pres-ord('0')
       		else : pres=pres-ord('A')+10
		pres=pres/base
        	ans=ans/base+pres
	ans=str(ans)
	ans=ans[1:]
	print (ans)		
