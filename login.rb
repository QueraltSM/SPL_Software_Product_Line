require './Styles/css_styler'

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
  
    def generate_login_form(error_message = nil)
      form_html = CSS_Styler.new().login_css
      form_html += "<div class='form-container' style='text-align:center'>"
      form_html += "<h1>Welcome</h1><p>Log in to continue.</p><form id='loginForm' #{attributes_to_html(@form_attributes)} novalidate>"
      @fields.each do |field|
        form_html += "<div class='form-group'>"
        form_html += "<label for='#{field[:name]}' required>#{field[:label]}</label>"
        form_html += "<input type='#{field[:type]}' name='#{field[:name]}' #{attributes_to_html(field[:attributes])} required />"
        form_html += "</div>"
      end
      form_html += "<button class='submit-btn' type='button' onclick='submitForm()'>Login</button></form>"
      form_html += "<div class='error-message' style='font-size:13px;'>#{error_message}</div>" if error_message
      form_html += "<button class='create-account-btn' onclick='createAccount()'>Sign up</button>"
      form_html += "<script>
                     function submitForm() {
                       document.getElementById('loginForm').submit();
                     }
                     function createAccount() {
                        window.location = '/signup'; 
                     }
                   </script></div>"
    end
    
    
    def save_to_file(filename)
        File.write(filename, generate_login_form)
      end
  
    def attributes_to_html(attributes)
      attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
    end
  end
  