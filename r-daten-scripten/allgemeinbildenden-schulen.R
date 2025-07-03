library(readxl)
library(dplyr)

source("common/konstanten.R")

schueler_df <- read_excel(schueler_path)
schulen_df <- read_excel(schulen_path)

wk_oeff_schulen <- schulen_df %>%
  filter(di_LandkreisKz == wk_code, di_Rechtsstellung == "ÖFF")

dienststellen_nrs <- unique(na.omit(wk_oeff_schulen$di_DienststellenNr))

allg_schueler <- schueler_df %>%
  filter(Stammschule %in% dienststellen_nrs)

cat("Gesamtzahl der Schüler an öffentlichen allgemeinbildenden Schulen im Wetteraukreis:", nrow(allg_schueler), "\n")
