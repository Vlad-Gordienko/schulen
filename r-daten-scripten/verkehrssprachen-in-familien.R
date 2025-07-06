# ------------------------------------------------------------------------------
# Skript zur Ermittlung des Anteils von Schülern mit nicht-deutscher
# Verkehrssprache in der Familie, gruppiert nach Schultypgruppe
# Verwendet: Schüler.xlsx und Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)  # zum Einlesen von Excel-Dateien
library(dplyr)   # für Datenverarbeitung

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
dienststellen <- unique(wk_oeff_schulen$di_DienststellenNr)

# Schüler im Wetteraukreis auswählen
schueler_in_wk <- schueler_df %>%
  filter(Stammschule %in% dienststellen)

# Schultypgruppe ergänzen
merged <- schueler_in_wk %>%
  left_join(
    wk_oeff_schulen %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  )

# Sprache vereinheitlichen und Indikator für Nicht-Deutsch erstellen
merged <- merged %>%
  mutate(
    VerkehrsspracheInFamilie = tolower(trimws(VerkehrsspracheInFamilie)),
    NichtDeutsch = ifelse(VerkehrsspracheInFamilie != "de", 1, 0)
  )

# Gruppierung nach Schultypgruppe und Berechnung des Anteils
gruppiert <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(
    AnteilNichtDeutsch = round(sum(NichtDeutsch, na.rm = TRUE) / n() * 100, 2),
    GesamtAnzahl = n(),
    .groups = "drop"
  )

# Ergebnis ausgeben
cat("Anteil der Schüler mit nicht-deutscher Verkehrssprache in Familien (nach Schultypgruppe):\n")
print(gruppiert)
