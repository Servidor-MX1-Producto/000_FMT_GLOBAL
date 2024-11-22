#================ About ================
# Pasos de ejecución:
#   1.- 
#   2.- 
#   3.- 

#================ Imortaciones / Paths ===================

#Samba
rSamba <- file.path("\\\\samba.ggv.mx\\samba\\K\\archivos\\DA_piloto")

#================ Ejecucion ===================

#Dias a contemplar para borrar
cDiasElimina <- 1

#Archivos a excluir
cArchivosExcluye <- c("Ciclo_DA.csv", "Dias_DA.csv", "READ_ME.txt")

#Listamos todos los archivos que exiten
q001Archivos <- list.files(rSamba) %>% 
  data.frame() %>% 
  rename(ARCHIVO = 1) %>% 
  filter(!(ARCHIVO %in% cArchivosExcluye)) %>%  #Quitamos archivos que no se deben tocar
  mutate(FECHA_CREACION = as.Date(file.mtime(file.path(rSamba, ARCHIVO)), tz = "America/Mexico_City")) %>% #Fecha de creacion de los archivos
  mutate(ELIMINA = ifelse(FECHA_CREACION < as.Date(today() - days(cDiasElimina)), "SI", "NO")) %>% #Validamos la fecha para defini que si se elimina y que no
  filter(ELIMINA == "SI") #Filtramos los archivos que se eliminan

#ciclo para eliminar los archivos
for (cArchivo in q001Archivos$ARCHIVO) {
  
  unlink(file.path(rSamba, cArchivo))
  
}
   

#Lista de data frames a conservar
vGuarda <- c() #Agregar datos que se guardan en el environment
vMantener <- c(vMantener, vGuarda)
vBorrar <- setdiff(ls(), vMantener)

rm(list = vBorrar)
rm(vBorrar)        