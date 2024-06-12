import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost

# WordPress credentials and URL
url = 'http://arthist.ir/xmlrpc.php'
username = 'newuser'
password = 'newuser'

# Create a client instance
client = Client(url, username, password)

# Create a new post instance
post = WordPressPost()
post.title = 'Title 1239'

# Read the content of the file and store it in post.content
with open('zxyz', 'r') as file:
    post_content = file.read()
post.content = post_content

# Add tags and categories
tags = ['tag1', 'tag2', 'tag3']
post.terms_names = {
    'post_tag': tags,
    'category': ['category_name']
}

# Set the post status
post.post_status = 'publish'

# Publish the post
post_id = client.call(NewPost(post))
print('New post created with ID:', post_id)
