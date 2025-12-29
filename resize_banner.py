from PIL import Image
import os
import sys

# Chemins
source_path = r"C:/Users/Afroculture/.gemini/antigravity/brain/9276f7ee-77d0-441d-8d66-1ffa0e13b1a3/uploaded_image_1766845122777.png"
dest_path = r"c:/fluuter_p/mytvs/android/app/src/main/res/drawable-xhdpi/tv_banner.png"

# Taille cible
target_size = (320, 180)

try:
    print(f"Opening image from: {source_path}")
    if not os.path.exists(source_path):
        print("Error: Source file does not exist.")
        sys.exit(1)

    with Image.open(source_path) as img:
        # Convert to RGB to ensure compatibility (remove alpha if causing issues, or keep RGBA)
        if img.mode != 'RGB':
             img = img.convert('RGB')
        
        # Resize with high quality resampling
        print(f"Resizing to {target_size}...")
        img_resized = img.resize(target_size, Image.Resampling.LANCZOS)
        
        # Save
        print(f"Saving to: {dest_path}")
        img_resized.save(dest_path, "PNG")
        print("Success!")

except Exception as e:
    print(f"An error occurred: {e}")
    sys.exit(1)
