library(readxl)
library(dplyr)

source("common/konstanten.R")

klassen_df <- read_excel(klassen_path)
schulen_df <- read_excel(schulen_path)

schulen_filtered <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF",
    di_SchultypGruppe_lang != "Berufliche Schulen"
  ) %>%
  select(di_DienststellenNr, di_SchultypGruppe)

merged <- klassen_df %>%
  inner_join(schulen_filtered, by = c("kl_DienststellenNr" = "di_DienststellenNr"))

result <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(
    Mittelwert = mean(kl_AnzahlSchueler, na.rm = TRUE),
    Median = median(kl_AnzahlSchueler, na.rm = TRUE),
    .groups = "drop"
  )

cat("Durchschnitt und Median der Schüleranzahl pro Schultypgruppe:\n")
print(result)
