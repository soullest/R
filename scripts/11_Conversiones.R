students = read.csv("../data/tema1/data-conversion.csv")
bp=c(-Inf,10000,30000,Inf)
nombres = c("bajos","medios","altos")
students$Income.cat=cut(students$Income,breaks = bp,labels=nombres)
students$Income.cat2=cut(students$Income,breaks = bp)
students$Income.cat3=cut(students$Income,breaks = 4,labels=c("nivel1",
                                                             "nivel2",
                                                             "nivel3",
                                                             "nivel4"))

#dummy variables
students = read.csv("../data/tema1/data-conversion.csv")
install.packages("dummies")
library(dummies)
students.dummy = dummy.data.frame(students,sep=".")
names(students.dummy)
students.dummy2 = dummy.data.frame(students,sep=".",all=FALSE)
dummy(students$State,sep = ".")
dummy.data.frame(students,names=c("State","Gender"),sep=".")

out = data.matrix(students)
