library(randomForest)
library(caret)
bh = read.csv("../data/tema4/BostonHousing.csv")
set.seed(2018)

t.ids=createDataPartition(bh$MEDV,p=0.7,list=F)
modelo = randomForest(x=bh[t.ids,1:13],y=bh[t.ids,14],
                      ntree = 1000,
                      xtest=bh[-t.ids,1:13],ytest=bh[-t.ids,14],
                      importance = T, #Se refiere a si tiene que computar las puntuaciones de cada variable predictora
                      keep.forest = T) #Si debe quedarse con los arboles que resulten del modelo (si se haran predicciones va en true)
modelo
modelo$importance
sqrt(mean(modelo$mse)) #Mejora mucho el error cuadratico medio

plot(bh[t.ids,]$MEDV,predict(modelo,newdata = bh[t.ids,]),
     xlabel="Actual",ylabel="Predicho")
abline(0,1) #Pasa por 0 y tiene pendiente 1
plot(bh[-t.ids,]$MEDV,predict(modelo,newdata = bh[-t.ids,]),
     xlabel="Actual",ylabel="Predicho")
abline(0,1) #Pasa por 0 y tiene pendiente 1

#mtry = m/3  con m como el numero de variables, se refiere a cuantas variables se toman en consideracion para cada decision
#nodesize: Tamaño de la muestra que debe caer en un nodo para considerarse como tal, por defecto 5
#maxnodes: Maximo numero de nodos terminales de cada arbol, si no se especifica entonces crece todo lo posible
