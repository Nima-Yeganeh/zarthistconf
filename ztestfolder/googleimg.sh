#!/bin/bash

# Function to encode text for URL
urlencode() {
  # Use Python 3 to URL encode the input
  python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

# Function to format text into Google image search URL
format_google_image_url() {
  encoded_query=$(urlencode "$1")
  echo "https://www.google.com/search?client=firefox-b-d&sca_esv=cb83b5b107ff8c41&sca_upv=1&q=$encoded_query&udm"
}

# Main script starts here
# Prompt user for input
read -p "Enter text to search images for: " search_text

# Format the text into Google image search URL
google_image_url=$(format_google_image_url "$search_text")

echo "$google_image_url"

