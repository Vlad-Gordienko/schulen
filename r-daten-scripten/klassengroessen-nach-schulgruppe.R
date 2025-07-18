# ------------------------------------------------------------------------------
# Skript zur Berechnung von Durchschnitt und Median der Schüleranzahl
# pro Schultypgruppe (ohne berufliche Schulen) im Wetteraukreis
# Verwendet: Klassen.xlsx und Schulen.xlsx
# ------------------------------------------------------------------------------
library(readxl)   # Excel einlesen
library(dplyr)    # Datenmanipulation
library(writexl)  # Excel schreiben

# Konstanten
source("common/konstanten.R")

# Klassendaten laden
klassen_df <- read_excel(klassen_path)

# Schuldaten laden
schulen_df <- read_excel(schulen_path)

# Schulen im Wetteraukreis filtern:
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

# In Excel speichern
if (!dir.exists("result")) dir.create("result")

write_xlsx(result, path = "result/klassengroessen.xlsx")
