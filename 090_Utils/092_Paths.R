#================ About ================
# Pasos de ejecución:
#   1.- Obtiene url de usuario
#   2.- Deine el modo de ejecucion
#   3.- Define paths

#============== Paths ==============
#Path de usuario
rUser <- fGetUserPath()

#Nombre de Usuario
rUserName <- basename(rUser)

#Path de SharePoint
#1 <- Desarrollador
#0 <- Despliegue
Modo <- 1

rSharePoint <- ifelse(Modo == 1, file.path("Documents", "Development", "REPORTES"), file.path("Luxottica Group S.p.A/PVC_EL_MX - Documentos", "Reportes"))
rTablas <- file.path(rUser, rSharePoint, "FBEM", "000_FMT_GLOBAL", "01_Tablas")
rReportes <- file.path(rUser, rSharePoint, "FBEM", "000_FMT_GLOBAL", "02_Reportes")
rBitacoras <- file.path(rUser, rSharePoint, "FBEM", "000_FMT_GLOBAL", "04_Bitacoras")
rSamba <- file.path("\\\\samba.ggv.mx\\samba\\K\\archivos\\DA_piloto")