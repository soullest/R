install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)
library(caret)

bh = read.csv("../data/tema4/BostonHousing.csv")
t.ids = createDataPartition(bh$MEDV,p=0.7,list = F)
bfit = rpart(MEDV ~.,data=bh[t.ids,])
bfit
#Dibujamos el arbol que hemos obtenido
par(mfrow=c(1,1))
prp(bfit,
    type=2, #Cantidad de informacion y donde debe estar colocada, hay opciones del 0 al 5, el 2 indica imprimir los label de cada nodo
    nn=T, #Poner el numero de nodos
    fallen.leaves = T, #Poner las hojas hasta abajo
    faclen = 4,  #Longitud de los nombres de los factores
    varlen = 8,  #Longitud de los nombres de las variables
    shadow.col = "gray")  #Sombra gris en cada nodo

#La columna CP se refiere al factor de complejidad del arbol, nsplit es el numero de divisiones necesarias para llegar a ese factor de complejidad
#relerror  es el error relativo, xerror error en validacion cruzada, xstd deviacion standar en la validacion cruzada del mejor arbol
bfit$cptable

#Igual que con los arboles de clasificacion, buscamos el CP minimo que cumpla que el xerror minimo mas el xstd de la
#fila, no sobrepase el xerror de la fila
errorMin = bfit$cptable[nrow(bfit$cptable),4]   #Con nrow podemos acceder al numero de filas
for(i in 1:nrow(bfit$cptable)){
  errorCalculado = errorMin+bfit$cptable[i,5]
  if(bfit$cptable[i,4]<=errorCalculado){
    resu = sprintf("Fila %s Error %s",i,errorCalculado)
    print(resu)
    break
  }
}

#Podemos graficar el CP del modelo y usando la tecnica dle codo hacer lo mismo que con nuestro ciclo for
plotcp(bfit)

#Tanto al graficarlo como con nuestro ciclo for vimos que el mejor es el 5 asi que cortamos en el 5to elemento
bfit.pruned <- prune(bfit,bfit$cptable[5,"CP"])
#Al graficarlo vemos que es mucho menos complejo
prp(bfit.pruned,
    type=2, #Cantidad de informacion y donde debe estar colocada, hay opciones del 0 al 5, el 2 indica imprimir los label de cada nodo
    nn=T, #Poner el numero de nodos
    fallen.leaves = T, #Poner las hojas hasta abajo
    faclen = 4,  #Longitud de los nombres de los factores
    varlen = 8,  #Longitud de los nombres de las variables
    shadow.col = "gray")  #Sombra gris en cada nodo

pred = predict(bfit.pruned,bh[-t.ids,]) #Hacemos las predicciones utilizando el error cuadratico medio
rmse = sqrt(mean((pred-bh[-t.ids,"MEDV"])^2)) #Calculamos el error cuadratico medio



###########################################################################################################
#Haciendo regresion usando variables categoricas como predictores (es igual pero se usan variables categoricas)

ed = read.csv("../data/tema4/education.csv")
ed$region = factor(ed$region)
t.IDs= createDataPartition(ed$expense,p=0.7,list=F)
fit=rpart(expense ~ region+urban+income+under18,data = ed[t.IDs,])
prp(fit,type=2,nn=T,fallen.leaves = T,faclen = 4,varlen = 4,shadow.col = "gray")

########################################################################################################
# Bagging
install.packages("ipred")
library(ipred)
bagging.fit =bagging(MEDV ~.,data = bh[t.ids,])
pred.t =predict(bagging.fit,bh[t.ids,])
rmse.t = sqrt(mean((pred.t-bh[t.ids,"MEDV"])^2))
pred.v =predict(bagging.fit,bh[-t.ids,])
rmse.v = sqrt(mean((pred.v-bh[-t.ids,"MEDV"])^2))
###########################################################################################################
#Bootsting
install.packages("gbm")
library(gbm)
gbmfit = gbm(MEDV ~.,data=bh,distribution = "gaussian")
pred.gbm = predict(gbmfit,bh,n.trees = 32)
rmse.gbm = sqrt(mean((pred.gbm-bh$MEDV)^2))
