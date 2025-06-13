import pandas as pd

def main():
    schulen_path = "../daten-generator/daten/Schulen.xlsx"
    schueler_path = "../daten-generator/daten/Schüler.xlsx"

    schulen_df = pd.read_excel(schulen_path)
    schueler_df = pd.read_excel(schueler_path)

    wk_code = 644000000000

    schulen_filtered = schulen_df[
        (schulen_df["di_LandkreisKz"] != wk_code) &
        (schulen_df["di_Rechtsstellung"] == "ÖFF")
    ]

    dienststellen = schulen_filtered["di_DienststellenNr"].unique()

    schueler_filtered = schueler_df[
        (schueler_df["Stammschule"].isin(dienststellen)) &
        (schueler_df["di_WohngemeindeKnz"] == wk_code)
    ]

    merged = pd.merge(
        schueler_filtered,
        schulen_filtered[["di_DienststellenNr", "di_SchultypGruppe"]],
        left_on="Stammschule",
        right_on="di_DienststellenNr",
        how="left"
    )

    grouped = merged.groupby("di_SchultypGruppe").size().reset_index(name="Anzahl Schüler")

    print("Anzahl der Schüler aus dem Wetteraukreis in öffentlichen Schulen außerhalb des Kreises:")
    print(grouped)

if __name__ == "__main__":
    main()
