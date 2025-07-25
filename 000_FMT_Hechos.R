#================ About ================
# Pasos de ejecución:
#   1.- Extraer información de Qlik
#   2.- Calcular Faltantes
#   3.- Calcular Distribucion

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
  
  rSharePoint <- ifelse(Modo == 1, file.path("Documents", "Development", "REPORTES"), file.path("Luxottica Group S.p.A"))
  
  #Path de Tablas
  rTablas <- file.path(rUser, rSharePoint, "PVC_EL_MX - Documentos", "Reportes", "FBEM", "000_FMT_GLOBAL", "01_Tablas")
  
  #Path de Reportes
  rReportes <- file.path(rUser, rSharePoint, "PVC_EL_MX - Documentos", "Reportes", "FBEM", "000_FMT_GLOBAL", "02_Reportes")
  
  #================ Constantes ================ 
  
  #Año 
  cAnio <- substring((Sys.time()-3), 1, 4)
  
  #Mes
  cMes <- substring((Sys.time()-3), 6, 7)
  
  #Día
  cDia <- substring((Sys.time()-3), 9, 10)
  
  #Primer día del mes, segun la fecha actual
  cPrimerDiaMes <- seq(as.Date(ceiling_date(Sys.Date(), "month")), length = 2, by = "-1 months")[2] 
  
  #Fecha (n) meses de venta
  cMeses <- 2
  cFechaMeses <- floor_date((today() - 1) %m+% months(- cMeses), "month")
  
  #Fecha (n) semanas atras
  cSemanas <- 8
  cFechaSemanas <- (today() -1) %m+% weeks(-cSemanas)
  
  #Elementos a mantener en el environment
  vMantener <- c("vMantener")
  vMantener <- c(vMantener, ls())
  
}

#================ Ejecucion ===================
#TransferFile
source("010_FMT_Transfer_File.R")

#Borra Samba
source("020_FMT_Borra_Samba.R")

#Crea Controles
#source("030_FMT_Crea_Ctrls.R")

rm(list = ls())