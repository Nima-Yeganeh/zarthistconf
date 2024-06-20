import os
import random
import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.media import UploadFile
from wordpress_xmlrpc.methods.posts import NewPost
from wordpress_xmlrpc.compat import xmlrpc_client
import sys

if len(sys.argv) != 3:
    print("Usage: python script.py <title> <filename>")
title = sys.argv[1]
filename = sys.argv[2]
# print(f'Title: {title}')
# print(f'Filename: {filename}')

url = 'http://arthist.ir/xmlrpc.php'
username = 'adrian'
password = 'P@ssw0rd'
client = Client(url, username, password)
post = WordPressPost()
post.title = title
post.content = 'Your post description'

words = ['Apple', 'Banana', 'Orange', 'Mango', 'Pineapple', 'Grape', 'Cherry', 'Strawberry', 'Blueberry', 'Watermelon']
random_title = ' '.join(random.sample(words, k=random.randint(2, 4)))  # Join 2 to 4 random words
# post.title = random_title

post.content = 'Your post description'
file_path = 'zprompt.txt'
post_content = ''
try:
    with open(file_path, 'r') as file:
        post_content = file.read()
        # Optionally, you can strip any extra whitespace including newlines
        post_content = post_content.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
post.content = post_content

tags = ['tag1', 'tag2', 'tag3']
post.terms_names = {
    'post_tag': tags
}

category = ['Test Category 3']
post.terms_names = {
    'category': category
}

image_path = filename
with open(image_path, 'rb') as img:
    data = img.read()
filename = os.path.basename(image_path)
file = {'name': filename, 'type': 'image/jpeg', 'bits': xmlrpc_client.Binary(data)}
response = client.call(UploadFile(file))

post.thumbnail = response['id']
post.post_status = 'publish'
post_id = client.call(NewPost(post))
print('New post created with ID:', post_id)

