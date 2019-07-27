#Moving avergage
s =read.csv("../data/tema6/ts-example.csv")

n=7
weigths = rep(1/7,n)


s.fil.1 = filter(s$sales,filter = weigths,sides=2)


s.fil.2 = filter(s$sales,filter = weigths,sides=1)

plot(s$sales,type="l")
lines(s.fil.1,type="l",col="blue")
lines(s.fil.2,type="l",col="red")
