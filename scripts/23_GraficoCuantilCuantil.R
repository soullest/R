#Generamos una secuencia de numero de 0.01 en 0.01 comenzando en 0.01 hasta llegar a 0.99
s = seq(0.01,0.99,0.01)

#Nos indica donde esta la normal en la gausiana de los puntos que indicamos, es decir
#En que punto de x esta el percentil 1%, 2% ... 99% que es lo que generamos en la secuencia anterior
qn = qnorm #Aqui esta con los parametros por defecto pero podemos ponerle parametros para ajustar el tamaño de la gausiana
qn
df = data.frame(p=s,q=qn)


#Muestras aleatorias con distribucion normal
sample = rnorm(200)
#Aqui nos indica los puntos en los que estan nuestros percentiles dadas las muestras que le metemos
quantile(sample,probs = s)


#qqnorm
trees #Dataset que viene con R sobre alturas de arboles de cerezo
qqnorm(trees$Height) #Grafico cuantil cuantil de la altura para ver si se distribuye de manera normal

qqnorm(randu$x) #Aqui vemos que la distribucion no es norma, quiza sea uniforme

###########################################

#QQPlot
randu  #Dataset por defecto que tiene puntos aleatorios
n = length(randu$x) #Tamaño del dataset: 400
pointsUni = qunif(ppoints(n)) #PPoints genera n puntos entre 0 y 1 distribuidos uniformemente, Qunif proporciona 400 cuantiles de los puntos

qqplot(pointsUni,randu$x) #Aqui vemos que la distribucion es uniforme

############################################

chi3 = qchisq(ppoints(30),df=3) #Puntos entre 0 y 1 obtenidos con la funcion chi cuadrada f_n(x) = 1 / (2^(n/2) ??(n/2)) x^(n/2-1) e^(-x/2) con 3 grados de libertad
n30 =qnorm(ppoints(30)) #Genera 30 puntos con distribucion normal uniforme
qqplot(n30,chi3) #Ya sabiamos que no saldria uniforme pero es bueno ver la parabola
cauchy = qcauchy(ppoints(30)) #Generamos 30 puntos con la distribucion de cauchy
qqplot(n30,cauchy) #Cuando ploteamos los puntos de cauchy contra la normal vemos que no es uniforme


x=seq(-3,3,0.01)
plot(x,dnorm(x)) #Pintamos la distribucion normal (la curva de gauss)
plot(x,pnorm(x)) #La Pnorm es la probabilidad de que un punto caiga en una densidad, esto nos da una mitad de la curva de gauus
plot(x,dchisq(x,df=3))
plot(x,pchisq(x,df=3))
plot(x,dcauchy(x))
plot(x,pcauchy(x))
