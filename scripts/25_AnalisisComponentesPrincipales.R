datos = read.csv("../data/tema3/USArrests.csv",
                 stringsAsFactors = FALSE)
#Como una columna ya es los nombres de cada estado, la usamos como ID de las filas
rownames(datos) = datos$X
datos$X = NULL

#Buscaremos la varianza de cada columna
apply(datos,2,var)  #Apply nos permite aplicar un metodo por columnas si le ponemos 2 o por filas si le ponemos 1

#Con esta funcion normalizamos cada columna para evitar que unos datos sean muy grandes y otros muy pequeños
acp = prcomp(datos,
             center = TRUE,
             scale. = TRUE)
#Al imprimir la variable acp vemos que nos da como resultado 4 PC, si hacemos el plot de acp vemos que dibuja una curva
#Debemos quedarnos con los primeros PC antes del punto de inflexion de la curva
acp
plot(acp,type="l")
#Al hacer un summary uno de los datos es la proporcion acumulativa, lo que nos dice es el porcentaje de variables
#que podemos representar con esa transformacion, por ejemplo con PC1 podemos representar el 62% y con PC4 el 100%
#Pero con PC1 solo usamos una columnas y con PC4 usamos las 4
summary(acp)
#Esto nos muestra una gráfica que indica como se mueven las variables respecto a las operaciones PC1 y PC2
biplot(acp,scale=0)


pc1 =apply(acp$rotation[,1]*datos,1,sum) #Aplicamos la operacion sum, que suma el valor de la fila mas la multiplicacion del PC1 por la fila, a todas las filas, por eso el 1, 
pc2 =apply(acp$rotation[,2]*datos,1,sum)
pc3 =apply(acp$rotation[,3]*datos,1,sum)
pc4 =apply(acp$rotation[,4]*datos,1,sum)

#Con esto agregamos dos columnas para el primer y segundo analisis de componentecon lo que podemos representar el 85%
#de los casos, asi que eliminamos el resto de las columnas y solo nos quedamos con nuestras nuevas 2 columnas
datos$pc1 =pc1
datos$pc2 = pc2
datos[,1:4]=NULL
