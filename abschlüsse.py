from generator import generate_table

field_config = {
   'Stichtag': ['01-Jul-24'],
   'Erhebung': ['Statistik'],
   'Status': ['freigegeben'],
   'Schuljahr': ['2023/2024'],
   'DienststellenNr': [6289, 6274, 6124, 3662, 6320],
   'Standort': [0],
   'Geburtsdatum': [
       '01-Dez-02', '01-Dez-01', '01-Feb-09', '01-Jul-08',
       '01-Apr-08', '01-Okt-06', '01-Nov-00', '01-Mrz-89'
   ],
   'Geschlecht': ['M', 'W'],
   'WohngemeindeKnz': [
       '09990000000', '09990000001', '09990000002',
       '09990000003', '09990000004'
   ],
   'WohngemeindeName': [
       'Karben', 'Altenstadt', 'Niddatal',
       'Münzenberg', 'Friedberg'
   ],
   'Staatsangehoerigkeit': ['D', 'PL', 'PAK', 'MA', 'TR'],
   'Staatsangehoerigkeit_lang': [
       'deutsch', 'polnisch', 'pakistanisch', 'marokkanisch', 'türkisch'
   ],
   'ZweiteStaatsangehoerigkeit': ['-'],
   'ZweiteStaatsangehoerigkeit_lang': ['kein Eintrag'],
   'ZuzugsjahrBRD': ['', '2010', '2017', '2019'],
   'Geburtsland': ['D', 'PL', 'PAK', 'MA', 'TR'],
   'Geburtsland_lang': [
       'Deutschland', 'Polen', 'Pakistan', 'Marokko', 'Türkei'
   ],
   'VerkehrsspracheInFamilie': ['de', 'pl', 'ur', 'ar', 'tr'],
   'VerkehrsspracheInFamilie_lang': [
       'Deutsch', 'Polnisch', 'Urdu', 'Arabisch', 'Türkisch'
   ],
   'Stufe': [9, 11, 12],
   'Schulform': ['BST', 'BSBT', 'GYM', 'H', 'R'],
   'Schulform_lang': [
       'Berufsschule - Teilzeit',
       'Berufsschule - Blockform',
       'Gymnasium / Gymnasialzweig',
       'Hauptschule/ Hauptschulzweig',
       'Realschule/ Realschulzweig'
   ],
   'Fachrichtung': ['SONS', '-'],
   'Fachrichtung_lang': [
       'Berufe ohne Berufsfeldzuordnung',
       'kein Eintrag'
   ],
   'Schwerpunkt': ['-'],
   'Schwerpunkt_lang': ['kein Eintrag'],
   'Beruf': [
       '1111111', '2222222', '3333333', '4444444', '-1'
   ],
   'Beruf_lang': [
       'Maler und Lackierer - FR: Gestaltung und Instandhaltung (VO 2021)',
       'Verkäufer (VO2017)',
       'Automobilkaufmann (VO2017)',
       'Anlagenmechaniker für Sanitär-, Heizungs- und Klimatechnik (VO2016)',
       'kein Eintrag'
   ],
   'BetriebsortGemeindeKnz': [
       '06440017000', '06440015000'
   ],
   'BetriebsortGemeindeName': [
       'Niddatal', 'Münzenberg'
   ],
   'Foerderart': ['-'],
   'Foerderart_lang': ['kein Eintrag'],
   'Abschluss': ['ABS', 'HA', 'HA-G', 'OHA'],
   'Abschluss_lang': [
       'Abschluss',
       'Gleichstellung mit Hauptschulabschluss',
       'Hauptschulabschluss',
       'Ohne Hauptschulabschluss'
   ]
}

if __name__ == '__main__':
    generate_table(field_config, num_rows=10, output_file='Abschlüsse.xlsx')
