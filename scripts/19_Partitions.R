install.packages("caret")
library(caret)

data = read.csv("../data/tema2/BostonHousing.csv")
training_ids = createDataPartition(data$MEDV,p=0.8, list = FALSE)
data_training = data[training_ids,]
data_validation = data[-training_ids,]


training_ids2 = createDataPartition(data$MEDV,p=0.7, list = FALSE)
data_training2 = data[training_ids2,]
temp = data[-training_ids2,]
training_idsv2 = createDataPartition(temp$MEDV,p=0.5, list = FALSE)
data_validationA=temp[training_idsv2,]
data_validationB=temp[-training_idsv2,]



dataC = read.csv("../data/tema2/boston-housing-classification.csv",
                stringsAsFactors = TRUE)

#Vamos a partir en 2 basado en la columna MEDVCAT que son factores (categoricas)
training_idsC = createDataPartition(dataC$MEDV_CAT,p=0.7,list = FALSE)
data_trainingC = dataC[training_idsC,]
data_validationC = dataC[-training_idsC,]


#Funcion para que nos regrese las particiones
parte = function(dataframe,target.index,prob){
  library(caret)
  training_ids = createDataPartition(dataframe[,target.index],p=prob,list = FALSE)
  list(train = dataframe[training_ids], vali = dataframe[-training_ids])
}

parteEn3 = function(dataframe,target.index,prob.train,prob.val){
  library(caret)
  training_ids = createDataPartition(dataframe[,target.index],p=prob.train,list = FALSE)
  train = dataframe[training_ids,]
  temp = dataframe[-training_ids,]
  validation_ids = createDataPartition(temp[,target.index],p=prob.val,list = FALSE)
  list(traindata=train,val=temp[validation_ids,],test=temp[-validation_ids,])
}

Datos1 = parte(dataC,14,0.8) #Lo parte usando la columna 14 con un trozo de 80% y otro de 20%
Datos2 = parteEn3(dataC,14,0.7,0.3) #Parte en 3, el training del 70% y el restante lo divide en un cacho de 30 y otro de 70

Datos1$train
Datos2$test


head(Datos1$vali)

sample1 = sample(data$CRIM,10,replace = FALSE) # una columna para tomar valores aleatorios, el segundo es el numero de muestras y el replace indica si es con remplazo
sample2 = sample.int(data,10,replace = FALSE)


install.packages("dplyr")
library(dplyr)
sample3=sample_n(data,10,replace = FALSE) #Lo mismo que sample pero para el dataframe completo

data[c(1,3),]
