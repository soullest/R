s= read.csv("../data/tema6/ts-example.csv")
s
s.ts = ts(s) #No toma un origen particular, simplemente 1,2,3...
plot(s.ts)
s.ts.a=ts(s,start = 1910) #Le damos como punto de origen 1910
plot(s.ts.a)
s.ts.m=ts(s,start = c(2000,1),frequency = 12) #Comenzamos en enero del 2000 y decimos que las muestras son 12 al año
plot(s.ts.m)

s.ts.q=ts(s,start = c(2000,1),frequency = 4) #Informacion trimestral
plot(s.ts.q)

start(s.ts.m) #Le preguntamos por su momento de inicio
end(s.ts.m)#En que momento termina
frequency(s.ts.m) #Cada cuanto hay una toma de datos

prices  = read.csv("../data/tema6/prices.csv") #Precio de harina y gasolina blanca desde 1980 mensual
prices.ts = ts(prices,start = c(1980,1),frequency = 12)
plot(prices.ts)
plot(prices.ts,plot.type = "single",col=1:2)
legend("topleft",colnames(prices.ts),col = 1:2,lty = 1)

#Descomposición de la serie por el metodo de Loess
flour.l = log(prices.ts[,1]) #Se usa el logaritmo ara descomponer el multiplicativo en aditivo
flour.stl = stl(flour.l,s.window = "period")
plot(flour.stl)

#Descomposicion clasica
flour.dec = decompose(flour.l)
plot(flour.dec)

#Quitamos la info de la estacion de forma que tengamos la información más clara
flour.season.adjuts = prices.ts[,1]-flour.dec$seasonal
plot(flour.season.adjuts)
