#Todo esto es necesario para comenzar a analizar twitter
install.packages(c("twitteR","RColorBrewer","plyr","ggplot2","devtools","httr"))
require(devtools)
install_url("https://cran.r-project.org/src/contrib/Archive/Rstem//Rstem_0.4-1.tar.gz")
install_url("https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz")
install_url("https://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")
library(twitteR)
library(slam)
library(sentiment)


#Esto es la configuracion, si le ponemos 1 se creara un archivo local con nuestra configuracion para que ya no hagamos
#esto una y otra vez
api_key = "adDjMEEoBUm9jfAdQieJUxxzR"
api_secret = "iSoI64WiVrnfRZ8p5gBbCFN6cfBvNffPHiyAfv4YBHlbH34fRE"
access_token = "329400249-wLoPPEvw6SRYhXZiNqvj6t64swkVvcDZjIgAh3VD"
access_token_secret = "cMTgKHYo55mO6MwOWHHBmOVuVjhmJLnw7uSKfKZ5zFfPf"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
#Descargamos 1500 twitters en ingles sobre el tema machine learning
tweets = searchTwitter("machinelearning",n=1500,lang = "en")
#Como es mucha informacion lo transformamos a texto plano
texts =sapply(tweets, function(x) x$getText())
head(texts)

#Funcion que nos servira para eliminar toda la informacion innecesaria
clean.data = function(text){
  #Eliminar re-tweets y @ del texto original  gsub es una substring
  text = gsub("(RT|VIA)((?:\\b\\W*@\\w+)+)","",text)
  #Eliminar la @de nuestra sintaxis
  text = gsub("@\\w+","",text)
  #Eliminar signos de puntuacion y digitos del 0 al 9
  text = gsub("[[:punct:]]","",text)
  text = gsub("[[:digit:]]","",text)
  #Eliminar links html, tabulaciones y espacios adicionales
  text = gsub("http\\w+","",text)
  text = gsub("[\t]{2,}","",text)
  text = gsub("^\\s+|\\s+$","",text)
  
}
texts = clean.data(texts)
head(texts)

#Funcion para eliminar todos los errores de textos
handle.error = function(x){
  #crear el valor omitido
  y=NA
  #Cachamos los errores
  try_error = tryCatch(tolower(x),error=function(e) e)
  #si no hay error
  if(!inherits(try_error,"error"))
    y = tolower(x)
  return(y)
}

texts =sapply(texts,handle.error)
head(texts)
#Eliminamos todos los NA
texts = texts[!is.na(texts)]
head(texts)
names(texts) = NULL


#Analisis de sentimientos
class_emo = classify_emotion(texts,algorithm = "bayes",prior=1)
head(class_emo)
emotion = class_emo[,7]   #Nos quedamos solo con la clasificacion de emociones
emotion[is.na(emotion)]="Desconocido"  #Si es un NA lo clasificamos como desconocido


#Analisis de la polaridad (positivo, negativo, neutral)
class_pol = classify_polarity(texts,algorithm = "bayes")
polarity= class_pol[,4]  #Nos quedamos solo con la clasificacion de polaridades


senti_df = data.frame(texts=texts,emotion=emotion,polarity=polarity,stringsAsFactors = F)
senti_df = within(senti_df,emotion <- factor(emotion,levels = names(sort(table(emotion),decreasing = T))))

library(RColorBrewer)
install.packages("plyr")
library(ggplot2)

#Graficamos cuantas emociones son representadas respecto al numero de tweets
ggplot(senti_df,aes(x=emotion))+   #Usaremos el set de emociones
  geom_bar(aes(y=..count..,fill=emotion))+
  scale_fill_brewer(palette = "Set2")+   #Es la paleta de colores que usaremos
  labs(x="Categorias de emocion","y=Numero de tweets")+
  labs(title = "Analisis de sentimientos acerca de machine learning")

#Grafico de como se polarizan los sentimientos
ggplot(senti_df,aes(x=polarity))+
  geom_bar(aes(y=..count..,fill=polarity))+
  scale_fill_brewer(palette = "Set3")+
  labs(x="Categorias de polaridad","y=Numero de tweets")+
  labs(title = "Analisis de polaridad acerca de machine learning")
