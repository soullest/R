install.packages("class")
library(caret)
library(class)

vacations = read.csv("../data/tema3/vacation-trip-classification.csv")

#Esta version de KNN requiere que las variables dependientes sean numericas y lo que se quiere clasificar sean categoricos
#Este data frame tiene una columna ingresos que tiene 5 digitos y miembros de la familia tiene 1 digito, por lo que hay que normalizarla
vacations$IncomeScale = scale(vacations$Income)
vacations$Family_sizeScale = scale(vacations$Family_size)

#Hacemos las particiones en los datasets de entrenamiento, validacion y verificacion
set.seed(2018)
training.IDs = createDataPartition(vacations$Result,p=0.5,list = F)
train_set = vacations[training.IDs,]
temp = vacations[-training.IDs,]
validation.IDs = createDataPartition(temp$Result,p=0.5,list=F)
validation_set = temp[validation.IDs,]
test_set = temp[-validation.IDs,]


pred1 = knn(train_set[,4:5],validation_set[,4:5],train_set[,3],k=5)
confu1 = table(validation_set$Result,pred1,dnn=c("Actual","Predicho"))
confu1


pred2 = knn(train_set[,4:5],test_set[,4:5],train_set[,3],k=1)
confu2 = table(validation_set$Result,pred2,dnn=c("Actual","Predicho"))
confu2

#Esta funcion lleva a cabo el proceso de KNN con diferentes K
knn.automate <- function(tr_predictiors, val_predictors, tr_target,val_target,start_k,end_k){
  for(k in start_k:end_k){
    pred = knn(tr_predictiors,val_predictors,tr_target,k)
    tab = table(val_target,pred,dnn = c("Actual","Predicho"))
    cat(paste("Matriz de confusion para k=",k,"\n"))
    cat("====================================")
    print(tab)
    cat("----------------------")
  }
}

knn.automate(train_set[,4:5],validation_set[,4:5],train_set[,3],validation_set[,3],1,8)


#Es posible automatizar la funcion que hicimos utilizando la funcion caret
#Primero establecemos las variables de control, decimos que usamos un KfoldCRossValidation con K= 10 y repetido 3 veces
trctrl = trainControl(method = "repeatedcv",number = 10,repeats = 3)
#El metodo train nos permite entrenar varias veces un modelo con diferentes parametros, en este caso decimos que queremos que un knn se entrene con los parametros que pusimos antes
caret_knn_fit = train(Result ~ Family_size +Income, 
                      data= train_set,
                      method="knn", 
                      trControl=trctrl,
                      preProcess = c("center","scale"),
                      tuneLength=10)
carte_knn_fit
