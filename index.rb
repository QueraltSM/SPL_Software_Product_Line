require_relative 'semantic_model'
require_relative 'authenticator'
require './frontend'
require 'sinatra'
require 'date'

users_semantic_model = create_semantic_model('./DSL/user.rb')
users_reader = UsersReader.new
content_item_semantic_model = create_semantic_model('./DSL/item.rb')
items_reader = ItemsReader.new
comment_semantic_model = create_semantic_model('./DSL/comment.rb')
comments_reader = CommentsReader.new
authentication_form = Authenticator.new

$items_file = './Data/items.json'

# Starting point
get '/' do
  redirect '/login'
end

# Login form
get '/login' do
  authentication_form = Authenticator.new
  authentication_form.form(action: '/login', method: 'post') do
    input 'email', 'text', placeholder: 'Email'
    input 'password', 'password', placeholder: 'Password'
 end
  authentication_form.generate_form('login')
end

# Manages login request
post '/login' do
  email = params[:email]
  password = params[:password]
  if users_reader.user_exists?(email, password)
    users_reader.save_user(email)
    redirect "/index"
  else
    authentication_form.generate_form("login", "User does not exist or the password is incorrect.")
  end
end

# Signup form
get '/signup' do
  authentication_form = Authenticator.new
  authentication_form.form(action: '/singup', method: 'post') do
    input 'name', 'text', placeholder: 'Name'
    input 'email', 'text', placeholder: 'Email'
    input 'password', 'password', placeholder: 'Password'
    input 'password again', 'password', placeholder: 'Confirm password'
 end
  authentication_form.generate_form('signup')
end 

# Manages signup request
post '/signup' do
  name = params[:name]
  email = params[:email]
  password = params[:password]
  confirm_password = params['password again']
  if users_reader.email_exists?(email)
    authentication_form.generate_form("signup", "User already exists")
  elsif password != confirm_password
    authentication_form.generate_form("signup","Password do not match")
  else
    users_reader.create_user?(name, email,password)
    users_reader.save_user(email)
    redirect "/index"
  end
end

# Home page
get '/index' do
  html = <<~HTML
    <html>
      <body>
        #{Menu.generate_menu_html()}
        #{Frontend.new().home_header()}
        #{Frontend.new().home_body()}
      </body>
    </html>
  HTML
  html
end

# View of a particular content item
['get', 'post'].each do |method|
  send(method, '/:type/:name') do
    item_id = params['item_id'].nil? || params['item_id'].empty? ? $selected_item : params['item_id']
    if method == 'post' && !item_id.empty?
      $selected_item = item_id
    end
    html = "<html>
      <body>
        #{Menu.generate_menu_html()}
        #{items_reader.print_item($selected_item)}"
        html += "#{params['type'] != 'Events' ? items_reader.rate_item($selected_item) : ''}"
        html += "#{params['type'] != 'Events' ? comments_reader.print_comments($selected_item, users_reader) : ''}"
        html += "</body>
        </html>"
      html
  end
end

# Creation form
get '/create' do
  return "<html>
      <body>
        #{Menu.generate_menu_html()}
        #{Frontend.new().creation_item_form_styles}
        #{Frontend.new().creation_item_form}
        #{Frontend.new().creation_item_form_scripts}
      </body>
    </html>"
end

# Method to process the Creation of content
put '/create_item' do
  new_content = {
    "id": SecureRandom.uuid,
    "title": params['title'],
    "source": params['source'],
    "author": $user_id,
    "description": params['description'],
    "date": params['date'],
    "pubdate": Time.now.strftime("%Y-%m-%dT%H:%M:%S"),
    "media_url": params['media_url'],
    "rating": 0,
    "type": params['type']
  }
  content = items_reader.readFile($items_file)
  content << new_content
  items_reader.writeFile($items_file, content)
  redirect "#{params['type']}"
end

# Method that updates rating
post '/update_rating' do 
  content_items = items_reader.readFile($items_file)
  index_to_update = content_items.find_index { |item| item["id"] == params['item_id'] }
  current_rating = content_items[index_to_update]["rating"]
  new_rating = params['rating'].to_i 
  if current_rating == 0
    average_rating = new_rating
  else
    average_rating = (current_rating + new_rating) / 2
  end
  content_items[index_to_update]["rating"] = average_rating
  items_reader.writeFile($items_file, content_items)
  redirect "/#{content_items[index_to_update]["type"] }/#{content_items[index_to_update]["title"].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase}"
