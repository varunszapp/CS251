temp=csvread('train.csv');
temp(1,:)=[];
x_train=temp(:,1);
y_train=temp(:,2);
x_train=[ones(size(x_train, 1), 1) ,x_train];
hold on;
scatter(x_train(:,2),y_train);
print -dpdf "fig1.pdf";
close
