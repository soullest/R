data = read.csv("../data/tema2/auto-mpg.csv",
                header = TRUE,
                stringsAsFactors = FALSE)
#Subconjuntos basado en indices por posicion
data[1:5,8:9]
data[1:5,c(8,9)]

#Subconjunto basado en indices por nombre
data[1:5,c("model_year","car_name")]

#Subconjunto del minimo y el maximo
data[data$mpg == max(data$mpg) | data$mpg == min(data$mpg),]

#Filtros basados en condiciones
data[data$mpg >=30 & data$cylinders == 6,]
data[data$mpg >=30 & data$cyl == 6,] #Aqui solo medio escribimos el nombre

#Uso de la funcion subset
subset(data,mpg>=30 & cylinders==6,select=c("car_name","mpg")) #Select es el nombre de columnas

#Excluir columnas
data[1:5,c(-1,-9)] #Quita las columnas 1 y 9
data[1:5,-c(1,9)] #Lo mismo, no funciona con nombres
data[1:5,!names(data) %in% c("No","car_name")] #Este si funciona con los nombres
data[data$mpg %in% c(15,20),] #Que su mpg
data[1:2,c(F,F,T)]#Aqui repite el patron FFT y nos da la columna 3,6 y 9
