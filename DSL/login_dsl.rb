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
      form_html = "<style>
                      body {
                        font-family: 'Verdana', sans-serif;
                        background-color: #f0f0f0;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        height: 100vh;
                      }
                      .form-container {
                        max-width: 400px;
                        width: 100%;
                        padding: 20px;
                        background-color: #fff;
                        border-radius: 5px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                        font-family: 'Verdana', sans-serif;
                      }
                      .form-group {
                        margin-bottom: 15px;
                      }
                      label {
                        display: block;
                        margin-bottom: 5px;
                        font-weight: bold;
                        font-family: 'Verdana', sans-serif;
                      }
                      input {
                        width: 100%;
                        padding: 8px;
                        box-sizing: border-box;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        font-family: 'Verdana', sans-serif;
                      }
                      .submit-btn {
                        background-color: #E3ECD6;
                        color: #000;
                        padding: 10px;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        width: 100%;
                        font-family: 'Verdana', sans-serif;
                      }
                      .error-message {
                        color: red;
                        margin-top: 10px;
                      }
                  </style>"
    
      form_html += "<div class='form-container' style='text-align:center'>"
      form_html += "<h1>Welcome</h1>"
      form_html += "<p>Log in to continue.</p>"                
      form_html += "<form id='loginForm' #{attributes_to_html(@form_attributes)} novalidate>"
      @fields.each do |field|
        form_html += "<div class='form-group'>"
        form_html += "<label for='#{field[:name]}' required>#{field[:label]}</label>"
        form_html += "<input type='#{field[:type]}' name='#{field[:name]}' #{attributes_to_html(field[:attributes])} required />"
        form_html += "</div>"
      end
      form_html += "<button class='submit-btn' type='button' onclick='submitForm()'>Login</button>"
      form_html += "</form>"
      form_html += "<div class='error-message'>#{error_message}</div>" if error_message
      form_html += "<script>
                     function submitForm() {
                       document.getElementById('loginForm').submit();
                     }
                   </script>"
      form_html += "</div>"
    end
    
    
    def save_to_file(filename)
        File.write(filename, generate_login_form)
      end

    private
  
    def attributes_to_html(attributes)
      attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
    end
  end
  