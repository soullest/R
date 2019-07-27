data = read.csv("../data/tema2/auto-mpg.csv",
                header=TRUE,
                stringsAsFactors = FALSE)
data$cylinders = factor(data$cylinders,
                        levels = c(3,4,5,6,7,8),
                        labels = c("c3","c4","c5","c6","c7","c8"))
summary(data)
str(data)
summary(data$cylinders)
summary(data$mpg)
str(data$cylinders)



install.packages("modeest") #Tambien raster pero lo tuve que hacer desde el panel lateral
install.packages("moments")

#Esto nos permite actualizar nuestras librerias que no se podian usar en esta version
install.packages("BiocManager") 
library("BiocManager")
BiocManager::install("genefilter")
BiocManager::install("digest")

library(modeest)#Para la moda
library(raster) #Quartiles y coeficiente de variacion
library(moments) #Asimetria curtosis

###########MEDIDAS DE CENTRALIZACION (QUE TAN CENTRADOS ESTAN LOS DATOS)###############
X= data$mpg
mean(X)
sum(X)/length(X) #misma media

median(X)

mfv(X) #Moda o most frequence value

quantile(X) #Los 4 cuantiles



############ MEDIDAS DE DISPERCION (QUE TAN DISPERSOS ESTAN LOS DATOS)
var(X) # Varianza
sd(X) #Desviacion estandar
cv(X) #Coeficiente de variacion que es la desviacion entre la media



##### MEDIDAS DE ASIMETRIA / MOMENTOS DE ORDEN r

skewness(X) #Momento de fisher
kurtosis(X) #Curtosis

hist(X)
