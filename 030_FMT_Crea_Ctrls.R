#================ About ================
# Pasos de ejecución:
#   1.- Extraer información de archivo
#   2.- Filtrar controles
#   3.- Escribir controles filtrados

#================ Librerias  ==============
{
  if (!require("readxl")) install.packages("readxl")
  library("readxl")
  if (!require("dplyr")) install.packages("dplyr")
  library("dplyr")
  if (!require("lubridate")) install.packages("lubridate")
  library("lubridate")
  if (!require("stringi")) install.packages("stringi")
  library("stringi")
  if (!require("tidyr")) install.packages("tidyr")
  library("tidyr")
  if (!require("rio")) install.packages("rio")
  library("rio")
  if (!require("writexl")) install.packages("writexl")
  library("writexl")
  if (!require("stringr")) install.packages("stringr")
  library("stringr")
  
  #Zona Horaria
  Sys.setenv(TZ = "Etc/GMT+6")
}

{
  
  #================ Funciones ================
  #Funcion para obtener el path de usuario
  fGetUserPath <- function(){
    
    vUserPath <- getwd()  
    vUserPathExpr <- gregexpr("/", vUserPath, fixed = TRUE)
    vUserPathExpr <- unlist(vUserPathExpr)
    vUser <- substr(vUserPath, 1, vUserPathExpr[3] - 1)
    
  }
  
  #============== Paths ==============
  #Path de usuario
  rUser <- fGetUserPath()
  
  #Path de SharePoint
  #1 <- Desarrollador
  #0 <- Despliegue
  Modo <- 0
  
  rSharePoint <- ifelse(Modo == 1, file.path("Documents", "Development", "REPORTES"), file.path("GrandVision/MX1-MV Supply Chain - Documentos", "Reportes"))
  
  #Path de Tablas
  rTablas <- file.path(rUser, rSharePoint, "FBEM", "000_FMT_GLOBAL", "01_Tablas")
  
  #Path de Reportes
  rReportes <- file.path(rUser, rSharePoint, "FBEM", "000_FMT_GLOBAL", "02_Reportes")
  
  #Elementos a mantener en el environment
  vMantener <- c("vMantener")
  vMantener <- c(vMantener, ls())
  
}

{
  #============== Importaciones ==============
  #Archivo Base
  tCreaCtrl <- read.csv(file.path(rTablas, "Crea_Controles.csv"), header = TRUE, sep = ",")
  
  #============== Ejecucion ==============
  #Ciclo que recorre tantos controles se necesiten generar
  #cDelta01 <- 1
  for (cDelta01 in unique(tCreaCtrl$CONTROL)) {
    
    #Filtro de control
    q000Ctrl <- tCreaCtrl %>% 
      filter(CONTROL == cDelta01) %>% 
      select(ID_ALMACEN, SKU, CANTIDAD, ALM_CENTRAL)
    
    #Escribe Control
    write.table(q000Ctrl, file.path(rReportes, "Crea_Controles", paste("CTRL_", cDelta01, "_", today(), ".csv", sep = "")), col.names = FALSE, row.names = FALSE, sep = ",")
  }
  
}


rm(list = ls())
