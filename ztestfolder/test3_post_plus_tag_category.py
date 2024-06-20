import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost
from wordpress_xmlrpc.methods.media import UploadFile
import random

url = 'http://arthist.ir/xmlrpc.php'
username = 'adrian'
password = 'P@ssw0rd'
client = Client(url, username, password)
post = WordPressPost()

words = ['Apple', 'Banana', 'Orange', 'Mango', 'Pineapple', 'Grape', 'Cherry', 'Strawberry', 'Blueberry', 'Watermelon']
random_title = ' '.join(random.sample(words, k=random.randint(2, 4)))  # Join 2 to 4 random words
post.title = random_title
post.content = ""

post_content = ""
mp3_file_path = 'zz.mp3'
# Step 1: Upload the MP3 file to the media library
with open(mp3_file_path, 'rb') as mp3_file:
    data = {
        'name': mp3_file_path.split('/')[-1],
        'type': 'audio/mpeg',  # mimetype
    }
    data['bits'] = mp3_file.read()
    response = client.call(UploadFile(data))
# Get the URL of the uploaded MP3 file
mp3_url = response['url']
# Step 2: Embed the MP3 file URL in the post content
audio_html = f'<audio controls><source src="{mp3_url}" type="audio/mpeg">Your browser does not support the audio element.</audio>'
post_content += f'\n\n{audio_html}'
post.content += post_content

# post.content = 'Your post description'
file_path = 'zprompt.txt'
# post_content = ''
try:
    with open(file_path, 'r') as file:
        post_content = file.read()
        # Optionally, you can strip any extra whitespace including newlines
        post_content = post_content.strip()
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
post.content += post_content

tags = ['tag1', 'tag2', 'tag3']
post.terms_names = {
    'post_tag': tags
}

category = ['category_name']
post.terms_names = {
    'category': category
}

post.post_status = 'publish'
post_id = client.call(NewPost(post))
print('New post created with ID:', post_id)

