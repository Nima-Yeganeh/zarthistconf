import re

# Read the HTML file
with open("htmltest", "r") as file:
    html_content = file.read()

# Define the regex pattern to match HTML sections
pattern = r"<html[^>]*>(.*?)</html>"
sections = re.findall(pattern, html_content, re.DOTALL)

# Iterate through sections
for i, section in enumerate(sections, start=1):
    # Formatted section with doctype and html tag
    formatted_section = f"<!DOCTYPE html>\n<html lang=\"en\">\n{section.strip()}\n</html>"
    
    # Print section number and content
    print(f"Section {i} in file >>\n{formatted_section}\n")

