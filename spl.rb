require_relative 'semantic_model'
require_relative './DSL/login_dsl'
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

post '/login' do
  email = params[:email]
  password = params[:password]
  if users_reader.user_exists?(email, password)
    users_reader.save_username(email)
    redirect "/index"
  else
    login_form_dsl.generate_login_form("Login failed because the user does not exist or the password is incorrect.")
  end
end

get '/index' do
  menu = content_item_reader.print_menu()
  books_table = content_item_reader.print_content_items("Books", true)
  movies_table = content_item_reader.print_content_items("Movies", true)
  music_table = content_item_reader.print_content_items("Music", true)
  videos_table = content_item_reader.print_content_items("Videos", true)
  recipes_table = content_item_reader.print_content_items("Recipes", true)
  news_table = content_item_reader.print_content_items("News", true)
  events = events_reader.print_events()
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{books_table}
                      #{movies_table}
                      #{music_table}
                      #{news_table}
                      #{recipes_table}
                      #{videos_table}
                      #{events}
                    </body>
                  </html>"
  html_content
end

get '/content_item/:id' do
  id = params[:id]
  menu = content_item_reader.print_menu()
  welcome_message = "<p>Información para contenido con id #{id}</p>"
  content_item_data = content_item_reader.print_content_item_data(id)
  comments = comments_reader.print_comments(id,users_reader)
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{content_item_data}
                      #{comments}
                    </body>
                  </html>"
  html_content
end

get '/books' do
  menu = content_item_reader.print_menu()
  books_table = content_item_reader.print_content_items("Books")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{books_table}
                    </body>
                  </html>"
  html_content
end

get '/movies' do
  menu = content_item_reader.print_menu()
  movies_table = content_item_reader.print_content_items("Movies")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{movies_table}
                    </body>
                  </html>"
  html_content
end

get '/music' do
  menu = content_item_reader.print_menu()
  music_table = content_item_reader.print_content_items("Music")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{music_table}
                    </body>
                  </html>"
  html_content
end

get '/videos' do
  menu = content_item_reader.print_menu()
  videos_table = content_item_reader.print_content_items("Videos")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{videos_table}
                    </body>
                  </html>"
  html_content
end

get '/recipes' do
  menu = content_item_reader.print_menu()
  recipes_table = content_item_reader.print_content_items("Recipes")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{recipes_table}
                    </body>
                  </html>"
  html_content
end

get '/news' do
  menu = content_item_reader.print_menu()
  news_table = content_item_reader.print_content_items("News")
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{news_table}
                    </body>
                  </html>"
  html_content
end

get '/events' do
  menu = content_item_reader.print_menu()
  events = events_reader.print_events()
  html_content = "<html>
                    <head>
                      <title></title>
                    </head>
                    <body>
                      #{menu}
                      #{events}
                    </body>
                  </html>"
  html_content
end
