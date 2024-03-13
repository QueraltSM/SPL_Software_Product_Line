require_relative './Styles/css_styler'
class Menu
    def self.generate_menu_html()
        styler = CSS_Styler.new()
        menu_html = styler.menu_css()
        menu_html += "<div class='menu'>
                     <a class='logout-link' href='/index'><i class='bi bi-house'></i></a>
                     <a href='/content/Books'>Books</a>
                     <a href='/content/Movies'>Movies</a>
                     <a href='/content/Music'>Music</a>
                     <a href='/content/Videos'>Videos</a>
                     <a href='/content/Recipes'>Recipes</a>
                     <a href='/content/News'>News</a>
                     <a href='/Events'>Events</a>"
        if $user_role == "Admin"
            menu_html += "<a style='background:#1F6F3A;color:#FFF;padding:10px;border-radius:5%' href='/create_content'>Create new</a>"
        end
        menu_html += "<div class='user-info'>
                        <span>#{$user_name}</span>
                        <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                        </div>
                    </div>"
      return menu_html
    end
  end
  