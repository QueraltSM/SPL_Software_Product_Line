require_relative './Styles/css_styler'
class Menu
    def self.generate_menu_html()
        styler = CSS_Styler.new()
        menu_html = styler.menu_css()
        menu_html += "<div class='menu'>
                     <a class='logout-link' href='/index'><i class='bi bi-house'></i></a>
                     <a href='/content/News'>News</a>
                     <a href='/content/Books'>Books</a>
                     <a href='/content/Recipes'>Recipes</a>
                     <a href='/content/Movies'>Movies</a>
                     <a href='/content/Videos'>Videos</a>
                     <a href='/content/Music'>Music</a>
                     <a href='/content/Podcasts'>Podcasts</a>
                     <a href='/content/Videogames'>Videogames</a>
                     <a href='/content/Art'>Art</a>
                     <a href='/content/Platforms'>Platforms</a>
                     <a href='/Events'>Events</a>
                     <a href='/create'>Create</a>"
    
        menu_html += "<div class='user-info'>
                        <span>#{$user_name}</span>
                        <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                        </div>
                    </div>"
      return menu_html
    end
  end
  