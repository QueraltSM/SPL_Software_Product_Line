# require 'memoist'
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
    @data.find { |user| user['email'].downcase == email.downcase && Base64.decode64(user['password']) == password }
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
    "password": Base64.encode64(password).chomp
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

  def generate_edition_form(id)
    items = readFile($items_file)
    items.each do |item|
      if item['id'] == id
        return Frontend.new().edit_item_form(item)
      end
    end
    return nil
  end

  def content_administration_form
    reset_state()
    items = readFile($items_file)
    items = items.select { |item| item['author'] == $user_id }
    Frontend.new().manage_content_table(items)
  end
  
  def print_items(type, sb)
    reset_state()
    readFile($items_file)
    frontend = Frontend.new()
    html = frontend.items_header_style(type)
    html += frontend.items_search_form(type, sb)
    html += "<div id='#{type}_content' style='display: flex; flex-wrap: wrap; margin: 15px; padding: 20px;'>"
    unique_images = Set.new
    if sb == 'rating'
      items = @data.select { |item| item['type'] == type }.sort_by { |item| -(item['rating'] || 0).to_i }
    elsif sb == 'date'
      items = @data.select { |item| item['type'] == type }
        .sort_by { |item| DateTime.parse(item['pubdate']) }
        .reverse
    end    
      items.each do |item|
        if item['type'] == 'Videos' || item['type'] == 'Movies' || item['type'] == 'Music'
          html += frontend.item_body_video(item, generate_video_embed(item['media_url']))       
        else
          base64_image = frontend.image_url_to_base64(item['media_url'])
          unless unique_images.include?(base64_image)                      
            html += frontend.item_body_image(item, base64_image)
          end
        end
      end
      html += "</div>"
      return html
    end
  end  

  def print_item(id)
    reset_state()
    readFile($items_file)
    html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
    @data.each do |item|
      if item['id'] == id
        frontend = Frontend.new()
        html += frontend.item_body_style(item)
      end
    end
    html += "</div>"
    return html
  end

  def rate_item(item_id)
    item = @data.find { |item| item['id'] == item_id }
    Frontend.new().rating_body(item_id, item['rating'])
  end
  
  def print_comments(item_id, joined_reader) # Print and manage comments
    reset_state()
    readFile('./Data/comments.json')
    sorted_comments = @data.select { |comment| comment['item_id'] == item_id }
                           .sort_by { |comment| DateTime.parse(comment['pubdate']) }.reverse
    html = Frontend.new().comments_form(item_id,sorted_comments)       
    html += "<div style='text-align: center;'><h4>#{sorted_comments.size} comments</h4></div>" 
    if !sorted_comments.empty?
      sorted_comments.each do |comment|
        user = joined_reader.getJoinedId(comment['user_id'], './Data/users.json')
        html += Frontend.new().print_comment(comment, item_id, user)  
      end
    end
    html += "</div></div>"
    return html
    end
end