library(MASS)  #for random number generator of MVN
library(RVAideMemoire) #for MVN qqplot
library(MVN)
library(GGally)

#Lets go over some basic matrix operations
#
#Pratice

V = matrix(c(5,10,15,20),2,2)
V

A<-matrix(c(1,3,2,4),2,2)
A

B<-matrix(c(1,0,0,4),2,2)
B

A+B
A-B

A-V

#transpose
t(A)
A
t(V)

#Careful when multiplying
A*B   #this is element wise multiplication.

#Matrix multiplication
A %*% B


#Inverse
Ainv<-solve(A)
Ainv

#Checking to make sure it is the inverse
A %*% Ainv


#computing an average using matrices
x<-c(1,2,3,4,5)
c.vec<-c(1/5,1/5,1/5,1/5,1/5)

mean(x)
t(c.vec) %*% x


#Summing up the variables
c.vec2<-c(1,1,1,1,1)
sum(x)
t(c.vec2) %*% x


#Doing both calculations simultaneously
c.mat<-rbind(c.vec,c.vec2)
c.mat
c.mat %*% x



###################
#Multivariate Normal
#

#Generating a data set that is multivariate normal
#Initializing the mean and covariance 
mu<-c(10,10,20)
sigma<-matrix(c(2,0,1,0,2,1.5,1,1.5,3),3,3)
mu
sigma

#Correlation between 1 and 2 is 0
0/(sqrt(2)*sqrt(2))
#Correlation between 1 and 3 is
1/(sqrt(2)*sqrt(3))
#Correlation between 2 and 3 is
1.5/(sqrt(2)*sqrt(3))

set.seed(1234)
dataset<-data.frame(mvrnorm(1000,mu,sigma))
View(dataset)
ggpairs(dataset)


#estimating the mean vector
xbar<-apply(dataset,2,mean)
xbar
#Double checking
mean(dataset$X1)
mean(dataset$X2)
mean(dataset$X3)


#estimating the covariance matrix
var(dataset)



#Compared to truth
sigma




#QQplot for MVN
mqqnorm(dataset)


#Tests for MVN distributions
mvn(dataset,mvnTest="royston")
mvn(dataset,mvnTest="mardia")



#Adding outliers to the dataset
dataset<-rbind(dataset,c(200,200,5))
ggpairs(dataset)


#Pointing out normality tests can be triggered due to outliers
result<-mvn(dataset,mvnTest="mardia")
result
mqqnorm(dataset)


