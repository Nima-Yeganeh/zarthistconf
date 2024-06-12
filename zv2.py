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
    # print(f"Section {i} in file >>\n{formatted_section}\n")
    url = 'http://arthist.ir/xmlrpc.php'
    username = 'newuser'
    password = 'newuser'
    client = Client(url, username, password)
    post = WordPressPost()
    post.content = formatted_section
    post_content = formatted_section
    title_pattern = r'<title>(.*?)<\/title>'
    match = re.search(title_pattern, post_content)
    post.title = match.group(1)
    tags = ['tag1', 'tag2', 'tag3']
    keywords_pattern = r'<meta\s+name="keywords"\s+content="(.*?)"\s*\/?>'
    match = re.search(keywords_pattern, post_content)
    keywords = match.group(1)
    tags = [tag.strip() for tag in keywords.split(',')]
    post.terms_names = {
        'post_tag': tags,
        'category': ['ARTHIST']
    }
    post.post_status = 'publish'
    post_id = client.call(NewPost(post))
    print('New post created with ID:', post_id)
