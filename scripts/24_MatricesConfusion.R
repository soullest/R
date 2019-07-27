data = read.csv("../data/tema3/college-perf.csv")
data$Perf = ordered(data$Perf,
                    levels=c("Low","Medium","High")) #Esto no lo ordena si no que le indica al data frame que Low es mas bajo que Medium, y que asu vez es mas bajo ue High
data$Pred = ordered(data$Pred,
                    levels=c("Low","Medium","High"))

tablaVal = table(data$Perf,data$Pred,dnn = c("Actual","Predicho"))  #Hace una tabla de valores reales contra valores predichos
tablaVal
tablaPro = prop.table(tablaVal) #Misma tabla, pero en lugar de ocurrencias nos da probabilidades

tablaround=round(prop.table(tablaVal,1)*100,2) #Hace un redondeo de las probabilidades

barplot(tablaVal) #Grafico de barras de una tabla

mosaicplot(tablaVal,"Eficiencia del modelo") #Diagrama de mosaico

summary(tablaVal)

library(caret)
cf = confusionMatrix(data$Pred,data$Perf)  #Esto ya nos da lo mismo que tablaVal y tiene sensibilidad acertividad y otras cosas
plot (cf$table) #Genera el mismo plot que mosaicPlot
qplot(data$Perf,data$Pred)

#################################################################
### SE PUEDE HACER LO MISMO CON EL OBJETO CONFUSION 

install.packages("mlearning")
library(mlearning);

confu = confusion(data$Pred,data$Perf)
confusionImage(confu)   #Esta es más la matriz de confusion que se maneja
confusionBarplot(confu) #Matriz de confusion con grafico de barras horizontal
confusionDendrogram(confu)
confusionStars(confu) #Grafico basado en circulos de la matriz de confusion





##########################################
###EL GRAFICO DE CONFUSION MATRIX PERO MAS BONITO
install.packages("ggplot2")
confus = data.frame(tablaPro)
library(ggplot2)
ggplot(data = confus, aes(x=Actual, y=Predicho, fill=Freq)) + 
  geom_tile()
