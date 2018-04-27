temp=csvread('train.csv');
temp(1,:)=[];
x_train=temp(:,1);
y_train=temp(:,2);
x_train=[ones(size(x_train, 1), 1) ,x_train];
w=rand(2,1);

hold on;
scatter(x_train(:,2),y_train);
xlabel ("Label");
ylabel ("Feature");
title ("Scatter plot of label vs feature");
plot(x_train(:,2),(w'*x_train'));
pause;
close;

w_direct=inv(x_train'*x_train)*x_train'*y_train;
hold on;
scatter(x_train(:,2),y_train);
plot(x_train(:,2),w_direct'*x_train',"r");
pause;
close;

hold on;
for i = 1:size(y_train)
 	x=[1,x_train(i,2)];
 	y=y_train(i);
 	w=w-(0.00000001)*(w'*x'-y)*x';
 	if (rem(i,100)==0)
  		scatter(x_train(:,2),y_train);
  		plot(x_train(:,2),w'*x_train');
	endif
endfor

pause;
close;

hold on;
scatter(x_train(:,2),y_train);
plot(x_train(:,2),w'*x_train');
pause;
close;

temp1=csvread('test.csv');
temp1(1,:)=[];
x_test=temp1(:,1);
y_test=temp1(:,2);
x_test=[ones(size(x_test, 1), 1) ,x_test];

y_pred1=x_test*w;
y_pred2=x_test*w_direct;
RMSE1 = sqrt(mean((y_pred1 - y_test).^2))
RMSE2 = sqrt(mean((y_pred2 - y_test).^2))
