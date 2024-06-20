from pytgpt.imager import Imager
import sys
import time

def download_image(input_arg):
    img = Imager()
    try:
        generated_images = img.generate(prompt=input_arg, amount=1, stream=True)
        img.save(generated_images)
    except Exception as e:
        print(f"Error occurred: {e}")
        print("Retrying in 5 seconds...")
        time.sleep(5)
        download_image(input_arg)

if len(sys.argv) != 2:
    print("Usage: python script.py <input>")
else:
    input_arg = sys.argv[1]
    print(f"Input received: {input_arg}")
    download_image(input_arg)
