housing = read.csv("../data/tema1/BostonHousing.csv")

housing.z = scale(housing)
housing.z = scale(housing,center = TRUE,scale = TRUE ) #Hace exacto lo mismo
housing.z = scale(housing,center = FALSE,scale = FALSE ) #No hace nada porque no resta la media ni divide entre la desviacion estandar


scale.many =function(dataframe, cols){
  nombres = names(dataframe)
  for(col in cols){
    nombre = paste(nombres[col],"z",sep = "_")
    dataframe[nombre] = scale(dataframe[,col])
    
  }
  cat(paste("Hemos Normalizado", length(cols), " variables"))
  dataframe
}

housing_escalado = scale.many(housing,c(1,2,3:7))
