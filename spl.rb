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
    users_reader.save_user(email)
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

#---Comments---

post '/submit_comment' do # Create new comment
  comment_id = SecureRandom.uuid
  comment_user_id = params['comment_user_id']
  comment_content_item_id = params['content_item_id']
  comment_text = params['comment_text']
  comment_pubdate = DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  new_comment = "\n#{comment_id} ||| #{comment_user_id} ||| #{comment_content_item_id} ||| #{comment_text} ||| #{comment_pubdate}"
  File.open('./Data/comments.txt', 'a') { |file| file.puts(new_comment) }
  content_item_id = params['content_item_id']
  redirect "/content_item/#{content_item_id}"
end

post '/delete_comment' do # Delete a comment
  comment_id = params['comment_id']
  comment_content_item_id = params['content_item_id']
  comments_file_path = './Data/comments.txt'
  comments_data = File.readlines(comments_file_path).map(&:chomp)
  File.open(comments_file_path, 'r+') do |file|
    lines = file.readlines
    lines.reject! { |line| line.split(' ||| ')[0] == comment_id }
    file.rewind
    file.write(lines.join(""))
    file.truncate(file.pos)
  end
  redirect "/content_item/#{comment_content_item_id}"
end

post '/update_comment' do # Actualizar un comentario
  comment_id = params['comment_id']
  comment_content_item_id = params['content_item_id']
  updated_pubdate = DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  updated_text = params['updated_text']
  comments_file_path = './Data/comments.txt'
  File.open(comments_file_path, 'r+') do |file|
    lines = file.readlines
    lines.map! do |line|
      data = line.split(' ||| ')
      if data[0] == comment_id
        data[3] = updated_text
        data[4] = updated_pubdate
        line = data.join(' ||| ')
      end
      line
    end
    file.rewind
    file.write(lines.join(""))
    file.truncate(file.pos)
  end
  redirect "/content_item/#{comment_content_item_id}"
end

#------
