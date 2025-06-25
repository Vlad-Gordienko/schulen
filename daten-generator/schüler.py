from generator import generate_table

field_config = {
    'Stichtag': ['01.11.2024'],
    'Erhebung': ['Statistik'],
    'Status': ['freigegeben'],
    'Schuljahr': ['2024/2025'],
    'Geburtsdatum': [
        '02.07.2009', '03.09.2006', '04.09.2010', '04.12.2009', '07.07.2005',
        '08.11.2008', '11.09.2008', '12.06.2010', '13.01.2005', '14.03.2005',
        '14.08.2006', '14.11.2005', '15.10.2007', '16.08.2007', '17.03.2006',
        '17.09.2007', '18.06.2008', '20.12.2008', '21.09.2010', '22.05.2009',
        '22.07.2008', '23.07.2005', '24.05.2007', '29.08.2010', '30.07.2006'
    ],
    'Geschlecht': ['W', 'M'],
    'di_WohngemeindeKnz': [
        '644000000000', '644000000001', '644000000002',
    ],
    'di_WohngemeindeName': [
        'Friedberg-Ockstadt', 'Glauburg-Glauberg', 'Nidda-Ober-Schmitten', 'Nidda-Ober-Lais',
        'Bad Nauheim-Nieder-Mörlen', 'Friedberg', 'Bad Vilbel', 'Bad Nauheim-Nieder-Mörlen',
        'Friedberg (Hessen)', 'Altenstadt-Lindheim', 'Wölfersheim-Melbach', 'Ranstadt-Dauernheim',
        'Glauburg-Stockheim', 'Nidda-Fauerbach', 'Schotten-Einartshausen', 'Wölfersheim-Wohnbach',
        'Nidda-Harb', 'Karben-Okarben', 'Nidda', 'Bad Nauheim',
        'Reichelsheim-Beienheim', 'Nidda-Schwickartshausen'
    ],
    'Einschulungsdatum': [
        '13.08.2013', '02.09.2014', '09.09.2014', '04.09.2014', '20.08.2013',
        '01.08.2006', '01.08.2003', '31.08.2015', '23.08.2016', '21.08.2013',
        '12.09.2013'
    ],
    'Staatsangehoerigkeit': ['D', 'NL', 'USA'],
    'Staatsangehoerigkeit_lang': ['deutsch', 'niederländisch', 'amerikanisch'],
    'ZweiteStaatsangehoerigkeit': ['-', 'NL', 'USA'],
    'ZweiteStaatsangehoerigkeit_lang': ['kein Eintrag', 'niederländisch', 'amerikanisch'],
    'ZuzugsjahrBRD': ['-', '2011'],
    'Geburtsland': ['D', 'USA'],
    'Geburtsland_lang': ['Deutschland', 'Vereinigte Staaten (USA, Amerika)'],
    'VerkehrsspracheInFamilie': ['de', 'ua'],
    'VerkehrsspracheInFamilie_lang': ['Deutsch'],
    'Stammschule': [6289, 6106, 3445, 6310, 5175, 4758, 6256, 5176, 5174, 5160, 3417],
    'Stufe': [1, 9, 10, 11, 12],
    'Semester': [1],
    'Schulbesuchsjahr': [-1, 18],
    'Schulform': [
        'BGYM', 'GYM', 'MSMB', 'FOSA', 'BST', 'KRA', 'FSOV',
        'BFS2', 'BFSM', 'FSOP'
    ],
    'Schulform_lang': [
        'Berufliches Gymnasium',
        'Gymnasium / Gymnasialzweig',
        'Mittelstufenschule mittlerer Bildungsgang',
        'Fachoberschule Form A',
        'Berufsschule - Teilzeit',
        'FS - kranke Schülerinnen und Schüler',
        'Fachschule für Sozialwesen Vollzeit',
        'Zweijährige Berufsfachschule',
        'Zweijährige höhere Berufsfachschule',
        'Fachschule für Sozialwesen in praxisintegrierter Form'
    ],
    'Fachrichtung': [
        'TECH', 'WIVE', 'SONS', 'SOPÄ', 'WIRT', 'NHUT', 'ELET'
    ],
    'Fachrichtung_lang': [
        'Technik',
        'Wirtschaft und Verwaltung',
        'Berufe ohne Berufsfeldzuordnung',
        'Sozialpädagogik',
        'Wirtschaft',
        'Nachhaltige Umwelttechnik',
        'Elektrotechnik'
    ],
    'Schwerpunkt': [
        'BAUT', 'WIRT', 'FARA', 'SOLT', '-'
    ],
    'Schwerpunkt_lang': [
        'Bautechnik',
        'Wirtschaft',
        'Farbtechnik/Raumgestaltung',
        'Solartechnik',
        'kein Eintrag'
    ],
    'Beruf': [
        -1,
        7130202,
        6210204,
        2631211,
        8114202
    ],
    'Beruf_lang': [
        'kein Eintrag',
        'Industriekaufmann (VO 2024)',
        'Kaufmann im Einzelhandel (VO2017)',
        'Elektroniker für Geräte und Systeme',
        'Tiermedizinischer Fachangestellter'
    ],
    'BetriebsortGemeindeKnz': [
        '',
        '6440016000',
        '6535013000',
        '6535018000'
    ],
    'BetriebsortGemeindeName': [
        '',
        'Nidda',
        'Mücke',
        'Ulrichstein'
    ],
    'Foerderart': ['-'],
    'Foerderart_lang': ['kein Eintrag'],
    'VorhHjStufe': [
        8, 9, 10, 11, ''
    ],
    'VorhHjSchulform': [
        'BGYM', 'GYM', 'MSMB', 'KRA', 'BFS2', 'BFSM', 'R'
    ],
    'VorhHjSchulform_lang': [
        'Berufliches Gymnasium',
        'Gymnasium / Gymnasialzweig',
        'Mittelstufenschule mittlerer Bildungsgang',
        'FS - kranke Schülerinnen und Schüler',
        'Zweijährige Berufsfachschule',
        'Zweijährige Höhere Berufsfachschule',
        'Realschule/ Realschulzweig',
        'kein Eintrag'
    ],
    'Laufbahnempfehlung': [
        '-', 'GYM', 'H', 'GO'
    ]
}

if __name__ == '__main__':
    generate_table(field_config, num_rows=10000, output_file='Schüler.xlsx')
