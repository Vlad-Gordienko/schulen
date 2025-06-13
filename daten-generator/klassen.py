from generator import generate_table

field_config = {
    'kl_id': [
        9794001, 9794002, 9794003, 9794004, 9794005, 9794006, 9794007,
        9794008, 9794009, 9794010, 9794011, 9794012, 9794013, 9794014,
        9794015, 9794016, 9794017, 9794018, 9794019, 9794020, 9794021, 9794022
    ],
    'kl_Stichtag': ['01-Nov-24'],
    'kl_Erhebung': ['Statistik'],
    'kl_Status': ['freigegeben'],
    'kl_Schuljahr': ['2024/2025'],
    'kl_DienststellenNr': [3677, 6274],
    'kl_Standort': [0],
    'kl_Name': [
        '05a', '05b', '06a', '06b', '07a', '07b', '08a', '08b',
        'INT1', 'INT2', 'VKL1', 'VKL2', '10A', '10B', '11B1',
        '11B2', '11C1', '11D1', '12A', '12B', '12C', '12D'
    ],
    'kl_Stufe': [0, 1, 2, 3, 4, 11, 12],
    'kl_AnzahlSchueler': [
        21, 14, 16, 17, 11, 13, 15, 22, 23, 18, 24, 12, 27, 17, 13
    ],
    'kl_AnzahlExterne': [0],
}

if __name__ == '__main__':
    generate_table(field_config, num_rows=400, output_file='Klassen.xlsx')
