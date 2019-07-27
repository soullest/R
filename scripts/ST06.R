inf = read.csv("../data/tema6/infy-monthly.csv")

inf.ts =ts(inf$Adj.Close,start=c(1999,3),frequency = 12)
plot(inf.ts)

inf.hw = HoltWinters(inf.ts)
plot(inf.hw,col="blue",col.predicted = "red")

install.packages("forecast")
library(forecast)

inf.fore = forecast(inf.hw,h=24)
plot(inf.fore)
inf.fore$lower
inf.fore$upper
