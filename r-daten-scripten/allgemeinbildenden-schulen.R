# ------------------------------------------------------------------------------
# Skript zum Zählen der Schüler an öffentlichen Schulen im Wetteraukreis
# Verwendet: Schüler.xlsx und Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)  # zum Einlesen von Excel-Dateien
library(dplyr)   # zum Bearbeiten von Datentabellen

# Konstanten
source("common/konstanten.R")

# Schülerdaten laden
schueler_df <- read_excel(schueler_path)

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Öffentliche Schulen im Wetteraukreis auswählen
wk_oeff_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,       # nur Schulen im Wetteraukreis
    di_Rechtsstellung == "ÖFF"       # nur öffentliche Schulen
  )

# Dienststellennummern extrahieren (ohne NA und Duplikate)
dienststellen_nrs <- unique(na.omit(wk_oeff_schulen$di_DienststellenNr))

# Schüler auswählen, deren Stammschule in der Liste ist
allg_schueler <- schueler_df %>%
  filter(Stammschule %in% dienststellen_nrs)

# Anzahl der Schüler ausgeben
cat(
  "Gesamtzahl der Schüler an öffentlichen allgemeinbildenden Schulen im Wetteraukreis:",
  nrow(allg_schueler),
  "\n"
)
