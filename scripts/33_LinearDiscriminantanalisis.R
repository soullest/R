install.packages("MASS")
library(MASS)
library(caret)

banknote = read.csv("../data/tema3/banknote-authentication.csv")

banknote$class = factor(banknote$class)

set.seed(2018)
trainings.IDs = createDataPartition(banknote$class,p=0.7,list=F)

modelo = lda(banknote[trainings.IDs,1:4],banknote[trainings.IDs,5])
#Hay que fijarse ue aqui para la prediccion necesita de todas las variables dependientes
pred1 = predict(modelo,banknote[-trainings.IDs,1:4])$class
confu1= table(banknote[-trainings.IDs,"class"],pred1)
confu1
