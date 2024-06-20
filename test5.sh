#!/bin/bash

# Command to get the list of files
file_list=$(ls -anp | grep "ACHAEMENIAN PERSIAN ART" | grep jpeg)

# Read each line and process the filenames
while IFS= read -r line; do
    # Extract the filename from the line
    filename=$(echo "$line" | awk '{for (i=9; i<=NF; i++) printf $i " "; print ""}' | sed 's/ *$//')
    echo "$filename"
done <<< "$file_list"

