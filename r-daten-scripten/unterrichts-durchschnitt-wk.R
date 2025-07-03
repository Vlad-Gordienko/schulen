library(readxl)
library(dplyr)

source("common/konstanten.R")

schulen_df <- read_excel(schulen_path)
unterrichte_df <- read_excel(unterrichte_path)

filtered_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

unterrichte_filtered <- unterrichte_df %>%
  filter(un_DienststellenNr %in% filtered_schulen$di_DienststellenNr)

merged <- unterrichte_filtered %>%
  left_join(
    filtered_schulen %>% select(di_DienststellenNr, di_Name),
    by = c("un_DienststellenNr" = "di_DienststellenNr")
  )

grouped <- merged %>%
  group_by(di_Name) %>%
  summarise(
    `Durchschnitt Schüler pro Unterricht` = mean(un_AnzahlSchueler, na.rm = TRUE),
    `Median Schüler pro Unterricht` = median(un_AnzahlSchueler, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  rename(Schulname = di_Name)

cat("Mittlere und durchschnittliche Anzahl von Schülern im Unterricht (pro Schule im Wetteraukreis):\n\n")
print(grouped)
