students_data = read.fwf("../data/tema1/student-fwf.txt",
                         widths = c(4,15,20,15,4),
                         col.names = c("ID","Nombre","Mail","Carrera","Año"))
students_data2 = read.fwf("../data/tema1/student-fwf-header.txt",
                          widths = c(4,15,20,15,4),
                          header = TRUE,sep = "\t",
                          skip = 2)

students_data_NOEmail = read.fwf("../data/tema1/student-fwf.txt",
                         widths = c(4,15,-20,15,4),
                         col.names = c("ID","Nombre","Carrera","Año"))
