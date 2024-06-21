import os
import random
import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.media import UploadFile
from wordpress_xmlrpc.methods.posts import NewPost
from wordpress_xmlrpc.compat import xmlrpc_client
import sys

title = sys.argv[1]
zimgfile = sys.argv[2]
zmp3file = sys.argv[3]
ztxtfile = sys.argv[4]
zmp3file2 = sys.argv[5]
ztxtfile2 = sys.argv[6]
zwptags = sys.argv[7]
url = sys.argv[8]
username = sys.argv[9]
password = sys.argv[10]
htmlfile = sys.argv[11]

client = Client(url, username, password)
post = WordPressPost()
post.title = title
post.content = ""
post_content = ""

# French MP3
mp3_file_path = zmp3file
with open(mp3_file_path, 'rb') as mp3_file:
    data = {
        'name': mp3_file_path.split('/')[-1],
        'type': 'audio/mpeg',
    }
    data['bits'] = mp3_file.read()
    response = client.call(UploadFile(data))
mp3_url = response['url']
audio_html = f'<audio controls><source src="{mp3_url}" type="audio/mpeg"></audio>'
post.content += f'\n\n{audio_html}'
post.content += f'\n'
post.content += f'\n'
# post.content += post_content

#French Text
file_path = ztxtfile
try:
    with open(file_path, 'r') as file:
        post_content = file.read()
        post_content = post_content.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
post.content += post_content
post.content += f'\n'
post.content += f'\n'

#English Section
post.content += "Translation and Audio File in English:"
post.content += f'\n'

#English MP3
mp3_file_path = zmp3file2
with open(mp3_file_path, 'rb') as mp3_file:
    data = {
        'name': mp3_file_path.split('/')[-1],
        'type': 'audio/mpeg',
    }
    data['bits'] = mp3_file.read()
    response = client.call(UploadFile(data))
mp3_url = response['url']
audio_html = f'<audio controls><source src="{mp3_url}" type="audio/mpeg"></audio>'
post.content += f'\n\n{audio_html}'
post.content += f'\n'
post.content += f'\n'
# post.content += post_content

#English Text
file_path = ztxtfile2
try:
    with open(file_path, 'r') as file:
        post_content = file.read()
        post_content = post_content.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
post.content += post_content
post.content += f'\n'
post.content += f'\n'

# HTML file path
html_file_path = htmlfile
try:
    with open(html_file_path, 'r') as html_file:
        html_content = html_file.read().strip()
except FileNotFoundError:
    print(f"Error: File '{html_file_path}' not found.")
else:
    post.content += f'\n\n{html_content}\n\n'
post.content += f'\n'
post.content += f'\n'


#WP_TAGS
category = ["Histoire de l'art | History of Art"]
tags = []
with open(zwptags, 'r') as file:
    for line in file:
        tags.append(line.strip())
# tags = ['tag1', 'tag2', 'tag3']
post.terms_names = {
    'post_tag': tags,
    'category': category
}
print(tags)

image_path = zimgfile
with open(image_path, 'rb') as img:
    data = img.read()
zimgfile = os.path.basename(image_path)
file = {'name': zimgfile, 'type': 'image/jpeg', 'bits': xmlrpc_client.Binary(data)}
response = client.call(UploadFile(file))

post.thumbnail = response['id']
post.post_status = 'publish'
post_id = client.call(NewPost(post))
print('New post created with ID:', post_id)

