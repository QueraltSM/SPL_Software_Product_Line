require 'memoist'
require 'net/http'
require 'base64'
require_relative './Frontend'
require_relative './content_item_frontend'
require_relative 'menu'

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

  def generate_creation_form()
    return ContentItemFrontend.new(nil).creation_content_item_form
  end

  def generate_edition_form(content_item_id)
    readFile('./Data/content_items.json')
    @data.each do |content_item|
      if content_item['id'] == content_item_id
        return ContentItemFrontend.new(nil).edit_content_item_form(content_item)
      end
    end
    return nil
  end
   
  def print_content_items(type, sb)
    reset_state()
    readFile('./Data/content_items.json')
    
    html = Frontend.new().content_items_header_style(type)
    html += Frontend.new().content_items_search_form(type, sb)

    html += "<div id='#{type}_content' style='display: flex; flex-wrap: wrap; margin: 15px; padding: 20px;'>"
    unique_images = Set.new
    if sb == 'rating'
      items = @data.select { |item| item['type'] == type }.sort_by { |item| -(item['rating'] || 0).to_i }
    elsif sb == 'date'
      items = @data.select { |item| item['type'] == type }
             .sort_by { |item| DateTime.parse(item['pubdate']) }
             .reverse
    end    
    items.each do |content_item|
      if content_item['type'] == 'Videos' || content_item['type'] == 'Movies' || content_item['type'] == 'Music'
        html += ContentItemFrontend.new(content_item).content_item_body_video(content_item, generate_video_embed(content_item['digital_content']))       
      else
        base64_image = image_url_to_base64(content_item['digital_content'])
        unless unique_images.include?(base64_image)                      
          html += ContentItemFrontend.new(content_item).content_item_body_image(content_item, base64_image)
        end
      end
    end
    html += "</div>"
    return html
  end
end  

def print_update_form(id)
  reset_state()
  readFile('./Data/content_items.json')
  html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item['id'] == id
      styler = ContentItemFrontend.new(content_item)
      html += styler.content_item_header_style
      html += styler.update_content_item_body_style
    end
  end
  html += "</div>"
  return html
end

def print_content_item(id) # Visualización del contenido de un content_item
  reset_state()
  readFile('./Data/content_items.json')
  html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item['id'] == id
      styler = ContentItemFrontend.new(content_item)
      html += styler.content_item_header_style
      if $user_id == content_item['author']
        html +=  Frontend.new().admin_css
        html += styler.admin_actions
      end
      html += styler.content_item_body_style
    end
  end
  html += "</div>"
  return html
end

def print_events(sb)
  reset_state()
  readFile('./Data/events.json')
  styler = Frontend.new()
  html = ""

  # Delete past events from events.json
  @data.reject! { |event| DateTime.parse(event['datetime']) < DateTime.now }
  writeFile('./Data/events.json', @data)

  sorted_data = @data.sort_by { |event| DateTime.parse(event['datetime']) }.reverse
  html += styler.header_events()
  items = sb ? sorted_data[-3..-1] : sorted_data

  html += styler.search_form_events(sb)
  html += "<div style='display: flex; flex-wrap: wrap; justify-content: center; margin: 15px; padding: 10px;text-align:center'>"
  
  if sb == 'upcoming'
    items = @data.select { |item| DateTime.parse(item['datetime']) >= DateTime.now }
           .sort_by { |item| DateTime.parse(item['datetime']) }
  elsif sb == 'recent'
    items = @data.sort_by { |item| DateTime.parse(item['pubdate']) }
           .reverse
  end
  
  items.each do |event|
    html += styler.body_events(event)
    # if event['author'] == $user_id
    #   html += styler.admin_event_actions(event)
    # end
    html += "</div>"
  end
  html += "</div>"

  return html
end


def print_event(event_id)
  reset_state()
  readFile('./Data/events.json')
  styler = Frontend.new()
  html = ""

  # Buscar el evento con el ID proporcionado
  event = @data.find { |event| event['id'] == event_id }

  # Verificar si se encontró el evento
  if event.nil?
    html += "<p>Evento no encontrado</p>"
  else
    html += styler.header_events()

    # Generar el contenido del evento
    html += "<div class='event-container' style='width: 500px; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>"
    html += "<img src='#{event['image']}' style='width: 100%; height: 250px; object-fit: cover; border-bottom: 1px solid #ddd;'>"
    html += "<div style='padding: 20px;'>"
    html += "<p class='event-title' style='font-weight: bold; color: #333; font-size: 16px; margin-bottom: 8px;'>#{event['title']}</p>"
    html += "<p class='event-description' style='color: #555; font-size: 13px; margin-bottom: 8px;'>#{event['description']}</p>"
    html += "<p class='event-location' style='color: #777; font-size: 12px; margin-bottom: 8px;'><i class='bi bi-geo-alt'></i> #{event['location']}</p>"
    html += "<p style='color: #777; font-size: 12px;'><i class='bi bi-clock'></i> #{DateTime.parse(event['datetime']).strftime("%d/%m/%Y %I:%M")}</p>"
    html += "</div>"
    html += "</div>"
  end

  return html
end



def rating_content_item(content_item_id)
  content_item = @data.find { |item| item['id'] == content_item_id }
  content_rating = content_item['rating']
  html = "<p style='font-size:13px;color:#9e9e9e;text-align:center'>Rating is now #{content_item['rating']}</p>
                  <div style='margin-bottom: 20px;'>
                    <form id='ratingForm' action='/update_rating' method='post' onsubmit='return confirmRating();'>
                      <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                      <input type='hidden' name='rating' id='selectedRating'>
                      <div style='text-align: center;'>
                        <div class='rating'>"
  (1..10).each do |i|
    html += "<input type='radio' id='star#{i}' name='rating' value='#{i}' onclick='setSelectedRating(#{i})' #{'checked' if i == content_rating}><label for='star#{i}'></label>"
  end
  html += "</div><br>
                    <input id='submitBtn' type='submit' value='Rate' style='background-color: #1F6F3A; color: white; border: none; padding:10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
                    </div>
                    </form>
                    </div>
                    <script>
                      function setSelectedRating(starValue) {
                        document.getElementById('selectedRating').value = starValue;
                        document.getElementById('submitBtn').value = 'Rate';
                      }
                      
                      function confirmRating() {
                        return confirm('Are you sure you want to submit this rating?');
                      }
                    </script>"
  return html
end

  
  def print_comments(content_item_id, joined_reader) # Print and manage comments
    reset_state()
    readFile('./Data/comments.json')
    sorted_comments = @data.select { |comment| comment['content_item_id'] == content_item_id }
                           .sort_by { |comment| DateTime.parse(comment['pubdate']) }.reverse
    html = Frontend.new().comments_form(content_item_id,sorted_comments)       
    html += "<div style='margin-top: 20px; text-align: center;'><h4>#{sorted_comments.size} comments</h4></div>" 
    if !sorted_comments.empty?
      sorted_comments.each do |comment|
        user = joined_reader.getJoinedId(comment['user_id'], './Data/users.json')
        html += Frontend.new().print_comment(comment, content_item_id, user)  
      end
    end
    html += "</div></div>"
    return html
    end
    
end