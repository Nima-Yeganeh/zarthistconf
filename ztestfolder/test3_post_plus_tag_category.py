import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost
import random

url = 'http://arthist.ir/xmlrpc.php'
username = 'adrian'
password = 'P@ssw0rd'
client = Client(url, username, password)
post = WordPressPost()

words = ['Apple', 'Banana', 'Orange', 'Mango', 'Pineapple', 'Grape', 'Cherry', 'Strawberry', 'Blueberry', 'Watermelon']
random_title = ' '.join(random.sample(words, k=random.randint(2, 4)))  # Join 2 to 4 random words
post.title = random_title

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

category = ['category_name']
post.terms_names = {
    'category': category
}

post.post_status = 'publish'
post_id = client.call(NewPost(post))
print('New post created with ID:', post_id)

