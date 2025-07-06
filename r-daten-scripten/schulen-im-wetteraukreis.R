# ------------------------------------------------------------------------------
# Skript zur Zählung der öffentlichen Schulen im Wetteraukreis
# Unterscheidung nach Grundschulen, weiterführenden Schulen und Berufsschulen
# Verwendet: Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)  # zum Einlesen von Excel-Dateien
library(dplyr)   # für Datenmanipulation

# Konstanten
source("common/konstanten.R")

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Öffentliche Schulen im Wetteraukreis filtern
wk_oeffSchulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

# Definition der Schultypen
grundschulen_typ <- "G"  # Grundschule
weiterfuehrende_typen <- c("HR", "MSS", "KGS", "HRF", "IGS", "LER", "GYM", "GOS")  # Weiterführend
berufsschulen_typ <- "BS"  # Berufsschule

# Anzahl aller öffentlichen Schulen im Kreis
gesamt <- nrow(wk_oeffSchulen)

# Anzahl nach Typen ermitteln
grundschulen <- sum(wk_oeffSchulen$di_Schultyp == grundschulen_typ, na.rm = TRUE)
weiterfuehrende <- sum(wk_oeffSchulen$di_Schultyp %in% weiterfuehrende_typen, na.rm = TRUE)
berufsschulen <- sum(wk_oeffSchulen$di_Schultyp == berufsschulen_typ, na.rm = TRUE)

# Ergebnisse ausgeben
cat("Gesamt:", gesamt, "\n")
cat("Grundschulen:", grundschulen, "\n")
cat("Weiterführende Schulen:", weiterfuehrende, "\n")
cat("Berufsschulen:", berufsschulen, "\n")
