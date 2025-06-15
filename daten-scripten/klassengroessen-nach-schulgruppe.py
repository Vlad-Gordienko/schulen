import pandas as pd

def main():
    klassen_path = "../daten-generator/daten/Klassen.xlsx"
    schulen_path = "../daten-generator/daten/Schulen.xlsx"

    klassen_df = pd.read_excel(klassen_path)
    schulen_df = pd.read_excel(schulen_path)

    wk_code = 644000000000

    schulen_filtered = schulen_df[
        (schulen_df["di_LandkreisKz"] == wk_code) &
        (schulen_df["di_Rechtsstellung"] == "ÖFF") &
        (schulen_df["di_SchultypGruppe_lang"] != "Berufliche Schulen")
    ][["di_DienststellenNr", "di_SchultypGruppe"]]

    merged = pd.merge(
        klassen_df,
        schulen_filtered,
        left_on="kl_DienststellenNr",
        right_on="di_DienststellenNr",
        how="inner"
    )

    grouped = merged.groupby("di_SchultypGruppe")["kl_AnzahlSchueler"]

    result = grouped.agg(
        Mittelwert='mean',
        Median='median'
    ).reset_index()

    print("Durchschnitt und Median der Schüleranzahl pro Schultypgruppe:")
    print(result)

if __name__ == "__main__":
    main()
