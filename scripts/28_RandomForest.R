install.packages("randomForest")
library(randomForest)
library(caret)
banknote = read.csv("../data/tema3/banknote-authentication.csv")
banknote$class = factor(banknote$class)
set.seed(2018)

#Generamos un conjunto de entrenamiento
training.IDs <- createDataPartition(banknote$class,p=0.7,list = F)

#Generamos el random forest
modelo = randomForest(x=banknote[training.IDs,1:4], #Todas las variables excepto el indicador de la clase
                     y=banknote[training.IDs,5], #La columna indicativa de la clase de pertenencia
                     ntree = 500, #Numero de arboles, por defecto 500
                     keep.forest = TRUE) #Si queremos mantener los arboles intermedios, en la vida real siempre es false

#Verificamos nuestro modelo prediciendo el conjunto de verificacion
pred = predict(modelo,banknote[-training.IDs,])
#Matriz de confusion
table(banknote[-training.IDs,"class"],pred,dnn=c("Actual","Predicho"))


#Hacemo la curva ROC
library(ROCR)
probs = predict(modelo,banknote[-training.IDs,],type="prob")
pred2 = prediction(probs[,2],banknote[-training.IDs,"class"]) #Usamos el 2 porque es en esa columna estan los exitos
perf = performance(pred2,"tpr","fpr")
plot(perf)