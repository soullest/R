autos = read.csv("../data/tema2/auto-mpg.csv",
                header = TRUE,
                stringsAsFactors = FALSE)
autos$cylinders = factor(autos$cylinders,
                         levels = c(3,4,5,6,8),
                         labels=c("3Cilindros","4cilindros","5cilindros","6cilindros","8cilindros"))
attach(autos) #Esto liga el dataframe a la sesion actual de R, haciendo ue podamos acceder directamente a las variables sin usar el simbolo $
head(cylinders)


hist(acceleration,
     col="blue",
     xlab = "Aceleración",
     ylab = "Frecuencias",
     main = "Histograma de las aceleraciones",
     breaks = 16) #Histograma, breaks es el numero de divisiones

#Este lo hacemos de colores
hist(acceleration,
     col=rainbow(12),
     xlab = "Aceleración",
     ylab = "Frecuencias",
     main = "Histograma de las aceleraciones",
     breaks = 12) #Histograma, breaks es el numero de divisiones


hist(mpg,probability = TRUE) #Normaliza el histograma a una probabilidad entre 0 y 1
lines(density(mpg)) #Encimamos la funcion de densidad, pintandola encima dle historama

#Diagrama de caja y bogotes
boxplot(mpg,
        xlab="Millas por galeon")

boxplot(mpg ~ model_year, xlab="Millas por galeon por año") #La tilde significa en función de, en este caso son las millas por galon pero divididas para los carros de cada año

boxplot(mpg ~ cylinders, xlab="Consumo por numero de cilindros")


boxplot(autos)


#Scaterplot
#El grafico clasico de una variable respecto a otra
plot(mpg ~ horsepower)
#Agregar colores para las diferentes cilindradas
plot(mpg ~ horsepower,type="n") #El tipe = n significa que no pinte nada
with(subset(autos,cylinders=="8cilindros"),
     points(horsepower,mpg,col="red"))
with(subset(autos,cylinders=="6cilindros"),
     points(horsepower,mpg,col="yellow"))
with(subset(autos,cylinders=="5cilindros"),
     points(horsepower,mpg,col="green"))
with(subset(autos,cylinders=="4cilindros"),
     points(horsepower,mpg,col="blue"))
with(subset(autos,cylinders=="3cilindros"),
     points(horsepower,mpg))

#Matriz de scaterplot (como el scaterplot pero comparamos cada vez con otra variable)
#Para ver relacion entre diferentes variables
pairs(~mpg+displacement+horsepower+weight)


#Combinacion de plots
old_par=par()
par(mfrow=c(1,2))
with(autos,{
  plot(mpg~weight,main="Peso vs Consumo")
  plot(mpg ~ acceleration, main="Aceleracion vs consumo")
})
par(mfrow=c(1,1))
