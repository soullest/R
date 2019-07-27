clientes = c("Juan Gabriel", "Ricardo", "Pedro")
fechas = as.Date(c("2017-12-27","2017-11-1","2018-1-1"))
pago = c(315,192.55,40.15)
pedidos = data.frame(clientes,fechas,pago)
clientesVIP = c("Cabra","Borrego")
save(pedidos,clientesVIP,file="../data/tema1/pedido.Rdata")
saveRDS(pedidos,file="../data/tema1/pedido.rds")
remove(pedidos)

load("../data/tema1/pedido.Rdata")
orders = readRDS("../data/tema1/pedido.rds")




data("iris")
data("cars")


save.image(file="../data/tema1/all_data.Rdata")

primos= c(2,3,5,7,11)
pow2 = c( 2,4,8,16,32)

save(list = c("primos","pow2"),file="../data/tema1/primosYpow2.Rdata")
load("../data/tema1/primosYpow2.Rdata")
attach("../data/tema1/primosYpow2.Rdata")
data()
