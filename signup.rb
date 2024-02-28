require './Styles/css_styler'

class SignupFormDSL
  attr_accessor :form_attributes, :fields

  def initialize
    @form_attributes = {}
    @fields = []
  end

  def form(attributes = {}, &block)
    @form_attributes.merge!(attributes)
    instance_eval(&block) if block_given?
  end

  def input(name, type, attributes = {})
    @fields << { name: name, type: type, attributes: attributes }
  end

  def button(name, value, attributes = {})
    @fields << { name: name, type: 'submit', value: value, attributes: attributes }
  end

  def generate_signup_form(error_message = nil)
    form_html = CSS_Styler.new().signup_css
    form_html += "<div class='form-container' style='text-align:center'>"
    form_html += "<h1>Sign up</h1>"
    form_html += "<form id='SignupForm' action='/signup' method='post' #{attributes_to_html(@form_attributes)} novalidate>"
    form_html += "<div class='form-group'>"
    form_html += "<input type='name' name='name' placeholder='Enter your name' required />"
    form_html += "</div>"
    form_html += "<div class='form-group'>"
    form_html += "<input type='email' name='email' placeholder='Enter your email' required />"
    form_html += "</div>"
    form_html += "<div class='form-group'>"
    form_html += "<input type='password' name='password' placeholder='Enter your password' required />"
    form_html += "</div>"
    form_html += "<div class='form-group'>"
    form_html += "<input type='password' name='confirm_password' placeholder='Confirm your password' required />"
    form_html += "</div>"
    form_html += "<button class='submit-btn' type='button' onclick='submitForm()'>Sign up</button>"
    form_html += "</form>"
    form_html += "<div class='error-message' style='font-size:13px;'>#{error_message}</div>" if error_message
    form_html += "<p style='font-size:13px;'>Already have an account? <a href='/'>Log in</a></p>"
    form_html += "<script>
                   function submitForm() {
                     document.getElementById('SignupForm').submit();
                   }
                 </script>"
    form_html += "</div>"
    form_html
  end
  
  def save_to_file(filename)
    File.write(filename, generate_signup_form)
  end

  def attributes_to_html(attributes)
    attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
  end
end