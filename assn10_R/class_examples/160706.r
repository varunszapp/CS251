num_samples <- 50000
data <- rexp(num_samples, 0.2)
x <- data.frame(X = seq(1, num_samples , 1), Y = sort(data))
plot(x)

xm <- matrix( data, nrow=500 )

for(j in 1:5){
	pdata <- rep(0, 100);

	for(i in 1:100){
	    val=round(xm[[j,i]], 0);
	    if(val <= 100){
	       pdata[val] = pdata[val] + 1/ 100; 
	    }
	}

	xcols <- c(0:99)
	plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

	cdata <- rep(0, 100)

	cdata[1] <- pdata[1]

	for(i in 2:100){	
    	cdata[i] = cdata[i-1] + pdata[i]
	}

	plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");
	print (mean(xm[j,]))
	print (sd(xm[j,]))
}

m<-rep(0,500)
for(i in 1:500)
{
	m[i]<-mean(xm[i,])
}

tab <- table(round(m,1))
plot(tab, "h", xlab="Value", ylab="Frequency")

pdata <- rep(0, 100);

for(i in 1:500){
    val=round(m[i], 1);
    if(val*10 <= 100){
       pdata[val*10] = pdata[val*10] + 1/ 500; 
    }
}

xcols <- seq(0,9.9,0.1)

plot(xcols, pdata, "l", main="P.D.F of means",xlab="X", ylab="f(X)")

cdata[1] <- pdata[1]

	for(i in 2:100){	
    	cdata[i] = cdata[i-1] + pdata[i]
	}
plot(xcols, cdata, "o",main="C.D.F of means", col="blue", xlab="X", ylab="F(X)");

print(mean(m))
print(sd(m))

