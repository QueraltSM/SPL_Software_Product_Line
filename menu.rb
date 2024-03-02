require_relative './Styles/css_styler'
class Menu
    def self.generate_menu_html()
        styler = CSS_Styler.new()
        menu_html = styler.menu_css()
        menu_html += "<div class='menu'>
                     <a class='logout-link' href='/index'><i class='bi bi-house'></i></a>
                     <a href='/books'>Books</a>
                     <a href='/movies'>Movies</a>
                     <a href='/music'>Music</a>
                     <a href='/videos'>Videos</a>
                     <a href='/recipes'>Recipes</a>
                     <a href='/news'>News</a>
                     <a href='/events'>Events</a>"
  
        if $user_role == "Admin"
            menu_html += "<a style='background:#1F6F3A;color:#FFF;padding:10px;border-radius:5%' href='/create'>Create</a>"
        end
        menu_html += "<div class='user-info'>
                        <span>#{$user_name}</span>
                        <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                        </div>
                    </div>"
      return menu_html
    end
  end
  