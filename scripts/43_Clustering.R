protein = read.csv("../data/tema5/protein.csv")
data = as.data.frame(scale(protein[,-1]))
data$Country = protein$Country

#Clustering jeraruico aglomerativo
hc =hclust(dist(data,method = "euclidian"),method = "ward.D2")
hc

#Esto nos muestra el dendograma
rownames(data) =data$Country
plot(hc,names = data$Country,hang=-0.01,cex=0.7)#El hang acomoda las hojas en el fondo


hc2 =hclust(dist(data,method = "euclidian"),method = "single")
hc2
plot(hc2,hang=-0.01,cex=0.7)


hc3 =hclust(dist(data,method = "euclidian"),method = "complete")
plot(hc3,hang=-0.01,cex=0.7)

hc4 =hclust(dist(data,method = "euclidian"),method = "average")
plot(hc4,hang=-0.01,cex=0.7)

hc4$merge #Indica con quien se ha juntado quien, los negativos indican el numero de la fila en el dataset y los positivos el numero de union


d=dist(data,method = "euclidian")

alb =data["Albania",-10] #se usa el nombre para accesar porque le cambiamos los nombres con rownames
aus=data["Austria",-10]

sqrt(sum((alb-aus)^2))




d=dist(data,method = "manhattan")

alb =data["Albania",-10] #se usa el nombre para accesar porque le cambiamos los nombres con rownames
aus=data["Austria",-10]

sum(abs(alb-aus))
