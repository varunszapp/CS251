#!/usr/bin/python
from numpy.linalg import inv
import matplotlib.pyplot as plt
import sys
import numpy as np
from numpy import newaxis
import copy
csv=np.genfromtxt("train.csv",delimiter=',')
X_train = np.zeros(shape=(10000,1));
X_train[:,0]=copy.deepcopy(csv[1:10001,0])
#print X_train
new_X_train=np.zeros(shape=(10000,2))
new_X_train[:,0]=copy.deepcopy(np.ones(10000))
new_X_train[:,1]=copy.deepcopy(csv[1:10001,0])
#print new_X_train
w=np.random.rand(2,1)
#print w
Y_train=np.zeros(shape=(10000,1));
Y_train[:,0]=copy.deepcopy(csv[1:10001,1])
plt.plot(X_train,Y_train,'ro')
plt.xlabel('feature')
plt.ylabel('label')
new_X_train_1=np.transpose(new_X_train)
w_new=np.transpose(w)
#print new_X_train_1
plotpdt=np.matmul(w_new,new_X_train_1)
plotpdt=np.transpose(plotpdt)
#print plotpdt
plt.plot(X_train,plotpdt)
plt.show()
w_direct=np.matmul(inv(np.matmul(new_X_train_1,new_X_train)),np.matmul(new_X_train_1,Y_train))
plotpdt_new=np.matmul(np.transpose(w_direct),new_X_train_1)
plotpdt_new=np.transpose(plotpdt_new)
plt.plot(X_train,plotpdt_new)
#print plotpdt_new
#print X_train
plt.show()
#print w
#print w_new
eta=0.00000001
for x in range(0,3):
	for y in range(0,10000):
		X=X_train[y,0]
#		print X
		Y=Y_train[y,0]
#		print X
#		print Y	
		Xmat=np.matrix([[1], [X]])
#		print Xmat
		xint=np.matmul(np.transpose(w),Xmat)
#		print xint
#		print np.matrix([[Y]])
		yint=np.subtract(xint,np.matrix([[Y]]))
#		print yint
		pint=eta*yint
#		print pint
		Pint=pint[0,0]
#		print Pint
		qint=Pint*Xmat
#		print qint
#		print w
		w=np.subtract(w,qint)
#		print w
#		w_new=np.transpose(w)
#		print np.transpose(w)
		if y%100==0:
#			print y
			plot_pdt_cur=np.matmul(np.transpose(w),new_X_train_1)
			plot_pdt_cur=np.transpose(plot_pdt_cur)
#			print plot_pdt_cur
			cur_plot = np.squeeze(np.asarray(plot_pdt_cur)) 
			cur_X = np.squeeze(np.asarray(X_train))
#			print cur_plot
#			print cur_X
			plt.plot(cur_X,cur_plot)
plt.show()		

plt.plot(X_train,Y_train,'ro')
plt.xlabel('feature')
plt.ylabel('label')
plt.plot(cur_X,cur_plot)
plt.show()

X_test = np.zeros(shape=(1000,1));
Y_test=np.zeros(shape=(1000,1));
csv=np.genfromtxt("test.csv",delimiter=',')
X_test[:,0]=copy.deepcopy(csv[1:1001,0])
Y_test[:,0]=copy.deepcopy(csv[1:1001,0])
new_X_test=np.zeros(shape=(1000,2))
new_X_test[:,0]=copy.deepcopy(np.ones(1000))
new_X_test[:,1]=copy.deepcopy(csv[1:1001,0])
y_pred_1=np.matmul(new_X_test,w)
y_pred_2=np.matmul(new_X_test,w_direct)
sub1=np.subtract(y_pred_1,Y_test)
sub2=np.subtract(y_pred_2,Y_test)
sq1=np.square(sub1)
sq2=np.square(sub2)
add1=np.sum(sq1)
add2=np.sum(sq2)
add1/=1000
add2/=1000
rms1=add1**0.5
rms2=add2**0.5
print rms1
print rms2

	




























