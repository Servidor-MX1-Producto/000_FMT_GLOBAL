#================ About ================
# Pasos de ejecución:
#   1.- 
#   2.- 
#   3.- 


#================ Ejecucion ===================

#Registro en bitacora
log_info("Borrado Samba — Iniciando proceso")

#Dias a contemplar para borrar archivos validos (fecha en nombre)
cDiasElimina <- 1
log_info("Borrado Samba — Archivos validos con mas de {cDiasElimina} dia(s) seran eliminados")

#Dias a contemplar para borrar archivos invalidos (fecha de creacion del sistema)
cDiasEliminaInvalidos <- 5
log_info("Borrado Samba — Archivos invalidos con mas de {cDiasEliminaInvalidos} dia(s) seran eliminados")

#Archivos a excluir
cArchivosExcluye <- c("Ciclo_DA.csv", "Dias_DA.csv", "READ_ME.txt")
log_info("Borrado Samba — Archivos excluidos del borrado: {paste(cArchivosExcluye, collapse = ', ')}")

#Rutas completas de todos los archivos en la carpeta
vRutasArchivos <- file.path(rSamba, list.files(rSamba))

#Clasificamos archivos (excluidos, validos e invalidos)
q001Archivos <- data.frame(
    RUTA    = vRutasArchivos,
    ARCHIVO = basename(vRutasArchivos)
  ) %>%
  filter(!(ARCHIVO %in% cArchivosExcluye)) %>%
  mutate(
    ES_CSV       = grepl("\\.csv$", ARCHIVO, ignore.case = TRUE),
    FECHA_NOMBRE = as.Date(substr(ARCHIVO, nchar(ARCHIVO) - 13, nchar(ARCHIVO) - 4), format = "%d-%m-%Y"),
    ES_VALIDO    = ES_CSV & !is.na(FECHA_NOMBRE)
  )

#Archivos validos: CSV con fecha valida en el nombre -> regla por fecha de nombre
q001Validos <- q001Archivos %>%
  filter(ES_VALIDO) %>%
  filter(FECHA_NOMBRE < as.Date(today() - days(cDiasElimina)))

#Archivos invalidos: no CSV o sin fecha valida en nombre -> regla por fecha de creacion del sistema
q001Invalidos <- q001Archivos %>%
  filter(!ES_VALIDO) %>%
  mutate(FECHA_SISTEMA = as.Date(file.info(RUTA)$ctime)) %>%
  filter(FECHA_SISTEMA < as.Date(today() - days(cDiasEliminaInvalidos)))

log_info("Borrado Samba — {nrow(q001Validos)} archivo(s) valido(s) y {nrow(q001Invalidos)} archivo(s) invalido(s) seran eliminados")

#Eliminacion vectorizada
unlink(c(q001Validos$RUTA, q001Invalidos$RUTA))

log_info("Borrado Samba — Eliminacion completada")
   

#Lista de data frames a conservar
vGuarda <- c() #Agregar datos que se guardan en el environment
vMantener <- c(vMantener, vGuarda)
vBorrar <- setdiff(ls(), vMantener)

rm(list = vBorrar)
rm(vBorrar)        
