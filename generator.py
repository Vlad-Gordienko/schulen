import os
import random
import pandas as pd

def generate_row(field_config):
    return {field: random.choice(values) for field, values in field_config.items()}

def generate_table(field_config, num_rows=40, output_file='table.xlsx'):
    output_dir = 'daten'
    os.makedirs(output_dir, exist_ok=True)
    full_path = os.path.join(output_dir, output_file)

    rows = [generate_row(field_config) for _ in range(num_rows)]
    df = pd.DataFrame(rows)
    df.to_excel(full_path, index=False)
    print(f"File saved to: {full_path}")
