#  **000_FMT_GLOBAL**


## **INTRODUCCIÓN:**
### **Descripción General**
Proyecto utilizado para agregar herramientas que ayuden a el flujo de procesos que se llevan a cabo dentro de la empresa.

### **Objetivos**
- Organizar el flujo de procesos.

### **Alcance**
Este proyecto se centra exclusivamente dentro de los catalogos, proyectos, reportes, etc. que se encuentren en OneDrive y servidores relacionados.

## **INSTALACIÓN:**
### **Requisitos del Sistema**
- **Hardware:** Procesador de 2 GHz, 4 GB de RAM, 500 MB de espacio en disco.
- **Sistema Operativo:** Windows 10, macOS Catalina, Linux Ubuntu 18.04+.
- **Dependencias:** R 4.0+, Power_BI Desktop.

### **Instrucciones de Instalación:**
1. Instalar el CRAN de R
2. Instalar RStudio
3. Instalar Git
4. Clonar repositorio **(git remote origin https://github.com/...)**

***

## **USO DEL SOFTWARE:**
### **Guia del Usuario**
- Ejecución
    - Abrir el proyecto con RStudio
    - Abrir script **000_Hechos.R**
    - Ejecutar, ya que el script contiene el flujo nesesario del proyecto
    
- Desarrollo
    - Abrir el proyecto con RStudio
    - Abrir script **000_Hechos.R**
    - Definir la variable Modo en 0, que define la forma de desarrollo.
    
    
[!TIP]
Asegurar que las carpetas se encuentren en la ruta correcta, ya que se utilizan en el proceso del poyecto.
***

## **ARQUITECTURA DEL SOFTWARE:**
### **Flujo del Proyecto**

```mermaid
graph TD
    A([INICIO]) --> B[DEFINE PATHS Y CONSTANTES]
    B --> C[TRANSFER FILE]
    C --> D[BORA SAMBA]
    D --> E([FIN])
```