# ------------------------------------------------------------------------------
# Skript zur Ermittlung des Anteils von Schülern mit nicht-deutscher
# Verkehrssprache in der Familie, gruppiert nach Schultypgruppe
# Verwendet: Schüler.xlsx und Schulen.xlsx
# Ergebnis: verkehrssprache.xlsx
# ------------------------------------------------------------------------------
library(readxl)
library(dplyr)
library(writexl)

# Konstanten
source("common/konstanten.R")

# Daten laden
schueler_df <- read_excel(schueler_path)
schulen_df <- read_excel(schulen_path)

# Öffentliche Schulen im Wetteraukreis auswählen
wk_oeff_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

dienststellen <- unique(wk_oeff_schulen$di_DienststellenNr)

# Schüler auswählen und Schultyp ergänzen
merged <- schueler_df %>%
  filter(Stammschule %in% dienststellen) %>%
  left_join(
    wk_oeff_schulen %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  ) %>%
  mutate(
    VerkehrsspracheInFamilie = tolower(trimws(VerkehrsspracheInFamilie)),
    NichtDeutsch = ifelse(VerkehrsspracheInFamilie != "de", 1, 0)
  )

# Gruppierung und Berechnungen
gruppiert <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(
    Gesamt = n(),
    NichtDeutsch = sum(NichtDeutsch, na.rm = TRUE),
    ProzentNichtDeutsch = round(NichtDeutsch / Gesamt * 100, 2),
    .groups = "drop"
  )

# Ergebnis ausgeben
cat("Anteil und Anzahl der Schüler mit nicht-deutscher Verkehrssprache (nach Schultypgruppe):\n")
print(gruppiert)

# In Excel speichern
write_xlsx(gruppiert, path = "result/verkehrssprache.xlsx")
