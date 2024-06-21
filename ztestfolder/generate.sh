#!/bin/bash

# Check if the input file exists
if [[ ! -f "zztopics.txt" ]]; then
  echo "File zztopics.txt not found!"
  exit 1
fi

# Read the file line by line
while IFS= read -r linetext
do
  # Execute the command with the line text as an argument
  echo "********************"
  echo "Generating..."
  echo $linetext
  bash post_prompt_plus_image_plus_mp3_v2.sh "$linetext"
  echo "Next..."
done < "zztopics.txt"
