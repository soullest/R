library(caret)
#Las variables de salida deben ser 0 o 1
bh <- read.csv("../data/tema3/boston-housing-logistic.csv")
bh$CLASS <- factor(bh$CLASS)

set.seed(2018)
trainings.IDs = createDataPartition(bh$CLASS,
                                    p=0.7,
                                    list = F)


modelo = glm(CLASS~.,
             data=bh[trainings.IDs,],
             family = binomial)
summary(modelo)

pred = predict(modelo,newdata = bh[-trainings.IDs,],type="response")
predi = ifelse(pred > 0.5,1,0)

confu = table(bh[-trainings.IDs,"CLASS"],predi,dnn=c("Actual","Predicho"))
confu
