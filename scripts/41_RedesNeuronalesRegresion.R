library(nnet)
library(caret)
library(devtools)
bh = read.csv("../data/tema4/BostonHousing.csv")
set.seed(2018)
t.ids=createDataPartition(bh$MEDV,p=0.7,list=F)
summary(bh$MEDV)
modelo = nnet(MEDV/50 ~.,data = bh[t.ids,], #Dividimos la respuesta entre 50 porque los datos de MEDV tiene como maximo 50 y quereos que todo este entre 0 y 1
              size=6, #Numero maximo de nodos intermedios (capa oculta)
              decay=0.1, # decresión 
              maxit=1000, #Numero maximo de iteraciones
              linout=T)  #Si queremos una salida lineal o una logistica

#install_github('fawda123/NeuralNetTools', ref = 'development')
install.packages('NeuralNetTools')
library(NeuralNetTools)
par(mar = numeric(4))
plotnet(modelo)

rmse = sqrt(mean((modelo$fitted.values*50-bh[t.ids,"MEDV"])^2))

pred =predict(modelo,bh[-t.ids,])
rmse2 = sqrt(mean((pred*50-bh[-t.ids,"MEDV"])^2))
garson(modelo) #Importancia de cada variable
lekprofile(modelo) #Analisis de sensibilidad
