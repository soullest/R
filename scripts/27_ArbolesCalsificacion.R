install.packages(c("rpart","rpart.plot","caret"))
library(rpart)
library(rpart.plot)
library(caret)
banknote = read.csv("../data/tema3/banknote-authentication.csv")


set.seed(2018) #ponem esta semilla para que sea igual que el curso pero obvio esto no va
#Hacemos la particion como lo habiamos hecho antes
trainingsIDs =createDataPartition(banknote$class, p= 0.7,list = FALSE)

#Creamos nuestro arbol de decisiones
modelo = rpart(class ~., #class ~. significa que la variable class depende de todas las columnas, seria equivalente a escribir  class~variance + skew + curtosis + entropy, si quisieramos no incluir alguna columna podemos usar el -
               data=banknote[trainingsIDs,],
               method = "class",  #Indica que es un arbol de clasificacion, tambien pudiera ser un arbol de regresion pero de momento nos centraremos en clasificacion
               control = rpart.control(minsplit = 20, cp= 0.001))  #Indicamos que solo considere nodos con almenos 20 casos en su interior, CP ajusta la complejidad
modelo

#Graficamos nuestro modelo
prp(modelo,
    type=2, #Hace que cada nodo quede etiquetado y que la division quede debajo del nodo, podemos jugar con estas formas
    extra = 104,  #Muestra  la probabilidad de cada nodo con respecto a su nodo padre
    nn=TRUE,  #Se utiliza para ver el numero del nodo, sus hijos se lleman 2N+1 de manera que los hijos del nodo 15 son 30 y 31
    fallen.leaves = TRUE,  #Muestra los nodos hoja siempre hasta el final dle grafico, si lo quitamos los pone donde caigan
    faclen = 4,  #Abrevian los nombres de las clases
    varlen=8,  #Abrevian los nombres de las variables
    shadow.col = "gray")   #Añade un poco de sombra a los nodos

#Para hacer la poda debemos usar la tabla CPtable dentro del modelo, que nos indica los factores de complejidad del arbol
#Esta tabla se forma por CP, nsplit, relerror (error relativo), xerror (error cruzado), xstd (desviacion estandar)
#Debemos buscar la fila minima tal que, la suma de la desviacion estandar de la fila mas el error cruzado minimo
#Es decir, el de la fila mas abajo, nos de un resultado mayor que el error cruzado de esa fila
modelo$cptable
errorMin = modelo$cptable[8,4]
for(i in 1:8){
  errorCalculado = errorMin+modelo$cptable[i,5]
  if(modelo$cptable[i,4]<=errorCalculado){
    resu = sprintf("Fila %s Error %s",i,errorCalculado)
    print(resu)
  }
}

#En este encontramos que 6 es el numero mínimo que buscamos entonces aplicamos la funcion prune para podar y ponemos la fila 6 de la columna CP
modelo.pruned <- prune(modelo,modelo$cptable[6,"CP"])
#Graficamos el arbol y vemos que efectivamente tiene menos nodos
prp(modelo.pruned,
    type=2, 
    extra = 104, 
    nn=TRUE,  
    fallen.leaves = TRUE, 
    faclen = 4,  
    varlen=8,  
    shadow.col = "gray") 


#Verificamos nuestro modelo utilizando la funcion predict y los valores que no usamos para crear el modelo (nuestro conjunto de validacion)
predicho = predict(modelo,banknote[-trainingsIDs,],type = "class")
confu=table(banknote[-trainingsIDs,]$class,predicho,dnn=c("Actual","Predicho")) #Matriz de confusion

#Verificamos el modelo con poda, como vemos queda muy similar
predicho2 = predict(modelo.pruned,banknote[-trainingsIDs,],type = "class")
confu2=table(banknote[-trainingsIDs,]$class,predicho2,dnn=c("Actual","Predicho"))

#Podemos generar los diagramas ROC cambiando class por prob en el predict
predicho3 = predict(modelo.pruned,banknote[-trainingsIDs,],type = "prob")
head(predicho3)
library(ROCR)
pred <- prediction(predicho3[,2],banknote[-trainingsIDs,"class"]) #Usamos el 2 porque es en esa columna estan los exitos
perf <- performance(pred,"tpr","fpr")
plot(perf)
