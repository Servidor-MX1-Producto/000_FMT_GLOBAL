#================ About ================
# Pasos de ejecución:
#   1.- verifica que el directorio de bitacoras exista
#   2.- crea archivo de bitacora
#   3.- configura el logger para escribir en el archivo y en consola
#   4.- Da inicio al proceso escribiendo en bitacora

#================ Bitacora ================
#Crear carpeta si no existe
dir.create(rBitacoras, showWarnings = FALSE, recursive = TRUE)

#Nombre del archivo con fecha del día
rLogArchivo <- file.path(rBitacoras, paste0("Bitacora_", format(today(), "%Y-%m-%d"), ".log"))

#Escribir a archivo y a consola simultáneamente
log_appender(appender_tee(rLogArchivo))

#Nivel de detalle (INFO en producción, DEBUG para desarrollo)
log_threshold(INFO)

#Layout con usuario incluido en cada entrada
log_layout(layout_glue_generator(
  format = paste0("[", rUserName, "] {level} [{format(time, \"%Y-%m-%d %H:%M:%S\")}] {msg}")
))

#Inicio de bitacora
log_info("Global — Inicio de bitácora")
