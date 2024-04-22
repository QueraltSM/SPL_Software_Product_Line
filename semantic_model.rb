require 'memoist'
require 'net/http'
require 'base64'
require_relative './Frontend'
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

  def generate_edition_form(content_item_id)
    readFile('./Data/content_items.json')
    @data.each do |content_item|
      if content_item['id'] == content_item_id
        return Frontend.new().edit_content_item_form(content_item)
      end
    end
    return nil
  end

  def print_myposts
    reset_state()
    readFile('./Data/content_items.json')
    items = []
    @data.each do |content_item|
      if content_item['author'] == $user_id
        items << content_item
      end 
    end
    Frontend.new().myposts_table(items)
  end
   
  def print_content_items(type, sb)
    reset_state()
    readFile('./Data/content_items.json')
    frontend = Frontend.new()
    html = frontend.content_items_header_style(type)
    html += frontend.content_items_search_form(type, sb)

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
        html += frontend.content_item_body_video(content_item, generate_video_embed(content_item['digital_content']))       
      else
        base64_image = frontend.image_url_to_base64(content_item['digital_content'])
        unless unique_images.include?(base64_image)                      
          html += frontend.content_item_body_image(content_item, base64_image)
        end
      end
    end
    html += "</div>"
    return html
  end
end  

def print_content_item(id)
  reset_state()
  readFile('./Data/content_items.json')
  html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item['id'] == id
      frontend = Frontend.new()
      if $user_id == content_item['author']
        html +=  frontend.owner_css
        html += frontend.owner_actions(content_item)
      end
      html += frontend.content_item_body_style(content_item)
    end
  end
  html += "</div>"
  return html
end

def print_events(sb)
  reset_state()
  readFile('./Data/events.json')
  frontend = Frontend.new()
  html = ""

  # Delete past events from events.json
  @data.reject! { |event| DateTime.parse(event['datetime']) < DateTime.now }
  writeFile('./Data/events.json', @data)

  sorted_data = @data.sort_by { |event| DateTime.parse(event['datetime']) }.reverse
  html += frontend.header_events()
  items = sb ? sorted_data[-3..-1] : sorted_data

  html += frontend.search_form_events(sb)
  html += "<div style='display: flex; flex-wrap: wrap; justify-content: center; margin: 15px; padding: 10px;text-align:center'>"
  
  if sb == 'upcoming'
    items = @data.select { |item| DateTime.parse(item['datetime']) >= DateTime.now }
           .sort_by { |item| DateTime.parse(item['datetime']) }
  elsif sb == 'recent'
    items = @data.sort_by { |item| DateTime.parse(item['pubdate']) }
           .reverse
  end
  
  items.each do |event|
    html += frontend.body_events(event)
    # if event['author'] == $user_id
    #   html += frontend.admin_event_actions(event)
    # end
    html += "</div>"
  end
  html += "</div>"

  return html
end

  def rating_content_item(content_item_id)
    content_item = @data.find { |item| item['id'] == content_item_id }
    content_rating = content_item['rating']
    Frontend.new().rating_body(content_item_id, content_rating)
  end
  
  def print_comments(content_item_id, joined_reader) # Print and manage comments
    reset_state()
    readFile('./Data/comments.json')
    sorted_comments = @data.select { |comment| comment['content_item_id'] == content_item_id }
                           .sort_by { |comment| DateTime.parse(comment['pubdate']) }.reverse
    html = Frontend.new().comments_form(content_item_id,sorted_comments)       
    html += "<div style='text-align: center;'><h4>#{sorted_comments.size} comments</h4></div>" 
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