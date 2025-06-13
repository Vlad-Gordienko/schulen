import pandas as pd

def main():
    file_path = "../daten-generator/daten/Schulen.xlsx"
    df = pd.read_excel(file_path)

    wk_oeffSchulen = df[
        (df["di_LandkreisKz"] == 644000000000) & (df["di_Rechtsstellung"] == "ÖFF")
    ]

    grundschulen_typ = "G"
    weiterfuehrende_typen = ['HR', 'MSS', 'KGS', 'HRF', 'IGS', 'LER', 'GYM', 'GOS']
    berufsschulen_typ = "BS"

    gesamt = len(wk_oeffSchulen)
    grundschulen = len(wk_oeffSchulen[wk_oeffSchulen["di_Schultyp"] == grundschulen_typ])
    weiterführende = len(wk_oeffSchulen[wk_oeffSchulen["di_Schultyp"].isin(weiterfuehrende_typen)])
    berufsschulen = len(wk_oeffSchulen[wk_oeffSchulen["di_Schultyp"] == berufsschulen_typ])

    print(f"Gesamt: {gesamt}")
    print(f"Grundschulen: {grundschulen}")
    print(f"Weiterführende Schulen: {weiterführende}")
    print(f"Berufsschulen: {berufsschulen}")

if __name__ == "__main__":
    main()
