from wordpress_xmlrpc import Client, WordPressPost
from wordpress_xmlrpc.methods.posts import NewPost

wp_url = 'http://domain.local/xmlrpc.php'
wp_username = 'admin'
wp_password = 'P@ssw0rd'
client = Client(wp_url, wp_username, wp_password)
post = WordPressPost()
post.title = 'Your post title'
post.content = 'Your post content'
post.post_status = 'publish'
client.call(NewPost(post))
