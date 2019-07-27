students = read.csv("../data/tema1/data-conversion.csv")
students$Income.scale = rescale(students$Income)

rescale(students$Income,to=c(0,100))

rescale.many =function(dataframe, cols){
  nombres = names(dataframe)
  for(col in cols){
    nombre = paste(nombres[col],"rescaled",sep = "_")
    dataframe[nombre] = rescale(dataframe[,col])
   
  }
  cat(paste("Hemos reescalado", length(cols), " variables"))
  dataframe
}

students = rescale.many(students, c(1,4,5))
