install.packages("naivebayes")
library(naivebayes)
library(e1071)
library(caret)

#El naivebayes requiere que todos los datos sean categoricos, en este caso el dataset ya viene categorico pero sino hay que prepararlo asi
ep = read.csv("../data/tema3/electronics-purchase.csv")

set.seed(2018)
trainings.IDs =createDataPartition(ep$Purchase,p=0.67,list = F)

modelo = naiveBayes(Purchase ~.,ep[trainings.IDs,])
modelo

pred = predict(modelo,ep[-trainings.IDs,])
tab=table(ep[-trainings.IDs,]$Purchase,pred,dnn=c("Actual","Predicha"))
confusionMatrix(tab)

