# ------------------------------------------------------------------------------
# === Einpendler ===
# Skript zur Ermittlung der Schüler, die eine öffentliche Schule
# im Wetteraukreis besuchen, aber außerhalb wohnen
# Quellen: Schüler.xlsx und Schulen.xlsx
# Ergebnis: schueler_nicht_wk.xlsx
# ------------------------------------------------------------------------------
library(readxl)   # Excel einlesen
library(dplyr)    # Datenverarbeitung
library(writexl)  # Excel schreiben

# Konstanten
source("common/konstanten.R")

# Schülerdaten laden
schueler_df <- read_excel(schueler_path)

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Öffentliche Schulen im Wetteraukreis auswählen
schulen_filtered <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

# Dienststellennummern extrahieren
dienststellen <- unique(schulen_filtered$di_DienststellenNr)

# Schüler auswählen:
schueler_filtered <- schueler_df %>%
  filter(
    Stammschule %in% dienststellen,
    di_WohngemeindeKnz != wk_code
  )

# Schultyp ergänzen
merged <- schueler_filtered %>%
  left_join(
    schulen_filtered %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  )

# Gruppierung nach Schultypgruppe
grouped <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(`Anzahl Schüler` = n(), .groups = "drop")

# Ergebnis ausgeben
cat("Anzahl der Schüler in öffentlichen Schulen im Wetteraukreis (außerhalb wohnhaft):\n")
print(grouped)

# In Excel speichern
if (!dir.exists("result")) dir.create("result")

write_xlsx(grouped, path = "result/schueler_nicht_wk.xlsx")
