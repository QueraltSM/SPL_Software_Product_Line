require_relative 'semantic_model'
require_relative 'authenticator'
require './frontend'
require 'sinatra'
require 'date'

users_semantic_model = create_semantic_model('./DSL/user.rb')
users_reader = UsersReader.new
content_item_semantic_model = create_semantic_model('./DSL/content_item.rb')
content_item_reader = ContentItemsReader.new
comment_semantic_model = create_semantic_model('./DSL/comment.rb')
comments_reader = CommentsReader.new
events_semantic_model = create_semantic_model('./DSL/event.rb')
events_reader = EventsReader.new
authentication_form = Authenticator.new

get '/' do
  redirect '/login'
end

get '/login' do
  authentication_form = Authenticator.new
  authentication_form.form(action: '/login', method: 'post') do
    input 'email', 'text', placeholder: 'Email'
    input 'password', 'password', placeholder: 'Password'
 end
  authentication_form.generate_form('login')
end

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
  def generate_landing_page
    html = Frontend.new().home_header()
    html += Frontend.new().home_body()
    html
  end
  html = <<~HTML
    <html>
      <body>
        #{Menu.generate_menu_html()}
        #{generate_landing_page()}
      </body>
    </html>
  HTML
  html
end

# List of event's view
get '/Events' do
  html = "<html>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{events_reader.print_events(params['sb'] || 'upcoming')}
                    </body>
                  </html>"
  html
end

# View of a particular event
post '/Event/:name' do
  html = "<html>
  <body>
    #{Menu.generate_menu_html()}
    #{events_reader.print_event(params['event_id'])}
  </body>
</html>"
html
end

# View of a particular content item
['get', 'post'].each do |method|
  send(method, '/:type/:name') do
    content_item_id = params['content_item_id'].nil? || params['content_item_id'].empty? ? $selected_content_item : params['content_item_id']
    if method == 'post' && !content_item_id.empty?
      $selected_content_item = content_item_id
    end
    html = "<html>
            <body>
              #{Menu.generate_menu_html()}
              #{content_item_reader.print_content_item(content_item_id)}
              #{content_item_reader.rating_content_item(content_item_id)}
              #{comments_reader.print_comments(content_item_id, users_reader)}
            </body>
          </html>"
    html
  end
end

# Creation form
get '/Create' do
  return "<html>
        <body>
         #{Menu.generate_menu_html()}
         #{Frontend.new().creation_content_item_form}
        </body>
    </html>"
end

# My posts form
get '/My-posts' do
  return "<html>
        <body>
         #{Menu.generate_menu_html()}
         #{content_item_reader.print_myposts}
        </body>
    </html>"
end

# Multimedia content page based on type
get '/:type' do
  content_type = params[:type]
  html = "<html>
            <body>
              #{Menu.generate_menu_html()}
              #{content_item_reader.print_content_items(content_type.capitalize, params['sb'] || 'date')}
            </body>
          </html>"
  html
end

post '/edit' do
  html = "<html>
                    <body>
                      #{Menu.generate_menu_html()}
                      #{content_item_reader.generate_edition_form(params['content_item_id'])}
                    </body>
                  </html>"
  html
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

put '/create_item' do
  url = './Data/content_items.json'
  if params['type'] == 'Events'
    new_content = {
      "id": SecureRandom.uuid,
      "author": $user_id,
      "title": params['title'],
      "description": params['description'],
      "date": params['date'],
      "pubdate": Time.now.strftime("%Y-%m-%dT%H:%M:%S"),
      "location": params['location'],
      "datetime": params['datetime'],
      "image": params['digital_content']
    }
    url = './Data/events.json'
  else
    new_content = {
      "id": SecureRandom.uuid,
      "title": params['title'],
      "source": params['source'],
      "author": $user_id,
      "description": params['description'],
      "date": params['date'],
      "pubdate": Time.now.strftime("%Y-%m-%dT%H:%M:%S"),
      "digital_content": params['digital_content'],
      "rating": 0,
      "type": params['type']
    }
  end
  content = content_item_reader.readFile(url)
  content << new_content
  content_item_reader.writeFile(url, content)
  if params['type'] == 'Events'
    redirect "/Events"
  else
    redirect "#{params['type']}"
  end  
