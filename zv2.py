import re
import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost

with open("zxyz", "r") as file:
    html_content = file.read()
pattern = r"<html[^>]*>(.*?)</html>"
sections = re.findall(pattern, html_content, re.DOTALL)
for i, section in enumerate(sections, start=1):
    formatted_section = f"<!DOCTYPE html>\n<html lang=\"en\">\n{section.strip()}\n</html>" 
    print(f"Section {i} in file >>\n{formatted_section}\n")
