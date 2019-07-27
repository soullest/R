AMZN = read.csv("../data/tema100/AMZN.csv",stringsAsFactors = F)
FB = read.csv("../data/tema100/FB.csv",stringsAsFactors = F)
AAPL = read.csv("../data/tema100/AAPL.csv",stringsAsFactors = F)
GOOG = read.csv("../data/tema100/GOOG.csv",stringsAsFactors = F)

str(AAPL)
#Hacemos el casting a fechas
AAPL$Date = as.Date(AAPL$Date)
AMZN$Date = as.Date(AMZN$Date)
FB$Date = as.Date(FB$Date)
GOOG$Date = as.Date(GOOG$Date)

library(ggplot2)
install.packages("digest")
ggplot(AAPL,aes(Date,Close))+
  geom_line(aes(color="Apple"))+
  geom_line(data=AMZN,aes(color="Amazon"))+
  geom_line(data=FB,aes(color="Facebook"))+
  geom_line(data=GOOG,aes(color="Google"))+
  labs(color="Legend")+
  scale_color_manual("",breaks=c("Apple","Amazon","Facebook","Google"),values=c("gray","yellow","blue","red") )+
  ggtitle("Comparaciones de cierres de stocks")+
  theme(plot.title = element_text(lineheight = 0.7,face = "bold"))

install.packages("quantmod")
library(quantmod)

getSymbols("NFLX")
barChart(NFLX)
chartSeries(NFLX,TA="NULL")
chartSeries(NFLX[,4],TA="addMACD()")
