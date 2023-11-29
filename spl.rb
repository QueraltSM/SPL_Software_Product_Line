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
semantic_model = eval File.read('user_dsl.rb')

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
    values = line.split(/\s*,\s*/)
    values.map! {|valor| valor.strip}
    @data << entity_class_data.new(*values)
  end
  def print
    @data.each { |i|
      puts i
    }
  end
end

users_reader = UsersReader.new()
users_reader.readFile("users.txt")
users_reader.print
