require 'memoist'
require 'net/http'
require 'base64'
require_relative './Styles/css_styler'
require_relative './Styles/content_item_styler'

class SemanticModel
    attr_accessor :class_name, :fields
    def initialize()
      @fields = Array.new
    end
  end
  
  def entity_class(name)
    semantic_model = SemanticModel.new
    semantic_model.class_name = name
    define_method :field do |name, type|
      semantic_model.fields << [name, type]
    end
    yield
    semantic_model
  end

def create_semantic_model(file_path)
  semantic_model = eval File.read(file_path)
  eval "class #{semantic_model.class_name} end"
  entity_class_data = Object.const_get(semantic_model.class_name)
  entity_class_data.class_eval do
    define_method :initialize do |*parameters|
      i = 0
      while i<parameters.length
        self.instance_variable_set("@#{semantic_model.fields[i][0]}".to_sym, parameters[i])
        i += 1
      end
    end
    define_method :to_s do
      result = ''
      semantic_model.fields.each do |name, type|
        result += self.instance_variable_get("@#{name}".to_sym).to_s
      end
      result
    end
    def get(attribute)
      instance_variable_get("@#{attribute}")
    end
end

eval "class #{semantic_model.class_name}sReader end"
class_reader = Object.const_get("#{semantic_model.class_name}sReader")
class_reader.class_eval do
  attr_reader :data
  define_method :initialize do |*parameters|
    @data = Array.new
    @username = nil
  end
  define_method :readFile do |file_path|
    file_content = File.read(file_path)
    @data = JSON.parse(file_content)
  end
  define_method :writeFile do |file_path, data|
    File.open(file_path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end  
  define_method :updateFile do |file_path, data|
    File.open(file_path, 'w') do |file|
      json_data = data.map { |entity| entity.instance_variables.map { |var| [var.to_s.delete('@'), entity.instance_variable_get(var)] }.to_h }
      file.puts(JSON.pretty_generate(json_data))
    end
  end
  define_method :process_line do |line|
    @data << entity_class_data.new(line)
  end
  define_method :print do
    @data.each do |entity|
      puts entity.to_s
    end
  end
  def reset_state
    @data = []
  end
  def user_exists?(email, password)
      readFile('./Data/users.json')
      @data.find { |user| user['email'].downcase == email.downcase && user['password'] == password }
  end
  def email_exists?(email)
    readFile('./Data/users.json')
    @data.find { |user| user['email'].downcase == email.downcase }
end

def create_user?(name,email, password)
  new_user = {
    "id": SecureRandom.uuid,
    "name": name,
    "email": email,
    "password": password,
    "role": "User"
  }
  users = readFile('./Data/users.json')
  users << new_user
  writeFile('./Data/users.json', users)
end

def save_user(email)
    readFile('./Data/users.json')
    user = @data.find { |u| u['email'].downcase == email.downcase }
    $user_id = user['id']
    $user_name = user['name']
    $user_role = user['role']
  end  
  def print_menu()
    menu_html = "<head>
                   <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css' rel='stylesheet'>
                   <style>
                     body {
                       margin: 0 auto;
                       font-family: 'Verdana', sans-serif;
                       color: black;
                     }
                     .menu {
                       background-color: #E3ECD6;
                       padding: 10px;
                       text-align: center;
                     }
                     .menu a {
                       color: #333;
                       text-decoration: none;
                       margin: 10px;
                       padding: 10px;
                       display: inline-block;
                       font-size: 14px;
                     }
                     .menu a:last-child {
                       margin-right: 0;
                     }
                     .menu a:hover {
                      color:#1F6F3A;
                     }
                     .menu .user-info {
                       float: right;
                     }
                     .menu .user-info span {
                       color: #333;
                       margin-right: 10px;
                       font-size: 13px;
                     }
                     .menu .logout-link {
                       color: #333;
                       text-decoration: none;
                     }
                   </style>
                 </head>
                 <div class='menu'>
                   <a class='logout-link' href='/index'><i class='bi bi-house'></i></a>
                   <a href='/books'>Books</a>
                   <a href='/movies'>Movies</a>
                   <a href='/music'>Music</a>
                   <a href='/videos'>Videos</a>
                   <a href='/recipes'>Recipes</a>
                   <a href='/news'>News</a>
                   <a href='/events'>Events</a>"
                    if $user_role == "Admin"
                      menu_html += "<a style='background:#1F6F3A;color:#FFF;padding:10px;border-radius:5%' href='/create'>Create</a>"
                    end
                    menu_html +=  "<div class='user-info'>
                     <span>#{$user_name}</span>
                     <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                   </div>
                 </div>"
    return menu_html
  end
  def getJoinedId(iduser,data)
    readFile(data)
    user = @data.find { |user| user['id'] == iduser }
    if user
      user['name']
    end
  end
  def image_url_to_base64(image_url)
    begin
      uri = URI.parse(image_url)
      response = Net::HTTP.get_response(uri)
  
      if response.is_a?(Net::HTTPSuccess)
        image_data = response.body
        base64_data = Base64.strict_encode64(image_data)
        return base64_data
      else
        puts "Error: Unable to fetch the image. HTTP response code: #{response.code}"
        return nil
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      return nil
    end
  end

  def print_content_items(type, view_all = false) # Imprime el contenido digital en la pantalla de Inicio
    reset_state()
    readFile('./Data/content_items.json')
    content_divs = "<div id='#{type}_content' style='position: relative; justify-content: center; display: flex; flex-wrap: wrap; margin: 15px; padding: 10px;'>
                     <p style='width: 100%; text-align: center; font-size: 18px; font-weight: bold;'>#{type}</p>"
    if view_all 
        content_divs += "<button style='position: absolute; top: 10px; right: 10px; padding: 10px; background:#E3ECD6; cursor: pointer; border:none; border-radius: 5px;' onclick=\"window.location='/#{type.downcase}'\">View all #{type.downcase}</button>"
    end

    unique_images = Set.new
    counter = 0
    @data.each_with_index do |content_item, index|
      if content_item['type'] == type
        if counter < 3
          digital_content_html = ""
          if content_item['type'] == 'Videos'
            digital_content_html = "<div style='display: flex; justify-content: center;'><iframe width='560' height='315' src='#{content_item['digital_content']}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe></div>"
          else
            base64_image = image_url_to_base64(content_item['digital_content'])
            unique_images = Set.new
            unless unique_images.include?(base64_image)
              unique_images.add(base64_image)
              digital_content_html = "<div style='display: flex; justify-content: center;'><div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover no-repeat; height: 315px; width:560px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);'></div></div>"
            end
          end
          id = content_item['id']
          content_divs += "<div class='content-item' style='margin: 10px; padding: 10px; cursor: pointer; width: calc(20% - 20px); box-sizing: border-box; text-align: center;' onclick=\"window.location='/content_item/#{id}'\">
                            "+digital_content_html+"<div class='info' style='padding: 10px;'>
                                <div class='title' style='font-size: 14px; font-weight: bold; color: #333; margin-top: 10px;'>#{content_item['title']}</div>
                                <div class='author' style='color: #555; font-size: 12px;'>#{content_item['author']}</div>
                              </div>
                            </div><br>"
          counter += 1
        end
      end
    end
    # if view_all 
    #   content_divs += "<button style='position: absolute; top: 10px; right: 10px; padding: 10px; background:#E3ECD6; cursor: pointer; border:none; border-radius: 5px;' onclick=\"window.location='/#{type.downcase}'\">View All</button></div>"
    # end
    content_divs += "</div>"
    return content_divs
  end
end  

def print_content_item_data(id) # Visualización del contenido de un content_item
  reset_state()
  readFile('./Data/content_items.json')
  content_html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item['id'] == id
      styler = ContentItemStyler.new(content_item)
      content_html += styler.content_item_header_style
      if $user_role == "Admin"
        content_html += styler.admin_actions
      end
      content_html += styler.content_item_body_style
    end
  end
  content_html += "</div>"
  return content_html
end

  def print_events() # Visualización de los eventos
    reset_state()
    readFile('./Data/events.json')
    
    @data.reject! do |event| # Eliminamos de forma permanente los eventos pasados
       event_date = DateTime.parse(event['datetime'])
       event_date < DateTime.now
    end
    
    #updateFile('./Data/events.json', @data) #Actualizamos el fichero con los eventos que aún no se han celebrado
    styler = CSS_Styler.new()
    sorted_data = @data.sort_by { |event| DateTime.parse(event['datetime']) }.reverse
    html_content = styler.header_events()
    sorted_data.each do |event|
      html_content += styler.events_css(event)
    end
    html_content += "</div>"
    return html_content
  end


  def print_comments(content_item_id, joined_reader) # Print and manage comments
    reset_state()
    readFile('./Data/comments.json')
    sorted_comments = @data.select { |comment| comment['content_item_id'] == content_item_id }
                           .sort_by { |comment| DateTime.parse(comment['pubdate']) }.reverse
    html_content = "<div style='margin-top: 20px; text-align: center;'><h3>Comments</h3></div><div style='margin: 20px auto; width: 70%;'>
                    <div style='border: 1px solid #ddd; border-radius: 10px; overflow: hidden; padding: 20px; background-color: #f9f9f9;'>"
    html_content += "<div style='margin-bottom: 20px;'>
                      <form action='/submit_comment' method='post'>
                      <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                      <input type='hidden' name='comment_user_id' value='#{$user_id}'>
                        <label for='comment_text' style='font-size: 16px; color: #555;'>Add a comment:</label><br>
                        <textarea id='comment_text' name='comment_text' rows='4' cols='50' style='width: 100%; margin-top: 10px;'></textarea><br>
                        <div style='text-align: right;'>
                          <input type='submit' value='Send' style='background-color: #1F6F3A; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
                        </div>
                      </form>
                    </div>"
    if sorted_comments.empty?
      html_content += "<p style='color: #555; text-align: center;text-size:15px;'>No comments yet.</p>"
    else
      sorted_comments.each do |comment|
        user = joined_reader.getJoinedId(comment['user_id'], './Data/users.json')
        html_content +=
          "<div style='margin-bottom: 20px; padding: 15px; border: 1px solid #ddd; border-radius: 5px; background-color: #ffffff;text-align:justify;'>
            <span style='font-weight: bold; color: #333; font-size: 17px;'>#{user}</span>
            <span style='color: #777; margin-left: 10px; font-size: 14px;'>#{comment['pubdate']}</span>
            <p style='margin-top: 10px; color: #555; font-size: 15px;'>#{comment['text']}</p>"
            if comment['user_id'] == $user_id # Edit and Delete operations if user is owned of the comment
                html_content += "<form id='update_comment' action='/update_comment' method='post' style='margin-top: 10px; display: none;'>
                <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                <input type='hidden' name='comment_id' value='#{comment['id']}'>
                <textarea name='updated_text' style='width: 100%;' rows='4' cols='50'>#{comment['text']}</textarea><br><br>
                <input type='submit' value='Update' style='background-color: #1F6F3A; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
                <button type='button' class='cancel-edit' style='background-color: #C0392B; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>Cancel</button>
              </form>
              <div style='display: flex; justify-content: flex-end;'>
              <form action='' onsubmit='return false;'>
                <input type='submit' class='edit-button' value='Edit' style='background-color: #2B88C0; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
              </form>          
              <form action='/delete_comment' method='post'>
                <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                <input type='hidden' name='comment_id' value='#{comment['id']}'>
                <input type='submit' value='Delete' style='background-color: #C0392B; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>
              </form>
              </div>"
              html_content += "<script> document.addEventListener('DOMContentLoaded', function() {
                var editButton = document.querySelector('.edit-button');
                var updateForm = document.querySelector('#update_comment');
                var cancelEditButton = document.querySelector('.cancel-edit');
                editButton.addEventListener('click', function() {
                  updateForm.style.display = 'block';
                });
                cancelEditButton.addEventListener('click', function() {
                  updateForm.style.display = 'none';
                });
              });</script>"
            end
        html_content += "</div>"
      end
    end
    html_content += "</div></div>"
    return html_content
    end
    
end