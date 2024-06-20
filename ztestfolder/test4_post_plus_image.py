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

url = 'http://arthist.ir/xmlrpc.php'
username = 'adrian'
password = 'P@ssw0rd'
client = Client(url, username, password)
post = WordPressPost()
post.title = title
post.content = ""

post_content = ""
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
post_content += f'\n\n{audio_html}'
post_content += f'\n'
post_content += f'\n'
post.content += post_content

file_path = ztxtfile
try:
    with open(file_path, 'r') as file:
        post_content = file.read()
        post_content = post_content.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
post.content += post_content

tags = ['tag1', 'tag2', 'tag3']
post.terms_names = {
    'post_tag': tags
}

category = ['Test Category 3']
post.terms_names = {
    'category': category
}

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

