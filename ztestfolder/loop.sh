#!/bin/bash

# Read the file and store each line in an array
inputs=()
while IFS= read -r line; do
    inputs+=("$line")
done < zztopics.txt

# Loop through the array and run the command for each input
for input in "${inputs[@]}"; do
    # Run the command and ignore errors
    python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt 2>/dev/null || true
    
    # Add any other commands you want to run within the loop
    echo "Processed input: $input"
done
