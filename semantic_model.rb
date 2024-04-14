require 'memoist'
require 'net/http'
require 'base64'
require_relative './Styles/css_styler'
require_relative './Styles/content_item_styler'
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
  $user_role = user['role']
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
    content_html = ContentItemStyler.new(nil).creation_content_item_form
    return content_html
  end

 
  def generate_landing_page
    html = <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Welcome to Our Website</title>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
          <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
          <style>
              body {
                  font-family: 'Poppins', sans-serif;
                  margin: 0;
                  padding: 0;
                  background-color: #f9f9f9;
              }
              .header {
                  background-color: #333;
                  color: #fff;
                  padding: 20px 0;
                  text-align: center;
              }
              .container {
                  max-width: 1200px;
                  margin: 0 auto;
                  padding: 20px;
              }
              .hero {
                  text-align: center;
                  margin-top: 10px;
                  padding: 20px 0;
              }
              .hero h1 {
                  font-size: 30px;
                  color: #333;
                  margin-bottom: 20px;
              }
              .hero p {
                  font-size: 18px;
                  color: #666;
                  margin-bottom: 30px;
              }
              .features {
                  display: flex;
                  justify-content: center;
                  flex-wrap: wrap;
              }
              .feature {
                  width: calc(15% - 20px);
                  background: linear-gradient(to bottom right, #f5f5f5, #e0e0e0);
                  border-radius: 10px;
                  padding: 40px;
                  margin: 20px;
                  text-align: center;
                  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                  transition: transform 0.3s ease;
                  cursor: pointer;
              }
              .feature:hover {
                  transform: translateY(-10px);
                  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
              }
              .feature h2 {
                  font-size: 20px;
                  color: #333;
                  margin-bottom: 10px;
              }
              .feature p {
                  font-size: 13px;
                  color: #666;
              }
          </style>
      </head>
      <body>
          <div class="container">
              <div class="hero">
                  <h1>Discover a world of multimedia content</h1>
              </div>

              <div class="features">
              <div class="feature" onclick="window.location.href = '/content/News';">
              <i class="fas fa-globe fa-2x"></i>
    <h2>News</h2>
    <p>Stay informed with breaking news and in-depth articles.</p>
</div>

                  <div class="feature" onclick="window.location.href = '/content/Books';">
                  <i class="fas fa-book fa-2x"></i>
                      <h2>Books</h2>
                      <p>Find your next favorite read.</p>
                  </div>

                  <div class="feature" onclick="window.location.href = '/content/Recipes';">
                  <i class="fas fa-utensils fa-2x"></i>
                  <h2>Recipes</h2>
                  <p>Cook up delicious dishes from around the world.</p>
              </div>
                  <div class="feature" onclick="window.location.href = '/content/Movies';">
                  <i class="fas fa-film fa-2x"></i>
                      <h2>Movies</h2>
                      <p>Enjoy blockbuster hits and indie gems.</p>
                  </div>
                  <div class="feature" onclick="window.location.href = '/content/Videos';">
                  <i class="fas fa-video fa-2x"></i>
                  <h2>Videos</h2>
                  <p>Watch entertaining and informative videos.</p>
              </div>
                  <div class="feature" onclick="window.location.href = '/content/Music';">
                  <i class="fas fa-music fa-2x"></i>
                      <h2>Music</h2>
                      <p>Listen to the latest tracks and timeless classics.</p>
                  </div>
  
                  <div class="feature" onclick="window.location.href = '/content/Podcasts';">
                  <i class="fas fa-podcast  fa-2x"></i>
                      <h2>Podcasts</h2>
                      <p>Listen to insightful discussions and captivating stories.</p>
                  </div>
                
              <div class="feature" onclick="window.location.href = '/content/Videogames';">
              <i class="fas fa-gamepad fa-2x"></i>
                  <h2>Videogames</h2>
                  <p>Embark on epic adventures and immerse yourself in virtual worlds.</p>
              </div>
                <div class="feature" onclick="window.location.href = '/content/Art';">
                <i class="fas fa-paint-brush  fa-2x"></i>
                  <h2>Art</h2>
                  <p>Explore stunning artworks and creative masterpieces.</p>
              </div>
              <div class="feature" onclick="window.location.href = '/content/Platforms';">
              <i class="fas fa-link fa-2x"></i>
              <h2>Platforms</h2>
              <p>Find out what's trending and discover hidden gems.</p>
          </div>
          
                  <div class="feature" onclick="window.location.href = '/content/Events';">
                  <i class="fas fa-calendar-alt fa-2x"></i>
                  <h2>Events</h2>
                  <p>Discover exciting events happening near you.</p>
              </div>
                  <div class="feature" onclick="window.location.href = '/create';">
                  <i class="fas fa-plus-circle fa-2x"></i>
                  <h2>Create</h2>
                  <p>Bring your ideas to life and share them with the world.</p>
              </div>
              </div>
          </div>
      </body>
      </html>
    HTML
  
    return html
  end
   
  
  def print_best_content_items()
    reset_state()
    readFile('./Data/content_items.json')
    content_divs = "<div style='position: relative; justify-content: center; display: flex; flex-wrap: wrap; margin: 15px; padding: 10px;'>"
  
    # Creamos un hash para almacenar el mejor elemento de cada tipo de contenido
    best_items = Hash.new { |h, k| h[k] = nil }
  
    # Iteramos sobre los datos y almacenamos el mejor de cada tipo
    @data.each do |content_item|
      type = content_item['type']
      rating = content_item['rating'].to_i
      if rating > 0 && (best_items[type].nil? || rating > best_items[type]['rating'].to_i)
        best_items[type] = content_item
      end
    end
  
    # Iteramos sobre los mejores elementos de cada tipo y los mostramos en la página
    best_items.each do |type, content_item|
      next if content_item.nil?
  
      digital_content_html = ""
      if content_item['type'] == 'Videos' || content_item['type'] == 'Movies'
        digital_content_html = "<div style='display: flex; justify-content: center;'><iframe width='280' height='160' src='#{content_item['digital_content']}' frameborder='0' allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen controls></iframe></div>"
      else
        base64_image = image_url_to_base64(content_item['digital_content'])
        digital_content_html = "<div style='display: flex; justify-content: center;'><img src='data:image/jpeg;base64,#{base64_image}' style='max-width: 100%; height: auto; max-height: 160px;'></div>"
      end
  
      id = content_item['id']
      content_divs += "<div style='position: relative; text-align: center; margin-bottom: 30px; width: 280px; margin-right: 20px;'>"
      content_divs += "<h4 style='background-color: #E3ECD6; color: black; padding: 5px 10px; border-radius: 5px;'>Best of #{type}</h4>"
      content_divs += "<div class='content-item' style='margin: 10px; padding: 10px; cursor: pointer; text-align: center;' onclick=\"window.location='/content_item/#{id}'\">#{digital_content_html}<div class='info' style='padding: 10px;'><div class='title' style='font-size: 14px; font-weight: bold; color: #333; margin-top: 10px;'>#{content_item['title']}</div><div class='author' style='color: #555; font-size: 12px;'>#{content_item['author']}</div></div></div>"
      content_divs += "</div>"
    end
  
    content_divs += "</div>"
    return content_divs
  end

  def print_content_items(type, sort_by)
    reset_state()
    readFile('./Data/content_items.json')
    content_divs = "<h4 style='text-align: center;
    margin-top: 10px;
    padding: 20px 0;font-size: 30px;
    color: #333;
    margin-bottom: 20px;'>#{type}</h4>"
  
    content_divs += "<form id='sort-form' style='margin-top: 20px;margin: 20px;'>
    <div style='display: flex; align-items: center; justify-content: flex-end;'>
      <input type='text' name='search' id='search' placeholder='Search...' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
      <select id='sort_by' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
        <option value='date'  #{'selected' if sort_by == 'date'}>Order by date</option>
        <option value='rating'  #{'selected' if sort_by == 'rating'}>Order by rating</option>
      </select>
    </div>
    </form>
    <script>
    document.getElementById('sort_by').addEventListener('change', function() {
      window.location.href = '/content/#{type}?sort_by=' + this.value;
    });
    document.getElementById('search').addEventListener('input', function() {
      var searchText = this.value.toLowerCase();
      var contentItems = document.getElementsByClassName('content-item');
  
      Array.from(contentItems).forEach(function(item) {
        var title = item.querySelector('.title').innerText.toLowerCase();
        var author = item.querySelector('.author').innerText.toLowerCase();
        if (title.includes(searchText) || author.includes(searchText)) {
          item.style.display = 'block';
        } else {
          item.style.display = 'none';
        }
      });
    });
    </script>";
  
    content_divs += "<div id='#{type}_content' style='display: flex; flex-wrap: wrap; margin: 15px; padding: 20px;'>"
    unique_images = Set.new
  
    if sort_by == 'rating'
      items = @data.select { |item| item['type'] == type }.sort_by { |item| -(item['rating'] || 0).to_i }
    elsif sort_by == 'date'
      items = @data.select { |item| item['type'] == type }.sort_by { |item| Date.parse(item['pubdate']) }.reverse
    end    

    items.each do |content_item|
      digital_content_html = ""
      if content_item['type'] == 'Videos' || content_item['type'] == 'Movies'
        digital_content_html = "<iframe width='100%' height='200' src='#{content_item['digital_content']}' frameborder='0' allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>"
      else
        base64_image = image_url_to_base64(content_item['digital_content'])
        unless unique_images.include?(base64_image)
          unique_images.add(base64_image)
          digital_content_html = "<div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover; height: 200px;'></div>"
        end
      end
      id = content_item['id']
      
      content_divs += "<div class='content-item' style='width: 30%; margin: 10px; padding: 10px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); background-color: #fff;'>
                        #{digital_content_html}
                        <a href='#' style='text-decoration: none;' onclick=\"window.location='/content_item/#{id}'\"><div class='info' style='padding: 10px;'>
                          <div class='title' style='font-size: 16px; font-weight: bold; color: #333; margin-top: 10px;'>#{content_item['title']}</div>
                          <div class='author' style='color: #555; font-size: 14px;'>#{content_item['author']}</div>
                        </div>
                      </a></div>"
    end
    content_divs += "</div>"
    return content_divs
  end
end  

def print_update_form(id)
  reset_state()
  readFile('./Data/content_items.json')
  content_html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item['id'] == id
      styler = ContentItemStyler.new(content_item)
      content_html += styler.content_item_header_style
      content_html += styler.update_content_item_body_style
    end
  end
  content_html += "</div>"
  return content_html
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
        content_html +=  CSS_Styler.new().admin_css
        content_html += styler.admin_actions
      end
      content_html += styler.content_item_body_style
    end
  end
  content_html += "</div>"
  return content_html
end

def print_events(upcoming)
  reset_state()
  readFile('./Data/events.json')
  styler = CSS_Styler.new()
  html_content = ""

  # Eliminar eventos pasados del archivo events.json
  @data.reject! { |event| DateTime.parse(event['datetime']) < DateTime.now }
  writeFile('./Data/events.json', @data)

  sorted_data = @data.sort_by { |event| DateTime.parse(event['datetime']) }.reverse
  html_content += styler.header_events(upcoming)
  html_content += "<div style='display: flex; flex-wrap: wrap; justify-content: center; margin: 15px; padding: 10px;text-align:center'>"

  events_to_display = upcoming ? sorted_data[-3..-1] : sorted_data

  events_to_display.each do |event|
    html_content += styler.body_events(event)
  end
  html_content += "</div>"

  return html_content
end


  def rating_content_item(content_item_id)
    content_item = @data.find { |item| item['id'] == content_item_id }
    content_rating = content_item['rating']
    html_content = "<div style='margin-bottom: 20px;'>
                      <form id='ratingForm' action='/update_rating' method='post' onsubmit='return confirmRating();'>
                        <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                        <input type='hidden' name='rating' id='selectedRating'>
                        <div style='text-align: center;'>
                          <div class='rating'>"
    (1..10).each do |i|
      html_content += "<input type='radio' id='star#{i}' name='rating' value='#{i}' onclick='setSelectedRating(#{i})'><label for='star#{i}'></label>"
    end
    html_content += "</div><br>
                      <input id='submitBtn' title='Rate this content' type='submit' value='Rate this content' style='background-color: #1F6F3A; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
                      </div>
                      </form>
                      </div>
                      <script>
                        function setSelectedRating(starValue) {
                          document.getElementById('selectedRating').value = starValue;
                        }
                        
                        function confirmRating() {
                          return confirm('Are you sure you want to submit this rating?');
                        }
                      </script>"
    return html_content
  end  
  
  def print_comments(content_item_id, joined_reader) # Print and manage comments
    reset_state()
    readFile('./Data/comments.json')
    sorted_comments = @data.select { |comment| comment['content_item_id'] == content_item_id }
                           .sort_by { |comment| DateTime.parse(comment['pubdate']) }.reverse
    html_content = "<div style='margin: 20px auto; width: 70%;'>
                    <div style='border: 1px solid #ddd; border-radius: 10px; overflow: hidden; padding: 20px; background-color: #f9f9f9;'>"
    html_content += "<div style='margin-bottom: 20px;'><div style='margin-top: 20px; text-align: center;'><h4>Comments</h4></div>
                      <form action='/submit_comment' method='post'>
                      <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                      <input type='hidden' name='comment_user_id' value='#{$user_id}'>
                        <label for='comment_text' style='font-size: 13px; color: #555;'>Add a comment:</label><br>
                        <textarea id='comment_text' name='comment_text' rows='4' cols='50' style='width: 100%; margin-top: 10px;'></textarea><br>
                        <div style='text-align: right;'>
                          <input type='submit' value='Send' style='background-color: #1F6F3A; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
                        </div>
                      </form>
                    </div>"
    if !sorted_comments.empty?
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
                <button type='button' class='cancel-edit' style='background-color: #D86E6E; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>Cancel</button>
              </form>
              <div style='display: flex; justify-content: flex-end;'>
              <form action='' onsubmit='return false;'>
                <input type='submit' class='edit-button' value='Edit' style='background-color: #2B88C0; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
              </form>          
              <form action='/delete_comment' method='post'>
                <input type='hidden' name='content_item_id' value='#{content_item_id}'>
                <input type='hidden' name='comment_id' value='#{comment['id']}'>
                <input type='submit' value='Delete' style='background-color: #D86E6E; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>
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