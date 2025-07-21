# ------------------------------------------------------------------------------
# === Pendler & Analyse ===
# Ermittelt sowohl Einpendler als auch Auspendler von Schülern im Wetteraukreis
# Quellen: Schüler.xlsx und Schulen.xlsx
# Ergebnis: schueler_pendler_gesamt.xlsx
# ------------------------------------------------------------------------------
library(readxl)
library(dplyr)
library(writexl)

# Konstanten
source("common/konstanten.R")

# Daten laden
schueler_df <- read_excel(schueler_path)
schulen_df <- read_excel(schulen_path)

# Schultypen als Referenzliste
schultypen <- c("BS", "FS", "GYM", "IGS", "KGS", "SFE")

# Einpendler
einpendler_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

einpendler_dienststellen <- unique(einpendler_schulen$di_DienststellenNr)

einpendler <- schueler_df %>%
  filter(
    Stammschule %in% einpendler_dienststellen,
    di_WohngemeindeKnz != wk_code
  ) %>%
  left_join(
    einpendler_schulen %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  ) %>%
  group_by(di_SchultypGruppe) %>%
  summarise(Einpendler = n(), .groups = "drop")

# Auspendler
auspendler_schulen <- schulen_df %>%
  filter(
    di_LandkreisKz != wk_code,
    di_Rechtsstellung == "ÖFF"
  )

auspendler_dienststellen <- unique(auspendler_schulen$di_DienststellenNr)

auspendler <- schueler_df %>%
  filter(
    Stammschule %in% auspendler_dienststellen,
    di_WohngemeindeKnz == wk_code
  ) %>%
  left_join(
    auspendler_schulen %>% select(di_DienststellenNr, di_SchultypGruppe),
    by = c("Stammschule" = "di_DienststellenNr")
  ) %>%
  group_by(di_SchultypGruppe) %>%
  summarise(Auspendler = n(), .groups = "drop")

# Zusammenführen
result <- full_join(einpendler, auspendler, by = "di_SchultypGruppe") %>%
  mutate(
    Einpendler = ifelse(is.na(Einpendler), 0, Einpendler),
    Auspendler = ifelse(is.na(Auspendler), 0, Auspendler)
  ) %>%
  filter(di_SchultypGruppe %in% schultypen) %>%
  arrange(factor(di_SchultypGruppe, levels = schultypen))

# Ausgabe
cat("Pendler Analyse nach Schultypgruppe:\n")
print(result)

if (!dir.exists("result")) dir.create("result")

write_xlsx(result, path = "result/schueler_pendler_gesamt.xlsx")
