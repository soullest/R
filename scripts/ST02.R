#EPOCH 1 de enero de 1970

Sys.Date() #Fecha de hoy
as.Date("1/1/80",format="%m/%d/%y")
aux=as.Date("1/1/1980",format="%m/%d/%Y")

as.numeric(aux)#Cuantos dias han pasado para una fecha en particular desde el epoch

as.Date("Jan 6, 2018",format="%b %d, %Y")
as.Date("Enero 6, 2018",format="%B %d, %Y")

#Que fecha es despues de 1200 dias del epoch
dt = 1200
class(dt) = "Date"
dt
#Que fecha es 1200 dias antes del epoch
dt = -1200
class(dt) = "Date"
dt

#Que fecha es a partir de una fecha en particular
as.Date(1200,origin=as.Date("1986/04/08"))

format(dt,"%Y")
as.numeric(format(dt,"%Y"))
#Mes en string
format(dt,"%b")
format(dt,"%B")
months(dt)
weekdays(dt) #Que dia de la semana era
quarters(dt) #Que cuatrimestre del año era
julian(dt)

dt
#Sumamos o restamos dias a la fecha
dt2=dt+100
dt-100
dt2-dt #Nos da la diferencia de tiempo en dias
as.numeric(dt2-dt)#La diferencia pero numerica

dt<dt2
dt>dt2
dt==dt2

#Podemos generar secuencias de fechas
seq(dt,dt+365,"month") #el 19 de cada mes
seq(dt,dt+365,"day") #Todos los dias de ese año
seq(dt,dt+365,"2 months") #Secuencia bimensual
seq(from=dt, by="4 months", length.out = 6) #Cuenta cada 4 meses 6 veces
seq(from=dt, by="4 months", length.out = 6)[3] #Nos quedamos con el tercer elemento de la secuencia anterior
seq(from=dt, by="3 weeks", length.out = 6)[3]
