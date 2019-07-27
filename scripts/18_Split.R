data = read.csv("../data/tema2/auto-mpg.csv",
                header = TRUE,
                stringsAsFactors = FALSE)
carlist = split(data,data$cylinders)
carlist[1]  #Este es el apuntador al dataframe de los carros d 3 cilindros
carlist[[1]]  #Este es propiamente el dataframe de los carros de 3 cilindros
