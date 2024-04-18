require_relative './frontend'
class Menu
    def self.generate_menu_html()
        menu_html = Frontend.new().menu_css()
        menu_html += "<div class='menu'>
                     <a class='logout-link' href='/index' title='Home'><i class='fa fa-home'></i></a>
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
                     <a href='/create' title='Create'><i class='fas fa-plus-circle'></i></a>
                     <div class='user-info'>
                        <span>#{$user_name}</span>
                        <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
                        </div>
                    </div>"
      return menu_html
    end
  end
  