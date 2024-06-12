import re

# Read the HTML file
with open("htmltest", "r") as file:
    html_content = file.read()

# Define the regex pattern to match HTML sections
pattern = r"<html[^>]*>(.*?)</html>"
sections = re.findall(pattern, html_content, re.DOTALL)

# Iterate through sections
for i, section in enumerate(sections, start=1):
    # Print section number and content
    print(f"Section {i} in file >>\n{section.strip()}\n")
