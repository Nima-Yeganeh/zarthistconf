#!/bin/bash

# Function to encode text for URL
urlencode() {
  # Use Python 3 to URL encode the input
  python3 -c "import urllib.parse; import sys; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

# Function to format text into Google image search URL
format_google_image_url() {
  encoded_query=$(urlencode "$1")
  echo "https://www.google.com/search?client=firefox-b-d&sca_esv=cb83b5b107ff8c41&sca_upv=1&q=$encoded_query&udm=2"
}

# Main script starts here
# Check if a command line argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <search text>"
  exit 1
fi

# Get the search text from the command line argument
search_text="$1"

# Format the text into Google image search URL
google_image_url=$(format_google_image_url "$search_text")

echo "$google_image_url"
