install.packages("nnet")
library(nnet)
library(caret)
#Las clases deben venir como 0 y 1
bn = read.csv("../data/tema3/banknote-authentication.csv")
bn$class = factor(bn$class)

training.IDs = caret::createDataPartition(bn$class,p=0.7,list = F)
#Es bueno antes de hacer el modelo escalar las columnas
modelo = nnet(class ~.,
              data=bn[training.IDs,],
              size=3,        #Numero de elementos en la capa oculta
              maxit=10000,   #Iteraciones maximas pero parara si converge antes
              decay=0.001,   #El tamaño del salto en cada iteracion
              na.action = na.omit, #Omite los NA
              rang=0.05)     #Pesos iniciales


pred1 = predict(modelo,newdata = bn[-training.IDs,],type="class")
confu1 = table(bn[-training.IDs,]$class,pred1,dnn = c("Actual","Predicho"))
confu1

#Hacemos la curva ROC, que sale perfecta debido a que nuestra red clasifica todos los casos
library(ROCR)
pred2 = predict(modelo,newdata = bn[-training.IDs,],type="raw")
perf = performance(prediction(pred2,bn[-training.IDs,"class"]),"tpr","fpr")
plot(perf)






########################################################################33
#### En este ejemplo lo hice con multi clases, como vemos basta con que las clases sean factores
origdf <- read.table("../data/tema3/IrisData.txt", header=TRUE, sep=",")

sampidx <- createDataPartition(origdf$Species,p=0.7,list = F)

mynn <- nnet(Species ~., data=origdf, subset = sampidx, size=2, decay=1.0e-5, maxit=50)
cm <- table(origdf$Species[-sampidx], predict(mynn, origdf[-sampidx, ], type="class"))
print(cm)

