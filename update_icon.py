#!/usr/bin/env python3
import os
import shutil
from PIL import Image

# Rozmiary DPI
dpi_sizes = {
    'mdpi': 48,
    'hdpi': 72,
    'xhdpi': 96,
    'xxhdpi': 144,
    'xxxhdpi': 192
}

repo_root = os.path.dirname(os.path.abspath(__file__))
base_path = os.path.join(repo_root, 'app', 'android', 'app', 'src', 'main', 'res')
source_file = os.path.join(repo_root, 'app', 'assets', 'Ikona.png')

# Załaduj źródłowy obraz
source_img = Image.open(source_file)

# Dla każdego DPI
for dpi, size in dpi_sizes.items():
    # Skaluj obraz do odpowiedniego rozmiaru
    resized_img = source_img.resize((size, size), Image.Resampling.LANCZOS)
    
    # Directory
    dir_path = os.path.join(base_path, f'mipmap-{dpi}')
    os.makedirs(dir_path, exist_ok=True)
    
    # Zapisz
    output_path = os.path.join(dir_path, 'ic_launcher.png')
    resized_img.save(output_path)
    
    print(f"✓ Scaled and copied to {dpi} ({size}x{size})")

print("\nIkony aplikacji zaktualizowane!")
