# Schulstatistische Auswertung im Wetteraukreis

Dieses Projekt ist ein Auswertungssystem für schulstatistische Daten im **Landkreis Wetteraukreis** (Landkreis-Schlüssel: `644000000000`).  
Es dient der Generierung und Analyse von Daten über Schulen, Schüler, Unterricht und Abschlüsse im Excel-Format.

Das Projekt besteht aus zwei Hauptkomponenten:

1. **Datengenerierung (Python)** – zur Erstellung realistischer Testdaten in Excel-Dateien
2. **Datenauswertung (R und Python)** – zur Filterung, Gruppierung und Berechnung statistischer Kennzahlen

---

## Installation und Ausführung

### Python

1. Python 3.10 oder höher installieren
2. Abhängigkeiten installieren:

```
pip install -r requirements.txt
```

3. Testdaten erzeugen:
```
python daten-generator/schüler.py
...
```

4. Analyse starten:
```
python daten-scripten/allgemeinbildenden-schulen.py
...
```

### R
1. R Version 4.x installieren
2. Benötigte Pakete installieren:

```
install.packages("readxl")
install.packages("dplyr")
```

3. Skripte ausführen:

```
Rscript r-daten-scripten/allgemeinbildenden-schulen.R
...
```

## Hinweise
Alle Daten sind synthetisch erzeugt und enthalten keine echten oder personenbezogenen Informationen.
Die Auswertungen orientieren sich an typischen Berichtsanforderungen im Schulbereich.
Der Landkreis-Code ist in konstanten.R festgelegt.