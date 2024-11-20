#================ About ================
# Pasos de ejecución:
#   1.- 
#   2.- 
#   3.- 

#================ Imortaciones ===================

#Catalogo que nos indica que archivo y la direccion a mover
tTransferFile <- read_excel(file.path(rTablas, "TransferFile.xlsx"))

#================ Ejecucion ===================

#Bucle para recorrer cada archivo a mover
i <- 1
for (i in nrow(tTransferFile)) {
  
  cOrigen <- tTransferFile$RUTA_ORIGEN[i]
  cDestino <- tTransferFile$RUTA_DESTINO[i]
  cNombreFile <- tTransferFile$ARCHIVO[i]
  
  #Define Path Origen
  #En caso que la ruta origen sea la unidad de dico de Qlick (B:) NO agregamos los pats iniciarles de Usuario y Sharepoint
  if (grepl("(?i)B:", cOrigen, perl = TRUE)) {
    
    rOrigen <- file.path(paste(cOrigen, sep = ""))
    
  }else {
    
    rOrigen <- file.path(paste(rUser, "/", rSharePoint, "/", cOrigen, sep = ""))
    
  }
  
  #Define Path destino
  #En caso que la ruta destino sea la unidad de dico de Qlick (B:) NO agregamos los pats iniciarles de Usuario y Sharepoint
  if (grepl("(?i)B:", cDestino, perl = TRUE)) {
    
    rDestino <- file.path(paste(cDestino, sep = ""))
    
  }else {
    rDestino <- file.path(paste(rUser, "/", rSharePoint, "/", cDestino, sep = ""))
  }
  
  #Mover archivo
  rOrigenCompleto <- file.path(paste(rOrigen, "/", cNombreFile, sep = ""))
  rDestinoCompleto <- file.path(paste(rDestino, "/", cNombreFile, sep = ""))
  
  file.copy(rOrigenCompleto, #Path Origen
            rDestinoCompleto)
  
  if(file.copy(rOrigenCompleto, #Path Origen
            rDestinoCompleto) #Path Destino
  ) {
    print("GOOD")
  }else {
    
    print("NO GOOD")
    print(rOrigenCompleto)
    print(rDestinoCompleto)
    } 
}

