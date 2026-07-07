# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

R project that automates file management tasks: transferring files between OneDrive/SharePoint and a Samba server, cleaning up old files from Samba, and generating control CSV files. Runs daily at 6:20 AM via `DIST_FMT_GLOBAL.bat`.

## Running the Project

Open `000_FMT_GLOBAL.Rproj` in RStudio, then source the entry point:

```r
source("000_FMT_Hechos.R")
```

To run a single sub-script manually, ensure the variables from `000_FMT_Hechos.R` (libraries, paths, constants, `vMantener`) are loaded first, then:

```r
source("010_FMT_Transfer_File.R")
source("020_FMT_Borra_Samba.R")
# source("030_FMT_Crea_Ctrls.R")  # Currently disabled
```

## Development vs. Deployment Mode

The `Modo` variable in `000_FMT_Hechos.R` controls which SharePoint path is used:

| Modo | Description | SharePoint root |
|------|-------------|-----------------|
| `1`  | Development | `Documents/Development/REPORTES` (local) |
| `0`  | Deployment  | `Luxottica Group S.p.A` (server) |

When developing, set `Modo <- 1` and ensure local folder structure mirrors SharePoint layout.

## Architecture

`000_FMT_Hechos.R` is the sole entry point. It loads libraries, defines helper functions, sets paths/constants, and calls sub-scripts via `source()` in numbered order:

```
000_FMT_Hechos.R
  └─ source("010_FMT_Transfer_File.R")   # Copies files per TransferFile.xlsx catalog
  └─ source("020_FMT_Borra_Samba.R")     # Deletes old files from Samba share
  └─ source("030_FMT_Crea_Ctrls.R")      # (disabled) Generates control CSVs
```

**Key paths** (resolved at runtime using `rUser` + `rSharePoint`):
- `rTablas` — `01_Tablas/` — input catalogs (xlsx, csv)
- `rReportes` — `02_Reportes/` — output files
- `rSamba` — `\\samba.ggv.mx\samba\K\archivos\DA_piloto` — Samba share (hardcoded)

**Catalog files** (in `01_Tablas/`):
- `TransferFile.xlsx` — columns `RUTA_ORIGEN`, `RUTA_DESTINO`, `ARCHIVO`; drives `010_FMT_Transfer_File.R`
- `Crea_Controles.csv` — columns `CONTROL`, `ID_ALMACEN`, `SKU`, `CANTIDAD`, `ALM_CENTRAL`; drives `030_FMT_Crea_Ctrls.R`

**Special path rule in `010`:** If `RUTA_ORIGEN` or `RUTA_DESTINO` starts with `B:`, the `rUser`/`rSharePoint` prefix is skipped (Qlik disk drive).

## Environment Cleanup Pattern

Each sub-script ends with this pattern to avoid polluting the shared R environment:

```r
vGuarda <- c("varToKeep")       # add names of objects to preserve
vMantener <- c(vMantener, vGuarda)
vBorrar <- setdiff(ls(), vMantener)
rm(list = vBorrar)
rm(vBorrar)
```

`vMantener` is initialized in `000_FMT_Hechos.R` and passed through all sub-scripts.

## Libraries

Auto-installed on first run if missing: `readxl`, `dplyr`, `lubridate`, `stringi`, `tidyr`, `rio`, `writexl`, `stringr`. Timezone is set to `Etc/GMT+6`.