end

# Method that handles submission of comments
post '/submit_comment' do
  new_comment = {
    "id": SecureRandom.uuid,
    "user_id": params['comment_user_id'],
    "item_id": params['item_id'],
    "text": params['comment_text'],
    "pubdate": DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  }
  comments = comments_reader.readFile('./Data/comments.json') << new_comment
  comments_reader.writeFile('./Data/comments.json', comments)
  redirect "/#{items_reader.readFile($items_file).find { |item| item['id'] == params['item_id'] }['type']}/#{items_reader.readFile($items_file).find { |item| item['id'] == params['item_id'] }['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase}"
end

 # Update comment
 post '/update_comment' do
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_update = comments.find_index { |comment| comment["id"] == params['comment_id'] }
  comments[index_to_update]["text"] = params['updated_text']
  comments[index_to_update]["pubdate"] = DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  comments_reader.writeFile('./Data/comments.json', comments)
  content_items = items_reader.readFile($items_file)
  selected_item = content_items.find { |item| item["id"] == $selected_item }
  title_with_hyphens = selected_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{selected_item['type']}/#{title_with_hyphens}"
end

# Delete a comment
post '/delete_comment' do
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_delete = comments.find_index { |comment| comment["id"] == params['comment_id'] }
  comments.delete_at(index_to_delete)
  comments_reader.writeFile('./Data/comments.json', comments)
  content_items = items_reader.readFile($items_file)
  selected_item = content_items.find { |item| item["id"] == $selected_item }
  title_with_hyphens = selected_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{selected_item['type']}/#{title_with_hyphens}"
end

# Generate table for edition of content
get '/edit' do
  return "<html>
      <body>
        #{Menu.generate_menu_html()}
        #{items_reader.item_administration_form}
      </body>
    </html>"
end

# Generate edition form of particular content
post '/edit' do
  $selected_item = params['item_id']
  html = "<html>
    <body>
      #{Menu.generate_menu_html()}
      #{items_reader.generate_edition_form(params['item_id'])}
    </body>
  </html>"
  html
end

# Method handles request to edit a specific item of content
put '/edit_item' do
  content = items_reader.readFile($items_file)
  index_to_edit = content.find_index { |item| item["id"] == params[:item_id] }
  content[index_to_edit]["title"] = params['title']
  content[index_to_edit]["source"] = params['source']
  content[index_to_edit]["description"] = params['description']
  content[index_to_edit]["date"] = params['date']
  content[index_to_edit]["media_url"] = params['media_url']
  items_reader.writeFile($items_file, content)
  title_with_hyphens = content[index_to_edit]["title"].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{content[index_to_edit]["type"]}/#{title_with_hyphens}"
end

# Method that delete a content
post '/delete' do
  items = items_reader.readFile($items_file)
  index_to_delete = items.find_index { |item| item["id"] == params['item_id'] }
  items.delete_at(index_to_delete)
  items_reader.writeFile($items_file, items)
  redirect "/#{params['page']}"
end

# View multimedia content page based on type
get '/:type' do
  "<html>
    <body>
      #{Menu.generate_menu_html()}
      #{items_reader.print_items(params['type'].capitalize, params['sb'] || 'date')}
    </body>
  </html>"
end

# Method that generates HTML code to embed a video
def generate_video_embed(url)
  if url.include?('youtube.com') || url.include?('youtu.be')
    video_id = extract_youtube_video_id(url)
  return "<div style='position:relative; padding-bottom:56.25%; height:0; overflow:hidden; max-width:100%;'><iframe width='100%' height='100%' src='https://www.youtube.com/embed/#{video_id}' style='position:absolute; top:0; left:0; width:100%; height:100%;' frameborder='0' allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></div>"
 else
    return "<p>Video not supported</p>"
  end
end

# Method that retrieves the unique video ID from a YouTube video URL
def extract_youtube_video_id(url)
  video_id = ''
  if url.include?('youtube.com')
    video_id = url.split('v=')[1]
    video_id = video_id.split('&')[0] if video_id.include?('&')
  elsif url.include?('youtu.be')
    video_id = url.split('/')[-1]
  end
  video_id
end