require_relative 'semantic_model'
require_relative 'login'
require_relative 'signup'
require 'sinatra'

users_semantic_model = create_semantic_model('./DSL/user_dsl.rb')
users_reader = UsersReader.new

content_item_semantic_model = create_semantic_model('./DSL/content_item_dsl.rb')
content_item_reader = ContentItemsReader.new

comment_semantic_model = create_semantic_model('./DSL/comment_dsl.rb')
comments_reader = CommentsReader.new

events_semantic_model = create_semantic_model('./DSL/event_dsl.rb')
events_reader = EventsReader.new

login_form_dsl = LoginFormDSL.new
login_form_dsl.form(action: '/login', method: 'post') do
  input 'email', 'text', placeholder: 'Email'
  input 'password', 'password', placeholder: 'Password'
end

get '/' do
  login_form_dsl.generate_login_form
end

signup_form_dsl = SignupFormDSL.new
get '/signup' do
  signup_form_dsl.generate_signup_form
end 

post '/signup' do
  name = params['name']
  email = params['email']
  password = params['password']
  confirm_password = params['confirm_password']
  if password != confirm_password
    signup_form_dsl.generate_signup_form("Password do not match")
  elsif users_reader.email_exists?(email)
    signup_form_dsl.generate_signup_form("User already exists")
  else
    users_reader.create_user?(name, email,password)
    users_reader.save_user(email)
    redirect "/index"
  end
end

post '/login' do
  email = params[:email]
  password = params[:password]
  if users_reader.user_exists?(email, password)
    users_reader.save_user(email)
    redirect "/index"
  else
    login_form_dsl.generate_login_form("User does not exist or the password is incorrect.")
  end
end

get '/index' do

  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Books", true)}
                      #{content_item_reader.print_content_items("Movies", true)}
                      #{content_item_reader.print_content_items("Music", true)}
                      #{content_item_reader.print_content_items("News", true)}
                      #{content_item_reader.print_content_items("Recipes", true)}
                      #{content_item_reader.print_content_items("Videos", true)}
                      #{events_reader.print_events()}
                    </body>
                  </html>"
  html_content
end

# --- Visualización de un contenido ---
get '/content_item/:id' do
  id = params[:id]
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_item_data(id)}
                      #{comments_reader.print_comments(id,users_reader)}
                    </body>
                  </html>"
  html_content
end
#------

get '/books' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Books")}
                    </body>
                  </html>"
  html_content
end

get '/movies' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Movies")}
                    </body>
                  </html>"
  html_content
end

get '/music' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Music")}
                    </body>
                  </html>"
  html_content
end

get '/videos' do
  menu = Menu.generate_menu_html()
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Videos")}
                    </body>
                  </html>"
  html_content
end

get '/recipes' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("Recipes")}
                    </body>
                  </html>"
  html_content
end

get '/news' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.print_content_items("News")}
                    </body>
                  </html>"
  html_content
end

get '/events' do
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{ events = events_reader.print_events()}
                    </body>
                  </html>"
  html_content
end

#---Content Item---
post '/delete_content_item' do
  content_item_id = params['content_item_id']
  puts content_item_id
  #items = content_item_reader.readFile('./Data/content_items.json')
  #index_to_delete = items.find_index { |item| item["id"] == content_item_id }
  #items.delete_at(index_to_delete)
  #content_item_reader.writeFile('./Data/content_items.json', items)
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
