import pandas as pd

def main():
    schueler_path = "../daten-generator/daten/Schüler.xlsx"
    schulen_path = "../daten-generator/daten/Schulen.xlsx"

    wk_code = 644000000000
    verkehrssprache_deutsch = 'de'

    schueler_df = pd.read_excel(schueler_path)
    schulen_df = pd.read_excel(schulen_path)

    wk_oeff_schulen = schulen_df[
        (schulen_df["di_LandkreisKz"] == wk_code) &
        (schulen_df["di_Rechtsstellung"] == "ÖFF")
    ]

    dienststellen = wk_oeff_schulen["di_DienststellenNr"].unique()

    schueler_in_wk = schueler_df[
        schueler_df["Stammschule"].isin(dienststellen)
    ]

    merged = pd.merge(
        schueler_in_wk,
        wk_oeff_schulen[["di_DienststellenNr", "di_SchultypGruppe"]],
        left_on="Stammschule",
        right_on="di_DienststellenNr",
        how="left"
    )

    merged["NichtDeutsch"] = merged["VerkehrsspracheInFamilie"].apply(
        lambda lang: 1 if str(lang).strip().lower() != verkehrssprache_deutsch else 0
    )

    gruppiert = merged.groupby("di_SchultypGruppe")["NichtDeutsch"].agg(
        AnteilNichtDeutsch=lambda x: round(x.sum() / len(x) * 100, 2),
        GesamtAnzahl="count"
    ).reset_index()

    print("Anteil der Schüler mit nicht-deutscher Verkehrssprache in Familien (nach Schultypgruppe):")
    print(gruppiert)

if __name__ == "__main__":
    main()
