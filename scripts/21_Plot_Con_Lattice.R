autos = read.csv("../data/tema2/auto-mpg.csv",
                 header = TRUE,
                 stringsAsFactors = TRUE)
autos$cylinders = factor(autos$cylinders,
                         levels = c(3,4,5,6,8),
                         labels=c("3Cilindros","4cilindros","5cilindros","6cilindros","8cilindros"))
attach(autos) #Esto liga el dataframe a la sesion actual de R, haciendo ue podamos acceder directamente a las variables sin usar el simbolo $
install.packages("lattice")

library("lattice")

#Grafico de caja y bigotes
bwplot(~autos$mpg | autos$cylinders,
       main="MPG segun cilindrada",
       xlab = "Millas por galeon")

bwplot(~autos$mpg | autos$cylinders,
       main="MPG segun cilindrada",
       xlab = "Millas por galeon",
       layout=c(3,2),aspect=1)


xyplot(mpg~weight | cylinders, data = autos,
       main="Peso vs Consumo vs Cilindrada",
       xlab="Peso(Kg)",
       ylab="Consumo(MPG)")

trellis.par.set(theme=col.whitebg())
