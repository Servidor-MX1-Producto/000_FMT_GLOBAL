#================ About ================
# Pasos de ejecución:
#   1.- 
#   2.- 
#   3.- 

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
  if (!require("logger")) install.packages("logger")
  library("logger")
  
  #Zona Horaria
  Sys.setenv(TZ = "Etc/GMT+6")
}

#============== Funciones ==============
source("090_Utils/091_Funciones.R")

#============== Paths ==============
source("090_Utils/092_Paths.R")

#================ Bitacora ================
source("090_Utils/093_Bitacoras.R")

#Elementos a mantener en el environment
vMantener <- c("vMantener")
vMantener <- c(vMantener, ls())

#================ Ejecucion ===================
#Borra Samba
source("010_Proceso/011_Borra_Samba.R")

#TransferFile
source("010_Proceso/012_Transfer_File.R")

rm(list = ls())