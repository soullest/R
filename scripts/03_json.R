dat.1 = fromJSON("../data/tema1/students.json")
dat.2 = fromJSON("../data/tema1/student-courses.json")

url = "http://www.floatrates.com/daily/usd.json"
dat.3= fromJSON(url)

EuroData = dat.3$eur
dat.1$Email
dat.1[c(2,5,8),]
dat.1[,c(2,5)]

autoNH = read.csv("../data/tema1/auto-mpg-noheader.csv",header = FALSE)
jsonEx = toJSON(autoNH)
dat4 = fromJSON(jsonEx)
