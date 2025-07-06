# ------------------------------------------------------------------------------
# Skript zur Berechnung von Durchschnitt und Median der Schüleranzahl
# pro Schultypgruppe (ohne berufliche Schulen) im Wetteraukreis
# Verwendet: Klassen.xlsx und Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)  # zum Einlesen von Excel-Dateien
library(dplyr)   # für Datenmanipulation

# Konstanten
source("common/konstanten.R")

# Klassendaten laden
klassen_df <- read_excel(klassen_path)

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Schulen im Wetteraukreis filtern:
# - nur öffentliche Schulen
# - keine beruflichen Schulen
schulen_filtered <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF",
    di_SchultypGruppe_lang != "Berufliche Schulen"
  ) %>%
  select(di_DienststellenNr, di_SchultypGruppe)

# Klassendaten mit gefilterten Schuldaten verknüpfen
merged <- klassen_df %>%
  inner_join(schulen_filtered, by = c("kl_DienststellenNr" = "di_DienststellenNr"))

# Durchschnitt und Median der Schüleranzahl je Schultypgruppe berechnen
result <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(
    Mittelwert = mean(kl_AnzahlSchueler, na.rm = TRUE),
    Median = median(kl_AnzahlSchueler, na.rm = TRUE),
    .groups = "drop"
  )

# Ergebnis ausgeben
cat("Durchschnitt und Median der Schüleranzahl pro Schultypgruppe:\n")
print(result)
