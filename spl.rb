require_relative 'semantic_model'
require_relative 'authenticator'
require 'sinatra'
require 'date'

# Inicialización de modelos y lectores
users_semantic_model = create_semantic_model('./DSL/user_dsl.rb')
users_reader = UsersReader.new
content_item_semantic_model = create_semantic_model('./DSL/content_item_dsl.rb')
content_item_reader = ContentItemsReader.new
comment_semantic_model = create_semantic_model('./DSL/comment_dsl.rb')
comments_reader = CommentsReader.new
events_semantic_model = create_semantic_model('./DSL/event_dsl.rb')
events_reader = EventsReader.new
login_form_dsl = AuthenticatorDSL.new
signup_form_dsl = AuthenticatorDSL.new
#---------------------------------------

# Rutas de inicio de sesión
get '/' do
  login_form_dsl.form(action: '/login', method: 'post') do
    input 'email', 'text', placeholder: 'Email'
    input 'password', 'password', placeholder: 'Password'
 end
  login_form_dsl.generate_form('login')
end

post '/login' do
  email = params[:email]
  password = params[:password]
  if users_reader.user_exists?(email, password)
    users_reader.save_user(email)
    redirect "/index"
  else
    login_form_dsl.generate_form("login", "User does not exist or the password is incorrect.")
  end
end
#---------------------------------------

# Rutas de registro de usuarios
get '/signup' do
  signup_form_dsl.form(action: '/singup', method: 'post') do
    input 'name', 'text', placeholder: 'Name'
    input 'email', 'text', placeholder: 'Email'
    input 'password', 'password', placeholder: 'Password'
    input 'password again', 'password', placeholder: 'Confirm password'
 end
  signup_form_dsl.generate_form('signup')
end 

post '/signup' do
  name = params[:name]
  email = params[:email]
  password = params[:password]
  confirm_password = params['password again']
  if users_reader.email_exists?(email)
    signup_form_dsl.generate_form("signup", "User already exists")
  elsif password != confirm_password
    signup_form_dsl.generate_form("signup","Password do not match")
  else
    users_reader.create_user?(name, email,password)
    users_reader.save_user(email)
    redirect "/index"
  end
end
#---------------------------------------

# Ruta de la página principal
get '/index' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Books", false)}
                      #{content_item_reader.print_content_items("Movies", false)}
                      #{content_item_reader.print_content_items("Music", false)}
                      #{content_item_reader.print_content_items("News", false)}
                      #{content_item_reader.print_content_items("Recipes", false)}
                      #{content_item_reader.print_content_items("Videos", false)}
                      #{events_reader.print_events()}
                    </body>
                  </html>"
  html_content
end
#---------------------------------------

# Ruta de visualización de contenido específico
get '/content_item/:id' do
  id = params[:id]
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_item_data(id)}
                      #{content_item_reader.rating_content_item(id)}
                      #{comments_reader.print_comments(id,users_reader)}
                    </body>
                  </html>"
  html_content
end
#---------------------------------------

get '/content/:type' do
  content_type = params[:type]
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items(content_type.capitalize)}
                    </body>
                  </html>"
  html_content
end

get '/Events' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{events_reader.print_events()}
                    </body>
                  </html>"
  html_content
end

#---Content Item---
get '/create_content' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.generate_creation_form()}
                    </body>
                  </html>"
  html_content
end

