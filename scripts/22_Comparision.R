data =read.csv("../data/tema2/daily-bike-rentals.csv")

data$season =factor(data$season,
                    levels = c(1,2,3,4),
                    labels = c("Invierno","Primavera","Verano","Otoño"))
data$workingday = factor(data$workingday,
                         levels = c(0,1),
                         labels = c("Festivo","Laboral"))
data$weathersit = factor(data$weathersit,
                         levels = c(1,2,3),
                         labels = c("Despejado","Nublado","Lluvioso"))

data$dteday = as.Date(data$dteday,format = "%Y-%m-%d")
attach(data)
par(mfrow=c(2,2))
winter = subset(data,season=="Invierno")$cnt
spring = subset(data,season=="Primavera")$cnt
summer = subset(data,season=="Verano")$cnt
fall = subset(data,season=="Otoño")$cnt





hist(winter,probability = TRUE,
     xlab = "Alquiler diario en invierno")
lines(density(winter))
abline(v=mean(winter),col="red")#Traza una linea vertical en la media, por eso la v
abline(v=median(winter),col="blue")


hist(spring,probability = TRUE,
     xlab = "Alquiler diario en primavera")
lines(density(spring))
abline(v=mean(spring),col="red")
abline(v=median(spring),col="blue")

hist(summer,probability = TRUE,
     xlab = "Alquiler diario en verano")
lines(density(summer))
abline(v=mean(summer),col="red")
abline(v=median(summer),col="blue")

hist(fall,probability = TRUE,
     xlab = "Alquiler diario en otoño")
lines(density(fall))
abline(v=mean(fall),col="red")
abline(v=median(fall),col="blue")

par(mfrow=c(1,1))

#Para el grafico de frijoles o judias
install.packages("beanplot")
library(beanplot)
#Es como la funcion de densidad pero en vertical, marca la media con una linea negra
beanplot(data$cnt ~ data$season,
         col=c("blue","red","yellow")) #El azul es el fondo, el rojo son las lineas de ocurrencia, las amarillas son las que ocurren poco y se salen afuera


#Analisis de causalidad, vemos cuantas bicicletas se alquilan en los climas nublado, lluvioso y despejado
library(lattice)
bwplot(cnt~weathersit, data=data,
       layout=c(1,1),
       xlab="Pronostico del tiempo",
       ylab="Frecuencias",
       panel=function(x,y,...){
         panel.bwplot(x,y,...)
         panel.stripplot(x,y,jitter.data = TRUE,...)
       },
       par.settings = list(box.rectangle=list(fill = c("red","yellow","green"))))
