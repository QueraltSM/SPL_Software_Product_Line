class LoginFormDSL
    attr_accessor :form_attributes, :fields
  
    def initialize
      @form_attributes = {}
      @fields = []
    end
  
    def form(attributes = {}, &block)
      @form_attributes = attributes
      instance_eval(&block) if block_given?
    end
  
    def input(name, type, attributes = {})
      @fields << { name: name, type: type, attributes: attributes }
    end

    def button(name, value, attributes = {})
      @fields << { name: name, type: 'submit', value: value, attributes: attributes }
    end
  
    def generate_html
      form_html = "<form #{attributes_to_html(@form_attributes)}>"
      @fields.each do |field|
        form_html += "<input type='#{field[:type]}' name='#{field[:name]}' #{attributes_to_html(field[:attributes])} />"
      end
      form_html += "</form>"
    end

    def save_to_file(filename)
        File.write(filename, generate_html)
      end

    private
  
    def attributes_to_html(attributes)
      attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
    end
  end
  