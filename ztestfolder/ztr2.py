from gtts import gTTS
import time
import datetime
import random
import os
import re
import sys

textfile = sys.argv[1]
mp3filename = sys.argv[2]
langtype = sys.argv[3]
languages = ["fr", "de", "it", "es", "sv", "no", "fi", "hu", "da"]
file_path = textfile
text = ''
try:
    with open(file_path, 'r') as file:
        text = file.read()
        text = text.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
except Exception as e:
    print(f"An error occurred: {e}")
# print(text)
# text = ""
output_file = mp3filename
lang = langtype
tts = gTTS(text, lang=lang, slow=False)
tts.save(output_file)
