#!/bin/bash
while IFS= read -r linetext
do
  echo "********************"
  echo "Generating..."
  echo $linetext
  python3 ztest.py
  
  input=$linetext

  echo "Info in English..."


  echo "Done!"
  echo "Next..."
done < "zztopics.txt"

