require './Styles/css_styler'

class Authenticator
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

  def generate_form(form_type, error_message = nil)
    css_styler = CSS_Styler.new
    form_html = css_styler.send("#{form_type}_css")
    form_html += "<div class='form-container' style='text-align:center'>"
    form_html += "<h1>#{form_type.capitalize}</h1>"
    form_html += "<form id='#{form_type}Form' action='#{form_type == 'login' ? '/login' : '/signup'}' method='post' #{attributes_to_html(@form_attributes)} novalidate>"
    @fields.each do |field|
      form_html += "<div class='form-group'>"
      form_html += "<input type='#{field[:type]}' name='#{field[:name]}' placeholder='Enter your #{field[:name]}' required />"
      form_html += "</div>"
    end
    form_html += "<button class='submit-btn' type='button' onclick='submitForm()'><strong>#{form_type.capitalize}</strong></button>"
    form_html += "</form>"
    form_html += "<div class='error-message' style='font-size:13px;'>#{error_message}</div>" if error_message
    form_html += "<p style='font-size:13px;'>#{form_type == 'login' ? "Don't have an account? <a href='/signup' style='color:#1F6F3A'>Sign up</a>" : "Already have an account? <a href='/login'>Log in</a>"}</p>"
    form_html += "<script>
                   function submitForm() {
                     document.getElementById('#{form_type}Form').submit();
                   }
                 </script>"
    form_html += "</div>"
    form_html
  end

  def save_to_file(filename, form_type, error_message = nil)
    File.write(filename, generate_form(form_type, error_message))
  end

  def attributes_to_html(attributes)
    attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
  end
end
