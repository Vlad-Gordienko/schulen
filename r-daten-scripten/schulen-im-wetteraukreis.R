# ------------------------------------------------------------------------------
# Skript zur Zählung der öffentlichen Schulen im Wetteraukreis
# Unterscheidung nach Grundschulen, weiterführenden Schulen und Berufsschulen
# Verwendet: Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)    # Excel einlesen
library(dplyr)     # Datenmanipulation
library(writexl)   # Excel schreiben

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
grundschulen_typ <- "G"
weiterfuehrende_typen <- c("HR", "MSS", "KGS", "HRF", "IGS", "LER", "GYM", "GOS")
berufsschulen_typ <- "BS"

# Anzahl berechnen
gesamt <- nrow(wk_oeffSchulen)
grundschulen <- sum(wk_oeffSchulen$di_Schultyp == grundschulen_typ, na.rm = TRUE)
weiterfuehrende <- sum(wk_oeffSchulen$di_Schultyp %in% weiterfuehrende_typen, na.rm = TRUE)
berufsschulen <- sum(wk_oeffSchulen$di_Schultyp == berufsschulen_typ, na.rm = TRUE)

# Ergebnisse ausgeben
cat("Gesamt:", gesamt, "\n")
cat("Grundschulen:", grundschulen, "\n")
cat("Weiterführende Schulen:", weiterfuehrende, "\n")
cat("Berufsschulen:", berufsschulen, "\n")

# Ergebnis als Tabelle
result <- data.frame(
  Kategorie = c("Gesamt", "Grundschulen", "Weiterführende Schulen", "Berufsschulen"),
  Anzahl = c(gesamt, grundschulen, weiterfuehrende, berufsschulen)
)

# In Excel schreiben
if (!dir.exists("result")) dir.create("result")

write_xlsx(result, path = "result/schulen_anzahl.xlsx")

