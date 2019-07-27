family.salary = c(60,50,70,60,80,90,100,60)
family.size = c(4,3,2,2,3,4,3,4)
family.car = c("lujo","compacto", "compacto","utilitario","lujo","compacto","compacto","lujo")
family = data.frame(family.salary,family.size, family.car)
family.unique = unique(family) #eliminamos duplicados
duplicated(family) #Devuelve un arreglo de boleanos indicando con true donde hay duplicados
family[duplicated(family),]
