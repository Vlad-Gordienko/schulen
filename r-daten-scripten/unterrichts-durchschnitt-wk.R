# ------------------------------------------------------------------------------
# Skript zur Auswertung der Unterrichtsdaten in öffentlichen Schulen im Wetteraukreis
# Ziel: Durchschnitt und Median der Schüleranzahl pro Unterricht und Schule
# Verwendet: Schulen.xlsx und Unterrichte.xlsx
# ------------------------------------------------------------------------------
library(readxl)  # zum Einlesen von Excel-Dateien
library(dplyr)   # für Datenverarbeitung

# Konstanten
source("common/konstanten.R")

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Unterrichtsdaten laden
unterrichte_df <- read_excel(unterrichte_path)

# Öffentliche Schulen im Wetteraukreis filtern
filtered_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

# Nur Unterrichte aus diesen Schulen auswählen
unterrichte_filtered <- unterrichte_df %>%
  filter(un_DienststellenNr %in% filtered_schulen$di_DienststellenNr)

# Schuldaten (Name) hinzufügen
merged <- unterrichte_filtered %>%
  left_join(
    filtered_schulen %>% select(di_DienststellenNr, di_Name),
    by = c("un_DienststellenNr" = "di_DienststellenNr")
  )

# Gruppierung nach Schulname und Berechnung von Mittelwert und Median
grouped <- merged %>%
  group_by(di_Name) %>%
  summarise(
    `Durchschnitt Schüler pro Unterricht` = mean(un_AnzahlSchueler, na.rm = TRUE),
    `Median Schüler pro Unterricht` = median(un_AnzahlSchueler, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  rename(Schulname = di_Name)

# Ergebnis ausgeben
cat("Mittlere und durchschnittliche Anzahl von Schülern im Unterricht (pro Schule im Wetteraukreis):\n\n")
print(grouped)
