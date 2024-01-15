require 'memoist'
require 'net/http'
require 'base64'

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
        result += "#{name} = " +
            self.instance_variable_get("@#{name}".to_sym).to_s + "\n"
      end
      result +  "---------------------------------"
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
  define_method :readFile do |filedata|
    File.readlines(filedata).each { |line|
      process_line(line)
    }
  end
  define_method :updateFile do |file_path, data|
    File.open(file_path, 'w') do |file|
      data.each do |event|
        file.puts("#{event.get('title')},#{event.get('description')},#{event.get('venue')},#{event.get('datetime')},#{event.get('image')}")
      end
    end
  end
  define_method :process_line do |line|
    values = line.split(/\s*\|\|\|\s*/)
    values.map! {|valor| valor.strip}
    @data << entity_class_data.new(*values)
  end
  def print
    @data.each { |i|
      puts i
    }
  end
  def reset_state
    @data = []
  end
  def user_exists?(email, password)
    readFile('./Data/users.txt')
    @data.find { |user| user.get('email').downcase == email.downcase && user.get('password') == password }
  end 

  def save_username(email)
    readFile('./Data/users.txt')
    user = @data.find { |u| u.get('email').downcase == email.downcase }
    @username = user.get('name')
    puts @username
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
                       font-weight: bold;
                     }
                     .menu .user-info {
                       float: right;
                     }
                     .menu .user-info span {
                       color: #333;
                       margin-right: 10px;
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
                   <a href='/events'>Events</a>
                   <div class='user-info'>
                     <span>#{@username}</span>
                     <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                   </div>
                 </div>"
    return menu_html
  end
  
  def getJoinedId(iduser,data)
    readFile(data)
    user = @data.find { |user| user.get('id') == iduser }
    if user
      user.get('name')
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

  def print_content_items(type, view_all = false)
    reset_state()
    readFile('./Data/content_items.txt')
    content_divs = "<div id='#{type}_content' style='position: relative; display: flex; flex-wrap: wrap; border: 1px solid #E9E9E9; border-radius: 5px; margin: 15px; padding: 10px;'>
                     <p style='width: 100%; text-align: center; font-size: 18px; font-weight: bold;'>#{type}</p>"
    unique_images = Set.new
    @data.each_with_index do |content_item, index|
      if content_item.get('type') == type
        base64_image = image_url_to_base64(content_item.get('image'))
        unless unique_images.include?(base64_image)
          unique_images.add(base64_image)
          content_divs += "<div class='content-item' style='margin: 10px; padding: 10px; cursor: pointer; width: calc(20% - 20px); box-sizing: border-box; text-align: center;' onclick=\"window.location='/content_item/#{content_item.get('id')}'\">
                            <div class='thumbnail' style='background: white url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 250px;'></div>
                            <div class='info' style='padding: 10px;'>
                              <div class='title' style='font-size: 14px; font-weight: bold; color: #333; margin-top: 10px;'>#{content_item.get('title')}</div>
                              <div class='author' style='color: #555; font-size: 12px;'>#{content_item.get('author')}</div>
                            </div>
                          </div>"
          content_divs += "<br>" if (index + 1) % 5 == 0
        end
      end
    end
    if view_all 
      content_divs += "<button style='position: absolute; top: 10px; right: 10px; padding: 10px; background:#E3ECD6; cursor: pointer; border:none; border-radius: 5px;' onclick=\"window.location='/#{type.downcase}'\">
                        View All
                      </button></div>"
    end
    return content_divs
  end
end  

def print_content_item_data(id)
  reset_state()
  readFile('./Data/content_items.txt')
  content_html = "<div style='display: flex; flex-direction: column; align-items: center; margin-top: 20px;text-align:justify;'>"
  @data.each do |content_item|
    if content_item.get('id') == id
      content_html +=
        "<div style='width: 70%; margin-bottom: 20px; overflow: hidden;'>
          <div style='padding: 20px;'>
            <h2 style='color: #333;'>#{content_item.get('title')}</h2>
            <p style='color: #888; font-style: italic;'>#{content_item.get('author')}</p>
            <pre style='color: #555; white-space: pre-wrap;'>#{content_item.get('description')}</pre>
            <p style='color: #777;'>Fecha de publicación: #{content_item.get('pubdate')}</p>
          </div>
        </div>"
    end
  end
  content_html += "</div>"
  return content_html
end

  
  def print_comments(id, joined_reader)
    reset_state()
    readFile('./Data/comments.txt')
    sorted_comments = @data.select { |comment| comment.get('content_item_id') == id }
                           .sort_by { |comment| DateTime.parse(comment.get('pubdate')) }.reverse
    html_content = "<div style='margin-top: 20px; text-align: center;'><h2>Comments</h2></div><div style='margin: 20px auto; width: 50%;'>
                    <div style='border: 1px solid #ddd; border-radius: 10px; overflow: hidden; padding: 10px; background-color: #f5f5f5;'>"
    if sorted_comments.empty?
      html_content += "<p style='color: #555; text-align: center;'>No comments yet.</p>"
    else
      sorted_comments.each do |content_item|
        user = joined_reader.getJoinedId(content_item.get('user_id'), './Data/users.txt')
        html_content +=
          "<div style='margin-bottom: 15px;'>
            <span style='font-weight: bold; color: #333;'>#{user}</span>
            <span style='color: #777; margin-left: 10px;'>#{content_item.get('pubdate')}</span>
            <p style='margin-top: 5px; color: #555;'>#{content_item.get('text')}</p>
          </div>"
      end
    end
    html_content += "</div></div>"
    return html_content
  end
    
  def print_events()
    reset_state()
    readFile('./Data/events.txt')
    
    # @data.reject! do |event|
    #   event_date = DateTime.parse(event.get('datetime'))
    #   event_date < DateTime.now
    # end
    # updateFile('./Data/events.txt', @data)

    sorted_data = @data.sort_by { |event| DateTime.parse(event.get('datetime')) }.reverse
    html_content = "<div style='display: flex; flex-wrap: wrap; justify-content: center; border: 1px solid #E9E9E9; border-radius: 5px; margin: 15px; padding: 10px;'>
      <p style='width: 100%; text-align: center; font-size: 18px; font-weight: bold;'>Events</p>"
    sorted_data.each do |event|
      html_content += "<div style='width: 40%; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;text-align:justify;'>
          <img src='#{event.get('image')}' alt='Event Image' style='width: 100%; height: 150px; object-fit: cover; border-bottom: 1px solid #ddd;'>
          <div style='padding: 10px; margin: 15px;'>
            <p style='font-weight: bold; color: #333;'>#{event.get('title')}</p>
            <p style='display: block; color: #555;'>#{event.get('description')}</p>
            <p><i class='bi bi-geo'></i>#{event.get('venue')}</p>
            <p style='color: #777;'><i class='bi bi-clock'></i> #{event.get('datetime')}</p>
          </div>
        </div>"
    end
    html_content += "</div>"
    return html_content
  end
   
end