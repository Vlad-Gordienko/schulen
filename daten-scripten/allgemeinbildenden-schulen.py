import pandas as pd

def main():
    df_schulen = pd.read_excel("../daten-generator/daten/Schulen.xlsx")
    df_schueler = pd.read_excel("../daten-generator/daten/Schüler.xlsx")

    wk_oeff_schulen = df_schulen[
        (df_schulen["di_LandkreisKz"] == 644000000000) &
        (df_schulen["di_Rechtsstellung"] == "ÖFF")
    ]

    dienststellen_nrs = wk_oeff_schulen["di_DienststellenNr"].dropna().unique()

    allg_schueler = df_schueler[
        df_schueler["Stammschule"].isin(dienststellen_nrs)
    ]

    print(f"Gesamtzahl der Schüler an öffentlichen allgemeinbildenden Schulen im Wetteraukreis: {len(allg_schueler)}")


if __name__ == "__main__":
    main()
