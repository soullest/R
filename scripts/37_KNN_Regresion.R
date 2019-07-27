install.packages("dummies")
install.packages("FNN")
install.packages("scales")

library(dummies)
library(FNN)
library(scales)
library(caret)

edu= read.csv("../data/tema4/education.csv")
#La funcion dummy lo que hace es expandir una categoria hacia sus binarios, por ejemplo aui tenemos 4 categorias
#numeradas del 1 al 4, entonces lo que hace es crear 4 columnas y cuando la categoria es 1 pone un 1 en la primer columna 
#y las demas en ceros, cuando la categoria es 4, pone un 1 en la cuarta columna y las demas en ceros
dms = dummy(edu$region,sep="_")
#Al final unimos nuestras 4 nuevas columnas al dataframe original
edu = cbind(edu,dms)

#Como tienen valores muy altos, escalamos los valores entre 0 y 1
edu$urban.s =rescale(edu$urban)
edu$income.s =rescale(edu$income)
edu$under18.s =rescale(edu$under18)

set.seed(2018)

#Creamos las particionaes de trainind, vAlidacion y test
t.IDs = createDataPartition(edu$expense,p=0.6,list=F)
tr = edu[t.IDs,]
temp=edu[-t.IDs,]
v.IDs = createDataPartition(temp$expense,p=0.5,list=F)
val =temp[v.IDs,]
test = temp[-v.IDs,]


#Probamos con diferentes valores de K
regresion1=knn.reg(tr[,7:12],val[7:12],tr$expense,
                   k=1,
                   algorithm = "brute")

#Calculamos el error cuadratico medio
rmse1 = sqrt(mean((regresion1$pred-val$expense)^2))


regresion2=knn.reg(tr[,7:12],val[7:12],tr$expense,
                   k=2,
                   algorithm = "brute")
rmse2 = sqrt(mean((regresion2$pred-val$expense)^2))

regresion3=knn.reg(tr[,7:12],val[7:12],tr$expense,
                   k=3,
                   algorithm = "brute")
rmse3 = sqrt(mean((regresion3$pred-val$expense)^2))

regresion5=knn.reg(tr[,7:12],val[7:12],tr$expense,
                   k=5,
                   algorithm = "brute")
rmse5 = sqrt(mean((regresion5$pred-val$expense)^2))


errors = c(rmse1,rmse2,rmse3,rmse5)
plot(errors,type='o',xlab="k",ylab="RMSE")


reg.test = knn.reg(tr[,7:12],test[,7:12],tr$expense,k=2,algorithm = "brute")
rmse.test = sqrt(mean((reg.test$pred-test$expense)^2))






reg = knn.reg(tr[,7:12],test=NULL,y=tr$expense,k=2,algorithm = "brute")
errorcuadra =  sqrt(mean(reg$residuals^2))

#algunos otros algoritmos de busqueda son algorithm=c("kd_tree","cover_tree", "brute")
#con esto podemos hacer la regresion sobre un vector ue hayamos inventado
df= data.frame(region_1=0, region_2=0, region_3=0, region_4=1, urban.s=0.8671210, income.s=0.76239246, under18.s=0.4646465)
reg_t = knn.reg(tr[,7:13],df,tr$expense,k=2,algorithm = "brute")
reg_t$pred  
