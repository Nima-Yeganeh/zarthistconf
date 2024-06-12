from bs4 import BeautifulSoup

# Read the HTML file
with open("your_html_file.html", "r") as file:
    html_content = file.read()

# Parse HTML using BeautifulSoup
soup = BeautifulSoup(html_content, "html.parser")

# Find all sections
sections = soup.find_all("html")

# Iterate through sections
for i, section in enumerate(sections, start=1):
    # Get section content
    section_content = section.prettify()
    
    # Print section number and content
    print(f"Section {i} in file >>\n{section_content}\n")
