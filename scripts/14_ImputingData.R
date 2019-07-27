library(mice)
data = read.csv("../data/tema1/housing-with-missing-value.csv",
                header = TRUE,
                stringsAsFactors = FALSE)

columnas_problema =  c("ptratio","rad")

#Ejecutamos los metodos de analisis multivariable para predecir los valores perdidos

imputedData = mice(data[,names(data) %in% columnas_problema],
                   m=5, #Numero de iteraciones
                   maxit = 50, #Maximo numero de iteraciones
                   method = "pmm",  #El metodo ue usaremosPredictive mean matching
                   seed = 2018) #Semilla, pero deberia ser aleatoria

#METHODS de analisis multivariable
#pmm - comparacion predictiva de medias
#logreg - regresion logistica
#polyreg - regresion logistica politomica
#polr - modelo de probabilidades proporcionales

#Obtenemos los valores perdidos por metodos del analisis multivariable
dataC = mice::complete(imputedData)

#Sustituimos en el dataframe original
data$rad = dataC$rad
data$ptratio = dataC$ptratio

#Preguntamos si hay algun NA en nuestro data frame
anyNA(data)

library(Hmisc)
data2 = read.csv("../data/tema1/housing-with-missing-value.csv",
                header = TRUE,
                stringsAsFactors = FALSE)

#Otra forma de hacerlo
imputeArgs = aregImpute(~ptratio + rad,
                        data = data2,
                        n.impute = 15)

imputeArgs$imputed$rad
