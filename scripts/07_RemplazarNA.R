data = read.csv("../data/tema1/missing-data.csv", na.strings = "")
data$Income.mean = ifelse(is.na(data$Income),
                          mean(data$Income,na.rm = TRUE),
                          data$Income)

#x es un vector que puede contener NA
random.input = function(x){
  missing = is.na(x) #contiene true y false dependiendo si hay NA
  n.missing = sum(missing) #El tamaño de los verdaderos, osea de los NA
  x_obs = x[!missing] #Las observaciones sin NA
  imputed = x 
  imputed[missing] = sample(x,n.missing, replace = TRUE) #En las poisicones de los NA ponemos muetsras aleatorias del resto del vector
  return (imputed)
}

randomInputDataFrame = function(dataframe, cols){
  nombres = names(dataframe)
  for(col in cols){
    nombre = paste(nombres[col],"imputed",sep = "_")
    dataframe[nombre] = random.input(dataframe[,col])
  }
  dataframe
}

data$Income[data$Income == 0] = NA
randomInputDataFrame(data, c(1,2))
