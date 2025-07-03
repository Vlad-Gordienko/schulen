library(readxl)
library(dplyr)

source("common/konstanten.R")

schueler_df <- read_excel(schueler_path)
schulen_df <- read_excel(schulen_path)

wk_oeff_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

dienststellen <- unique(wk_oeff_schulen$di_DienststellenNr)

schueler_in_wk <- schueler_df %>%
  filter(Stammschule %in% dienststellen)

merged <- schueler_in_wk %>%
  left_join(
    wk_oeff_schulen %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  )

merged <- merged %>%
  mutate(
    VerkehrsspracheInFamilie = tolower(trimws(VerkehrsspracheInFamilie)),
    NichtDeutsch = ifelse(VerkehrsspracheInFamilie != "de", 1, 0)
  )

gruppiert <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(
    AnteilNichtDeutsch = round(sum(NichtDeutsch, na.rm = TRUE) / n() * 100, 2),
    GesamtAnzahl = n(),
    .groups = "drop"
  )

cat("Anteil der Schüler mit nicht-deutscher Verkehrssprache in Familien (nach Schultypgruppe):\n")
print(gruppiert)