end

put '/edit_item' do
  url = './Data/content_items.json'
  item_id = params[:content_item_id]
  content = content_item_reader.readFile(url)
  index_to_edit = content.find_index { |item| item["id"] == item_id }
  content[index_to_edit]["title"] = params['title']
  content[index_to_edit]["source"] = params['source']
  content[index_to_edit]["description"] = params['description']
  content[index_to_edit]["date"] = params['date']
  content[index_to_edit]["digital_content"] = params['digital_content']
  content_item_reader.writeFile(url, content)
  title_with_hyphens = content[index_to_edit]["title"].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{content[index_to_edit]["type"]}/#{title_with_hyphens}"
end


post '/delete' do
  content_item_id = params['content_item_id']
  items = content_item_reader.readFile('./Data/content_items.json')
  index_to_delete = items.find_index { |item| item["id"] == content_item_id }
  items.delete_at(index_to_delete)
  content_item_reader.writeFile('./Data/content_items.json', items)
  redirect "/index"
end

post '/submit_comment' do
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
  content_items = content_item_reader.readFile('./Data/content_items.json')
  selected_content_item = content_items.find { |item| item["id"] == $selected_content_item }
  title_with_hyphens = selected_content_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{selected_content_item['type']}/#{title_with_hyphens}"
end

post '/delete_comment' do # Delete a comment
  comment_id = params['comment_id']
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_delete = comments.find_index { |comment| comment["id"] == comment_id }
  comments.delete_at(index_to_delete)
  comments_reader.writeFile('./Data/comments.json', comments)
  content_items = content_item_reader.readFile('./Data/content_items.json')
  selected_content_item = content_items.find { |item| item["id"] == $selected_content_item }
  title_with_hyphens = selected_content_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{selected_content_item['type']}/#{title_with_hyphens}"
end

post '/update_comment' do # Actualizar un comentario
  comment_id = params['comment_id']
  updated_text = params['updated_text']
  comments = comments_reader.readFile('./Data/comments.json')
  index_to_update = comments.find_index { |comment| comment["id"] == comment_id }
  comments[index_to_update]["text"] = updated_text
  comments[index_to_update]["pubdate"] = DateTime.now.strftime('%d/%m/%Y %H:%M:%S')
  comments_reader.writeFile('./Data/comments.json', comments)
  content_items = content_item_reader.readFile('./Data/content_items.json')
  selected_content_item = content_items.find { |item| item["id"] == $selected_content_item }
  title_with_hyphens = selected_content_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
  redirect "/#{selected_content_item['type']}/#{title_with_hyphens}"
end

post '/update_rating' do  # Actualizar la puntuación
  content_items = content_item_reader.readFile('./Data/content_items.json')
  index_to_update = content_items.find_index { |item| item["id"] == params['content_item_id'] }
  current_rating = content_items[index_to_update]["rating"]
  new_rating = params['rating'].to_i 
  average_rating = (current_rating + new_rating) / 2
  content_items[index_to_update]["rating"] = average_rating
  content_item_reader.writeFile('./Data/content_items.json', content_items)
  redirect "/#{content_items[index_to_update]["type"] }/#{content_items[index_to_update]["title"].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase}"
end

def generate_video_embed(url)
  if url.include?('youtube.com') || url.include?('youtu.be')
    video_id = extract_youtube_video_id(url)
  return "<div style='position:relative; padding-bottom:56.25%; height:0; overflow:hidden; max-width:100%;'><iframe width='100%' height='100%' src='https://www.youtube.com/embed/#{video_id}' style='position:absolute; top:0; left:0; width:100%; height:100%;' frameborder='0' allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></div>"
elsif url.include?('vimeo.com')
    video_id = extract_vimeo_video_id(url)
    return "<div style='position:relative; padding-bottom:56.25%; height:0; overflow:hidden; max-width:100%;'><iframe src='https://player.vimeo.com/video/#{video_id}' style='position:absolute; top:0; left:0; width:100%; height:100%;' frameborder='0' allow='autoplay; fullscreen' allowfullscreen></iframe></div>"  
  else
    return "<p>Video no compatible</p>"
  end
end

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

def extract_vimeo_video_id(url)
  url.split('/')[-1]
end