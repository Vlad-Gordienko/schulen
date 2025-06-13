from generator import generate_table

field_config = {
    'un_Stichtag': ['01-Nov-24'],
    'un_Erhebung': ['Statistik'],
    'un_Status': ['freigegeben'],
    'un_Schuljahr': ['2024/2025'],
    'un_DienststellenNr': [5172, 6289, 6079],
    'un_Standort': [0],
    'un_Fach': [
        'CH', 'F', 'LF07', 'POWI', 'PHIL', 'GTAB',
        'PH', 'WPU', 'RKA', 'ETHI', 'REV'
    ],
    'un_Fach_lang': [
        'Chemie', 'Französisch', 'Lernfeld 07', 'Politik und Wirtschaft', 'Philosophie',
        'Ganztagsangebot', 'Physik', 'Wahlpflichtunterricht',
        'Religion - katholisch', 'Ethik', 'Religion - evangelisch'
    ],
    'un_Schulform': ['GYM', 'BST', 'R'],
    'un_Schulform_lang': [
        'Gymnasium / Gymnasialzweig',
        'Berufsschule - Teilzeit',
        'Realschule/ Realschulzweig'
    ],
    'un_Kursart': ['P', 'A', 'W'],
    'un_Kursart_lang': ['Pflichtkurs', 'Arbeitsgemeinschaft', 'Wahlpflichtkurs'],
    'un_Stufe': [6, 7, 9, 10, 11, 12],
    'un_AnzahlSchueler': [2, 6, 10, 15, 17, 19, 21, 22, 25, 49],
    'un_AnzahlSchuelerExtern': [''],
    'un_Stunden': [2, 3, 4]
}

if __name__ == '__main__':
    generate_table(field_config, num_rows=4000, output_file='Unterrichte.xlsx')
