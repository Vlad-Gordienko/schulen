import pandas as pd

def main():
    schulen_path = "../daten-generator/daten/Schulen.xlsx"
    unterrichte_path = "../daten-generator/daten/Unterrichte.xlsx"

    schulen_df = pd.read_excel(schulen_path)
    unterrichte_df = pd.read_excel(unterrichte_path)

    wk_code = 644000000000

    filtered_schulen = schulen_df[
        (schulen_df["di_LandkreisKz"] == wk_code) &
        (schulen_df["di_Rechtsstellung"] == "ÖFF")
    ]

    unterrichte_filtered = unterrichte_df[
        unterrichte_df["un_DienststellenNr"].isin(filtered_schulen["di_DienststellenNr"])
    ]

    merged = pd.merge(
        unterrichte_filtered,
        filtered_schulen[["di_DienststellenNr", "di_Name"]],
        left_on="un_DienststellenNr",
        right_on="di_DienststellenNr",
        how="left"
    )

    grouped = merged.groupby("di_Name")["un_AnzahlSchueler"].agg(["mean", "median"]).reset_index()
    grouped.columns = ["Schulname", "Durchschnitt Schüler pro Unterricht", "Median Schüler pro Unterricht"]

    print("Mittlere und durchschnittliche Anzahl von Schülern im Unterricht (pro Schule im Wetteraukreis):\n")
    print(grouped)

if __name__ == "__main__":
    main()
