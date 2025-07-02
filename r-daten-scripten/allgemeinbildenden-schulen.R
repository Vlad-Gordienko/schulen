library(readxl)
library(dplyr)

df_schulen <- read_excel("../daten-generator/daten/Schulen.xlsx")
df_schueler <- read_excel("../daten-generator/daten/Schüler.xlsx")

wk_oeff_schulen <- df_schulen %>%
  filter(di_LandkreisKz == "644000000000", di_Rechtsstellung == "ÖFF")

dienststellen_nrs <- unique(na.omit(wk_oeff_schulen$di_DienststellenNr))

allg_schueler <- df_schueler %>%
  filter(Stammschule %in% dienststellen_nrs)

cat("Gesamtzahl der Schüler an öffentlichen allgemeinbildenden Schulen im Wetteraukreis:", nrow(allg_schueler), "\n")
