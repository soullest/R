install.packages("e1071")

library(caret)
library(e1071)

banknote = read.csv("../data/tema3/banknote-authentication.csv")

banknote$class = factor(banknote$class)



set.seed(2018)

#Hacemos la particion al 70%
training.IDs = createDataPartition(banknote$class,p=0.7,list = F)
#Creamos la SVM utilizando una relacion de class con todos
modelo = svm(class ~.,data = banknote[training.IDs,],kernel="radial")

#Verificamos con el mismo conjunto de entrenamiento si es clasificado correctamente
table(banknote[training.IDs,"class"],fitted(modelo),dnn=c("Actual","Predicho"))

#Verificamos si el conjunto de validación es correctamente clasificado
pred = predict(modelo,banknote[-training.IDs,])
#Imprimimos la matriz de confusion
table(banknote[-training.IDs,"class"],pred,dnn=c("Actual","Predicho"))

#Graficamos una variable contra la otra para ver como se ve la proyección del vector de separacion
plot(modelo,data=banknote[training.IDs,],skew~variance )
plot(modelo,data=banknote[-training.IDs,],skew~variance )

#Como es mucho relajo estar ajustando Gamma y C como parametros de la SVM tenemos el metodo tuned que prueba varias 
#Gamas y C, solo le damos el rango que queremos que pruebe
tuned = tune.svm(class~.,data=banknote[training.IDs,],gamma=10^(-6:-1),cost = 10^(1:2))
#Con un summary podemos ver cual de las pruebas resulto mejor
summary(tuned)
plot(tuned)



###################################################################################3
#Con las SVM si la variable a estimar no es categorica, entonces se pueden hacer regresiones
tuned2 = tune.svm(skew~.,data=banknote[training.IDs,1:4],gamma=10^(-6:-1),cost = 10^(4:7),kernel="radial")
summary(tuned2)
modelo_regresion = svm(skew ~.,data = banknote[training.IDs,1:4],kernel="radial",gamma=0.1,cost=10000)
names(banknote)
df= data.frame( variance=0.3292400, curtosis=4.57180000, entropy=-0.988800)
pred2 = predict(modelo_regresion,df )
