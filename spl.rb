require_relative 'semantic_model'
require_relative 'login_dsl'
require 'sinatra'

users_semantic_model = create_semantic_model('./user_dsl.rb')
user_reader = UsersReader.new

content_item_semantic_model = create_semantic_model('./content_item_dsl.rb')
content_item_reader = ContentItemsReader.new

comment_semantic_model = create_semantic_model('./comment_dsl.rb')
comments_reader = CommentsReader.new

login_form_dsl = LoginFormDSL.new
login_form_dsl.form(action: '/login', method: 'post') do
  input 'email', 'text', placeholder: 'Email'
  input 'password', 'password', placeholder: 'Password'
  button 'submit', 'Submit'
end

get '/' do
  login_form_dsl.generate_html
end

post '/login' do
  email = params[:email]
  password = params[:password]

  if user_reader.user_exists?(email, password)
    redirect "/index/#{email}"
  else
    "<label style='color:red;'>Inicio de sesión fallido. El usuario con email '#{email}' no existe o la contraseña es incorrecta.</label>"
  end
end

get '/index/:email' do
  email = params[:email]
  welcome_message = "<p>¡Bienvenido, #{email}! Esta es tu página de inicio personalizada.</p>"
  books_table = content_item_reader.print_table_content_items("Books")
  movies_table = content_item_reader.print_table_content_items("Movies")
  html_content = "<html>
                    <head>
                      <title>Página Personalizada</title>
                    </head>
                    <body>
                      #{welcome_message}
                      #{books_table}
                      #{movies_table}
                    </body>
                  </html>"
  html_content
end

get '/content_item/:id' do
  id = params[:id]
  welcome_message = "<p>Información para contenido con id #{id}</p>"
  content_item_data = content_item_reader.print_content_item_data(id)
  comments = comments_reader.print_comments(id,user_reader)
  html_content = "<html>
                    <head>
                      <title>Página Personalizada</title>
                    </head>
                    <body>
                      #{content_item_data}
                      #{comments}
                    </body>
                  </html>"
  html_content
end