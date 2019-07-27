#Modelo autoregresivo variante de promedios moviles
inf = read.csv("../data/tema6/infy-monthly.csv")

inf.ts =ts(inf$Adj.Close,start=c(1999,3),frequency = 12)
plot(inf.ts)

inf.arima = auto.arima(inf.ts)
summary(inf.arima)
inf.fore = forecast(inf.arima,h=12)
plot(inf.fore)
