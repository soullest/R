data = read.csv("../data/tema1/ozone.csv",
                stringsAsFactors = FALSE)

boxplot(data$pressure_height,
        main="Pressure Height", #Titulo
        boxwex=0.5)  #Ancho de la caja

boxplot(pressure_height ~ Month, # ~ indica en relacion a, en este caso es la presion en relacion al mes
        data=data, #Indicamos el data frame
        main="Pressure Height per month") #Titulo

boxplot(ozone_reading ~ Month, # ~ indica en relacion a, en este caso es la presion en relacion al mes
        data=data, #Indicamos el data frame
        main="Ozone per month")$out #El out nos permite obtener los outliers numericos

mtext("Wea fome") #Ponemos texto en el grafico


#Esta funcion sustituye los outliers superiores e inferiores por la media y mediana
impute_outliers = function(x, removeNA=TRUE){
  quantiles = quantile(x, c(0.05,0.95), na.rm = removeNA) #Calculamos los uantiles debajo del 5% y arriba del 95%
  x[x<quantiles[1]] = mean(x,na.rm = removeNA) #A todas las filas debajo del 5% les asignamos la media
  x[x>quantiles[2]] = median(x,na.rm = removeNA) #A todas las filas superiores al 95% les asignamos la mediana
  x
}

imputed_data = impute_outliers(data$pressure_height)

par(mfrow=c(1,2)) #Cuando queremos poner dos Plots, uno al lado del otro

boxplot(data$pressure_height,main="Pressure Height")
boxplot(imputed_data,main="Pressure sin outliers")


#Remplaza los outliers por los valores del 5% y el 95%

replace_outliers = function(x, removeNA=TRUE){
  qrts = quantile(x,probs = c(0.25,0.75),na.rm = removeNA) #Aqui indicamos probs pero puede solo ponerse los valores como en la funcion de arriba ya ue probs siempre es el segundo valor
  caps = quantile(x,probs = c(0.05,0.95),na.rm = removeNA)
  rangoInterquartilico =qrts[2]-qrts[1]
  altura = rangoInterquartilico*1.5
  x[x<qrts[1]-altura] = caps[1]
  x[x>qrts[2]+altura] = caps[2]
  x
}


caped_data = replace_outliers(data$pressure_height)

boxplot(data$pressure_height,main="Pressure Height")
boxplot(caped_data,main="Pressure sin outliers")