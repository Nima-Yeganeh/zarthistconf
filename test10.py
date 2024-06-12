import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost

url = 'http://arthist.ir/xmlrpc.php'
username = 'newuser'
password = 'newuser'
client = Client(url, username, password)
post = WordPressPost()
post.title = 'Title 1239'
post.content = ""
with open('zxyz', 'r') as file:
    post_content = file.read()
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