def get_youtube_video_id(url)
  match = url.match(%r{(youtu\.be\/|\/|%3D|v=|vi=)([0-9A-Za-z_-]{11})([%#?&]|$)})
  if match
    return match[2]
  else
    return nil
  end
end

def build_youtube_embed_url(url)
  video_id = get_youtube_video_id(url)
  if video_id
    return "https://www.youtube.com/embed/#{video_id}"
  else
    return nil
  end
end

put '/create_content_item' do
  url = './Data/content_items.json'
  if params['type'] == 'Events'
    new_content = {
      "id": SecureRandom.uuid,
      "title": params['title'],
      "description": params['description'],
      "pubdate": DateTime.now.strftime('%d/%m/%Y %H:%M'),
      "location": params['location'],
      "datetime": params['datetime'],
      "image": params['digital_content']
    }
    url = './Data/events.json'
  else
    new_content = {
      "id": SecureRandom.uuid,
      "title": params['title'],
      "author": params['author'],
      "description": params['description'],
      "pubdate": params['pubdate'],
      "digital_content": build_youtube_embed_url(params['digital_content']),
      "rating": -1,
      "type": params['type']
    }
  end
  content = content_item_reader.readFile(url)
  content << new_content
  content_item_reader.writeFile(url, content)
  redirect "/index"
end

post '/delete_content_item' do
  content_item_id = params['content_item_id']
  items = content_item_reader.readFile('./Data/content_items.json')
  index_to_delete = items.find_index { |item| item["id"] == content_item_id }
  items.delete_at(index_to_delete)
  content_item_reader.writeFile('./Data/content_items.json', items)
  redirect "/index"
end

post '/update_content_item_form' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_update_form(params['content_item_id'])}
                    </body>
                  </html>"
  html_content
end

post '/update_content_item' do
  content_item_id = params['content_item_id']
  updated_title = params['updated_title']
  updated_author = params['updated_author']
  updated_description = params['updated_description']
  updated_pubdate = params['updated_pubdate']

  content_items = content_item_reader.readFile('./Data/content_items.json')
  index_to_update = content_items.find_index { |item| item["id"] == content_item_id }

  if !params['updated_digital_content'].nil?
    content_items[index_to_update]["digital_content"] = params['updated_digital_content']
    puts params['updated_digital_content']
  end
  content_items[index_to_update]["title"] = updated_title
  content_items[index_to_update]["author"] = updated_author
  content_items[index_to_update]["description"] = updated_description
  content_items[index_to_update]["pubdate"] = updated_pubdate
  content_item_reader.writeFile('./Data/content_items.json', content_items)
  redirect "/content_item/#{content_item_id}"
end
#---

#---Comments---
post '/submit_comment' do # Create new comment
  new_comment = {
    "id": SecureRandom.uuid,
    "user_id": params['comment_user_id'],
    "content_item_id":  params['content_item_id'],
    "text": params['comment_text'],
    "pubdate": DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  }
  comments = comments_reader.readFile('./Data/comments.json')
  comments << new_comment
  comments_reader.writeFile('./Data/comments.json', comments)
  content_item_id = params['content_item_id']
  redirect "/content_item/#{content_item_id}"
end

post '/delete_comment' do # Delete a comment
  comment_id = params['comment_id']
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_delete = comments.find_index { |comment| comment["id"] == comment_id }
  comments.delete_at(index_to_delete)
  comments_reader.writeFile('./Data/comments.json', comments)
  redirect "/content_item/#{params['content_item_id']}"
end

post '/update_comment' do # Actualizar un comentario
  comment_id = params['comment_id']
  updated_text = params['updated_text']
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_update = comments.find_index { |comment| comment["id"] == comment_id }
  comments[index_to_update]["text"] = updated_text
  comments[index_to_update]["pubdate"] = DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  comments_reader.writeFile('./Data/comments.json', comments)
  redirect "/content_item/#{params['content_item_id']}"
end
#------

#---Rating---
post '/update_rating' do  # Actualizar la puntuación
content_items = content_item_reader.readFile('./Data/content_items.json')
index_to_update = content_items.find_index { |item| item["id"] == params['content_item_id'] }
current_rating = content_items[index_to_update]["rating"]
new_rating = params['rating'].to_i 
average_rating = (current_rating + new_rating) / 2
content_items[index_to_update]["rating"] = average_rating
content_item_reader.writeFile('./Data/content_items.json', content_items)
redirect "/content_item/#{params['content_item_id']}"
end
#-------
