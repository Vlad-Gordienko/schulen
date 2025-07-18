# ------------------------------------------------------------------------------
# Skript zum Zählen der Schüler an öffentlichen Schulen im Wetteraukreis
# Verwendet: Schüler.xlsx und Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)   # Excel einlesen
library(dplyr)    # Datenbearbeitung
library(writexl)  # Excel schreiben

# Konstanten
source("common/konstanten.R")

# Schülerdaten laden
schueler_df <- read_excel(schueler_path)

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Öffentliche Schulen im Wetteraukreis auswählen
wk_oeff_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

# Dienststellennummern extrahieren
dienststellen_nrs <- unique(na.omit(wk_oeff_schulen$di_DienststellenNr))

# Schüler filtern
allg_schueler <- schueler_df %>%
  filter(Stammschule %in% dienststellen_nrs)

# Ergebnis als Tabelle
result <- data.frame(
  Kategorie = "Gesamtzahl der Schüler an öffentlichen Schulen im Wetteraukreis",
  Anzahl = nrow(allg_schueler)
)

# Anzahl der Schüler ausgeben
cat(
  "Gesamtzahl der Schüler an öffentlichen allgemeinbildenden Schulen im Wetteraukreis:",
  nrow(allg_schueler),
  "\n"
)

# In Excel speichern
if (!dir.exists("result")) dir.create("result")

write_xlsx(result, path = "result/allgemein_schueler.xlsx")
