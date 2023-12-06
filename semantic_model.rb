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
  end
  define_method :readFile do |filedata|
    File.readlines(filedata).each { |line|
      process_line(line)
    }
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
  def user_exists?(email, password)
    readFile('./Data/users.txt')
    @data.find { |user| user.get('email').downcase == email.downcase && user.get('password') == password }
  end 
  def getJoinedId(iduser,data)
    readFile(data)
    user = @data.find { |user| user.get('id') == iduser }
    if user
      user.get('name')
    end
  end
  def print_table_content_items(type)
    readFile('./Data/content_items.txt')
    table_html = "<table border='1' id='#{type}_table'>
    <p>#{type}</p>
    <tr>
      <th>Título</th>
      <th>Autor</th>
    </tr>"
      @data.each do |content_item|
        if content_item.get('type') == type
          table_html += "<tr onclick=\"window.location='/content_item/#{content_item.get('id')}'\">
                <td>#{content_item.get('title')}</td>
                <td>#{content_item.get('author')}</td>
              </tr>"
          end
        end
      table_html += "</table>"
      return table_html
    end 
  end
  def print_content_item_data(id)
    readFile('./Data/content_items.txt')
    table_html = "<table border='1'>
    <tr>
      <th>Título</th>
      <th>Autor</th>
      <th>Descripción</th>
      <th>Fecha de publicación</th>
    </tr>"
      @data.each do |content_item|
        if content_item.get('id') == id
          table_html += "<tr>
                <td>#{content_item.get('title')}</td>
                <td>#{content_item.get('author')}</td>
                <td>#{content_item.get('description')}</td>
                <td>#{content_item.get('pubdate')}</td>
              </tr>"
          end
        end
      table_html += "</table>"
      return table_html
    end 
    def print_comments(id,joined_reader)
      readFile('./Data/comments.txt')
      table_html = "<table border='1'>
      <p>Comentarios</p>"
        @data.each do |content_item|
          puts content_item.get('content_item_id')
          puts id 
          if content_item.get('content_item_id') == id
            puts content_item.get('user_id')
            user = joined_reader.getJoinedId(content_item.get('user_id'),'./Data/users.txt')
            puts "user=#{user}"
            table_html += 
            "<span>#{content_item.get('pubdate')}</span><br>
            <span><b>#{user}</b>:<br>#{content_item.get('text')}</span></tr><br><br>"
            end
          end
        table_html += "</table>"
        return table_html
      end 
end