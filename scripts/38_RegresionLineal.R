library(caret)
auto = read.csv("../data/tema4/auto-mpg.csv")
auto$cylinders = factor(auto$cylinders,levels = c(3,4,5,6,8),labels = c("3c","4c","5c","6c","8c"))
set.seed(2018)
t.ids=createDataPartition(auto$mpg,p=0.7,list=F)
names(auto)
mod = lm(mpg ~.,data=auto[t.ids,-c(1,8,9)])
mod

#El modelo nos da la siguiente formula donde los multiplicativos solo se dan si existen
#37.284202 + 6.231475*4c + 8.248195*5c + 2.131026*6c + 4.568171*8c + 0.002245*displacement - 0.057543*horsepower - 0.004665*weight +0.050745*acceleration

summary(mod)

sqrt(mean((mod$fitted.values-auto[t.ids,"mpg"])^2)) #El error cuadratico medio

pred = predict(mod, auto[-t.ids,-c(1,8,9)])
sqrt(mean((pred-auto[-t.ids,"mpg"])^2)) #El error cuadratico medio


#Podemos predecir o hacer la regresion sobre un vector que nosotros definamos
df= data.frame( cylinders="4c",displacement=140,horsepower=90,weight=2264,acceleration=15.5)
pred2 = predict(mod,df )

auto[1,-c(1,8,9)]
df

#Esta es toda una serie de graficas que nos da el modelo
 par(mfrow=c(2,2))
 plot(mod)
 
 #El primer grafico es de los residuales contra los ajustados, este nos muestra como se portan los residuales, si se
 #dibuja algo similar a una recta entonces esta bien, si tenemos una parabola u otra figura es que no podemos usar 
 #regresion lineal, pues siempre debe darnos lineas
 
 #el segundo grafico es un grafico cualtil cuantil, nos habla de si el comportamiento de las variables es 
 #normal uniforme, si lo es entonces estaran cerca de la diagonal media, sino se alejaran de la recta o no tendra
 #forma lineal, en estos casos la distribucion no es normal, uno de los requisitos para usar regresion lineal es que 
 #la distribucion sea normal uniforme
 
 
 #El tercero es el grafico de dispersion o de escala-localizacion, nos dice si la varianza de todos los datos es la misma
 #ya que es una condicion necesaria para aplicar regresion lineal, si lo es entonces veremos los valores muy concentrados
 #en una linea, sino, se veran disperssos
 
 #El cuarto son los residuos contra el apalancamiento, las lineas punteadas representan la distancia de cook, los
 #puntos fuera de estas lienas son outliers que influencian para mal el modelo, entonces podriamos sacarlos y rehacer
 #el modelo (vienen marcados por su numero en el dataset), si los outliers estan dentro todo bien
 
 #Al final si un punto ha salido repetido muchas veces en los graficos conviene analizarlo y quiza quitarlo del dataset
 
 
 
 #En el modelo anterior al imprimirlo vemos que no salen los 3C y eso es porque toma esta columna como pivote
 #asumiendo que la mayoria de los carros son de 3Cilindros, como sabemos ue la mayoria son de 4C, podemos reajustar el 
 #data frame para que tome los 4C como pivote
 auto = within(auto,
               cylinders <- relevel(cylinders,ref="4c"))
 mod2 = lm(mpg ~.,data=auto[t.ids,-c(1,8,9)])
 mod2
 pred = predict(mod2, auto[-t.ids,-c(1,8,9)])
 sqrt(mean((pred-auto[-t.ids,"mpg"])^2)) #El error cuadratico medio
 
 
#Es posible que en lugar de que la relación Y~X sea linea, la hagamos cuadratica o de otra funcion Y~X^2
 
 
 library(MASS)
 step.model = stepAIC(mod2,direction = "backward")
summary(step.model) 
