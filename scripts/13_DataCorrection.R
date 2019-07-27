install.packages("tidyr")
library(tidyr)

data = read.csv("../data/tema1/USArrests.csv", 
                header = TRUE,
                stringsAsFactors = FALSE)
summary(data)
View(data) # Ver el contenido del dataframe

data = cbind(state = rownames(data),data) #Agregar una columna

#Esto es para hacer diccionarios de datos o arrays asociativos
#Colapsamos varias columnas en una sola (quedan menos columnas pero muchas mas filas)
data1 = gather(data,
               key = "crime_type", value = "arrest_stimated", 
               Murder:UrbanPop)

data2 =gather(data,
              key = "crime_type",
              value = "Arrest_estimate",
              -state)#Esto indica que traducimos todo a clave valor excepto state


data3 =gather(data,
              key = "crime_type",
              value = "Arrest_estimate",
              Murder,Assault)

#Ahora vamos a expandir cuando hay columnas colapsadas

data4 = spread(data2, 
               key = "crime_type",
               value = "Arrest_estimate")


#Esto es para unir columnas pero quedando el mismo numero de filas
data5 = unite(data,
              col = "Murder_Assault",
              Murder,Assault,
              sep = "_")

#Separamos los datos que hemos juntado con unite
data6 = separate(data5,
                 col = "Murder_Assault",
                 into = c("Murder","Assault"),
                 sep = "_")
