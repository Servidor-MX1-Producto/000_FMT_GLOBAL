#================ About ================
# Pasos de ejecución:
#   1.- 
#   2.- 
#   3.- 

#================ Importaciones ===================

log_info("Transfer File — Iniciando proceso")

#Catalogo que nos indica que archivo y la direccion a mover
tryCatch({

  tTransferFile <- read_excel(file.path(rTablas, "TransferFile.xlsx"))
  log_info("Transfer File — {nrow(tTransferFile)} archivo(s) a transferir")

}, error = function(e) {
  
  log_error("Transfer File — Error al leer catalogo TransferFile.xlsx: {conditionMessage(e)}")
  stop(e)
  
})

#================ Ejecucion ===================

#Bucle para recorrer cada archivo a mover
#i <- 1
for (i in 1:nrow(tTransferFile)) {

  tryCatch({

    cOrigen <- tTransferFile$RUTA_ORIGEN[i]
    cDestino <- tTransferFile$RUTA_DESTINO[i]
    cNombreFile <- tTransferFile$ARCHIVO[i]

    #Define Path Origen
    #En caso que la ruta origen sea la unidad de dico de Qlick (B:) NO agregamos los paths iniciales de Usuario y Sharepoint
    if (grepl("(?i)B:", cOrigen, perl = TRUE)) {

      rOrigen <- file.path(paste(cOrigen, "/", cNombreFile, sep = ""))

    }else {

      rOrigen <- file.path(paste(rUser, "/", rSharePoint, "/", cOrigen, "/", cNombreFile, sep = ""))

    }

    #Define Path destino
    #En caso que la ruta destino sea la unidad de dico de Qlick (B:) NO agregamos los paths iniciales de Usuario y Sharepoint
    if (grepl("(?i)B:", cDestino, perl = TRUE)) {

      rDestino <- file.path(paste(cDestino, "/", cNombreFile, sep = ""))

    }else {
      rDestino <- file.path(paste(rUser, "/", rSharePoint, "/", cDestino, "/", cNombreFile,  sep = ""))
    }

    log_info("Transfer File — [{i}/{nrow(tTransferFile)}] Transfiriendo: {cNombreFile}")

    #Antes de copiar el archivo, este se debe eliminar para poder copiarlo en la ruta destino
    if (file.exists(file.path(paste(rDestino,  sep = "")))) {

      #Si el archivo existe lo elimina
      file.remove(file.path(paste(rDestino, sep = "")))

    }

    #Mover archivo
    file.copy(file.path(paste(rOrigen, sep = "")), #Path Origen
              file.path(paste(rDestino, sep = ""))) #Path Destino

  }, error = function(e) {
    
    log_error("Transfer File — [{i}/{nrow(tTransferFile)}] Error al transferir {tTransferFile$ARCHIVO[i]}: {conditionMessage(e)}")
    
  })

}

log_info("Transfer File — Proceso completado")

#Lista de data frames a conservar
vGuarda <- c() #Agregar datos que se guardan en el environment
vMantener <- c(vMantener, vGuarda)
vBorrar <- setdiff(ls(), vMantener)

rm(list = vBorrar)
rm(vBorrar)  