#================ About ================
# Pasos de ejecución:
#   1.- Define Funciones

#================ Funciones ================
#Funcion para obtener el path de usuario
fGetUserPath <- function(){
  
  vUserPath <- getwd()  
  vUserPathExpr <- gregexpr("/", vUserPath, fixed = TRUE)
  vUserPathExpr <- unlist(vUserPathExpr)
  vUser <- substr(vUserPath, 1, vUserPathExpr[3] - 1)
  
}