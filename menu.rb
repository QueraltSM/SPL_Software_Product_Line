require_relative './frontend'
class Menu
    def self.generate_menu_html()
      menu_html = Frontend.new().menu_css()
      menu_html += Frontend.new().menu_body()
    return menu_html
  end
end