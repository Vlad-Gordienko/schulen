library(readxl)
library(dplyr)

source("common/konstanten.R")

schulen_df <- read_excel(schulen_path)

wk_oeffSchulen <- schulen_df %>%
  filter(
    di_LandkreisKz == wk_code,
    di_Rechtsstellung == "ÖFF"
  )

grundschulen_typ <- "G"
weiterfuehrende_typen <- c("HR", "MSS", "KGS", "HRF", "IGS", "LER", "GYM", "GOS")
berufsschulen_typ <- "BS"

gesamt <- nrow(wk_oeffSchulen)
grundschulen <- sum(wk_oeffSchulen$di_Schultyp == grundschulen_typ, na.rm = TRUE)
weiterfuehrende <- sum(wk_oeffSchulen$di_Schultyp %in% weiterfuehrende_typen, na.rm = TRUE)
berufsschulen <- sum(wk_oeffSchulen$di_Schultyp == berufsschulen_typ, na.rm = TRUE)

cat("Gesamt:", gesamt, "\n")
cat("Grundschulen:", grundschulen, "\n")
cat("Weiterführende Schulen:", weiterfuehrende, "\n")
cat("Berufsschulen:", berufsschulen, "\n")
