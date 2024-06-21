#!/bin/bash
while IFS= read -r linetext
do
  echo "********************"
  echo "Generating..."
  echo $linetext
  python3 ztest.py
  
  input=$linetext

  echo "Info in English..."

  echo "" > zprompt.txt
  # python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt
  python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt 2>/dev/null || true

  echo "Done!"
  echo "Next..."
done < "zztopics.txt"

