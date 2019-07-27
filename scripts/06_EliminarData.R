data = read.csv("../data/tema1/missing-data.csv", na.strings = "")

#dataset sin filas con NA
data_clean = na.omit(data)
is.na(data[4,2])
is.na(data$Income)

#Limpiar Na de solamente la variable income
data_income_clean = data[!is.na(data$Income),]

#Cuales son las filas que contienen NA
complete.cases(data)
data_cleaned2= data[complete.cases(data),]

#Convertir los 0 a NA
data$Income[data$Income == 0] = NA

#Medidas de centralizacion y dispersion
mean(data$Income) #Arroja NA
mean(data$Income,na.rm = TRUE) #Arroja la media sin considerar los NA

sd(data$Income) #Arroja NA
sd(data$Income,na.rm = TRUE)
