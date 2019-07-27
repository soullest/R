install.packages("ROCR")
library(ROCR)
#En los datos nos dice la probabilidad de exito de cada fila
datos =read.csv("../data/tema3/roc-example-1.csv")
datos2 =read.csv("../data/tema3/roc-example-2.csv")

#0 significa fallo y 1 es exito
predict1 = ROCR::prediction(datos$prob,datos$class)
perf1 = performance(predict1,"tpr","fpr") #TPR true positive rate, FPR false positive rate

#Nos genera nuestra primera curva ROC
plot(perf1)
lines(par()$usr[1:2],par()$usr[3:4]) #Dibujamos la linea diagonal


probs.cut.1 = data.frame(cut= perf1@alpha.values[[1]],
                         fpr=perf1@x.values[[1]],
                         tpr=perf1@y.values[[1]])
head(probs.cut.1)
tail(probs.cut.1)

probs.cut.1[probs.cut.1$tpr>=0.8,]


#Esto es lo mismo, pero lo que hacemos es usar el dataset 2 donde las clases son categoricos byer y non-buyer
pred2 = prediction(datos2$prob,datos2$class,label.ordering = c("non-buyer","buyer"))
perf2 = performance(pred2,"tpr","fpr")
plot(perf2,col="green")
lines(par()$usr[1:2],par()$usr[3:4],col="red") #Dibujamos la linea diagonal
