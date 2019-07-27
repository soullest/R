data = read.csv("../data/tema1/housing-with-missing-value.csv", 
                header = TRUE,
                stringsAsFactors = FALSE)
summary(data)

#eliminar donde haya NA
data1 = na.omit(data)
summary(data1)


#Eliminar solo NA de ciertas columnas
drop_na = c("rad")
data2 = data[complete.cases(data[,!names(data)%in%drop_na]),]
summary(data2)


#Eliminar toda una columna

data$rad =NULL
summary(data)

#Eliminar varias columnas
drop_cols = c("rad","ptratio")
data3 = data[,!names(data) %in% drop_cols]
summary(data3)



install.packages("Hmisc")
library(Hmisc)

datos = read.csv("../data/tema1/housing-with-missing-value.csv", 
                 header = TRUE,
                 stringsAsFactors = FALSE)
summary(datos)
datos2 = datos
datos3 = datos
datos4 = datos

datos$ptratio = impute(datos$ptratio,mean)
datos$rad = impute(datos$rad,mean)

summary(datos)
 

datos2$ptratio = impute(datos2$ptratio,median)
datos2$rad = impute(datos2$rad,median)
summary(datos2)


datos3$ptratio = impute(datos3$ptratio,18)
datos3$rad = impute(datos3$rad,7)
summary(datos3)




install.packages("mice")
library(mice)
md.pattern(datos4)


install.packages("VIM")
library(VIM)
#Crear el grafico de cuantos NA faltan
aggr(datos4,
     col=c("green","red"), #Cambiar los colores
     numbers= TRUE, #Mostrar los porcentajes
     sortVars=TRUE, #Ordenar los valores por el que mas NA tiene
     gap=2, #El espacio entre graficos
     ylab=c("Histograma de NA","Patrones"), #Titulos 
     cex.axis=0.6) #Tamaño de letra
