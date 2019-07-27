wmt = read.csv("../data/tema6/WMT.csv",stringsAsFactors = F)

plot(wmt$Adj.Close,type="l")
d=diff(wmt$Adj.Close)
plot(d,type="l")
hist(d,prob=T,ylim=c(0,0.8),breaks = 30,col = "green")
lines(density(d),lwd=3)

wmt.m = read.csv("../data/tema6/WMT-monthly.csv",stringsAsFactors = F)
wmt.m.ts = ts(wmt.m$Adj.Close)
d = diff(as.numeric(wmt.m.ts))
d
wmt.m.return = d/lag(as.numeric(wmt.m.ts),k=-1)
hist(wmt.m.return,prob=T,breaks = 30,col = "blue")
wmt.m.ts
