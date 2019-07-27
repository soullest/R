auto = read.csv("../data/tema1/auto-mpg.csv", 
                header = TRUE, 
                sep = ",",
                strings.na="",
                stringsAsFactors = FALSE)
names(auto)
autoNH = read.csv("../data/tema1/auto-mpg-noheader.csv",header = FALSE)
head(autoNH,4)
autoCH = read.csv("../data/tema1/auto-mpg-noheader.csv",
                  header = FALSE, 
                  col.names = c("numero",
                                "Millas_por_galeon",
                                "Cilindrada",
                                "Desplazamiento",
                                "Caballos de fuerza", 
                                "Peso", 
                                "Aceleracion", 
                                "Año", 
                                "Modelo")
                  )
head(autoCH,4)

autoNET = read.csv("https://frogames.es/course-contents/r/intro/tema1/WHO.csv")
