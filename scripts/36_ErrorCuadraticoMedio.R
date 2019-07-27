dat = read.csv("../data/tema4/rmse.csv")

ecm = sqrt(mean((dat$price-dat$pred)^2))

plot(dat$price,dat$pred,xlab="Actual",ylab="Predicho")
abline(0,1)

rmse = function(actual,predicted){
  x = sqrt(mean((actual-predicted)^2))
  x
}

rmse(dat$price,dat$pred)
