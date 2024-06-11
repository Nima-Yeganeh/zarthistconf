import wordpress_xmlrpc
from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost

url = 'http://domain.local/xmlrpc.php'
username = 'admin'
password = 'P@ssw0rd'
client = Client(url, username, password)
post = WordPressPost()
post.title = 'Your post title 2'
post.content = 'Your post description'
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
