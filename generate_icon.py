#!/usr/bin/env python3
import os
from PIL import Image, ImageDraw

# Rozmiary dla Androida
sizes = {
    'mdpi': 48,
    'hdpi': 72,
    'xhdpi': 96,
    'xxhdpi': 144,
    'xxxhdpi': 192
}

repo_root = os.path.dirname(os.path.abspath(__file__))
base_path = os.path.join(repo_root, 'app', 'android', 'app', 'src', 'main', 'res')

for dpi, size in sizes.items():
    # Tworzymy obrazek z ciemnym tłem
    img = Image.new('RGB', (size, size), color=(21, 21, 21))  # #151515
    draw = ImageDraw.Draw(img)
    
    # Rysujemy M w kolorze #e63416
    text = 'M'
    text_color = (230, 52, 22)  # #e63416
    
    # Przybliżamy wielkość fontu
    font_size = int(size * 0.6)
    
    # Tekst w środku - litera M
    # Bez fontu, używamy naiwnego rysowania
    x = size // 4
    y = size // 4
    
    draw.text((x, y), text, fill=text_color)
    
    # Zapisujemy
    dir_path = os.path.join(base_path, f'mipmap-{dpi}')
    os.makedirs(dir_path, exist_ok=True)
    output_path = os.path.join(dir_path, 'ic_launcher.png')
    img.save(output_path)
    
    print(f"✓ Created {dpi} ({size}x{size}) at {output_path}")

print("\nIkony aplikacji wygenerowane pomyślnie!")
