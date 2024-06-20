from pytgpt.imager import Imager
import sys

if len(sys.argv) != 2:
    print("Usage: python script.py <input>")
else:
    input_arg = sys.argv[1]
    print(f"Input received: {input_arg}")

img = Imager()
generated_images = img.generate(prompt=f"{input_arg}", amount=1, stream=True)
img.save(generated_images)

