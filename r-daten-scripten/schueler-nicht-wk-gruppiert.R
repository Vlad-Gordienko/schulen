library(readxl)
library(dplyr)

source("common/konstanten.R")

schueler_df <- read_excel(schueler_path)
schulen_df <- read_excel(schulen_path)

schulen_filtered <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

dienststellen <- unique(schulen_filtered$di_DienststellenNr)

schueler_filtered <- schueler_df %>%
  filter(
    Stammschule %in% dienststellen,
    di_WohngemeindeKnz != wk_code
  )

merged <- schueler_filtered %>%
  left_join(
    schulen_filtered %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  )

grouped <- merged %>%
  group_by(di_SchultypGruppe) %>%
  summarise(`Anzahl Schüler` = n(), .groups = "drop")

cat("Anzahl der Schüler in öffentlichen Schulen im Wetteraukreis (außerhalb wohnhaft):\n")
print(grouped)
