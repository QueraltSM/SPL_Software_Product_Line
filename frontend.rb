class Frontend
    
    def login_css
        <<~HTML
        <style>
            body {
                font-family: "Lato", sans-serif;
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
                font-family: "Lato", sans-serif;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                font-family: "Lato", sans-serif;
            }
            input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-family: "Lato", sans-serif;
            }
            .submit-btn {
                background-color: #E3ECD6;
                color: #000;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-family: "Lato", sans-serif;
            }
            .create-account-btn {
                color: #145A32;
                background: #FFFFFF;
                border: none;
                text-align: center;
                text-decoration: none;
                font-size: 13px;
                margin: 4px 2px;
                cursor: pointer;
                font-weight: bold;
            }
            .error-message {
                color: red;
                margin-top: 10px;
            }
        </style>
        HTML
    end

    def signup_css
        <<~HTML
        <style>
          body {
              font-family: "Lato", sans-serif;
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
              font-family: "Lato", sans-serif;
          }
          .form-group {
              margin-bottom: 15px;
          }
          label {
              display: block;
              margin-bottom: 5px;
              font-weight: bold;
              font-family: "Lato", sans-serif;
          }
          input {
              width: 100%;
              padding: 8px;
              box-sizing: border-box;
              border: 1px solid #ccc;
              border-radius: 4px;
              font-family: "Lato", sans-serif;
          }
          .submit-btn {
              background-color: #E3ECD6;
              color: #000;
              padding: 10px;
              border: none;
              border-radius: 5px;
              cursor: pointer;
              width: 100%;
              font-family: "Lato", sans-serif;
          }
          .create-account-btn {
              color: #145A32;
              background: #FFFFFF;
              border: none;
              text-align: center;
              text-decoration: none;
              font-size: 13px;
              margin: 4px 2px;
              cursor: pointer;
          }
          .error-message {
              color: red;
              margin-top: 10px;
          }
        </style>
        HTML
      end  

    def home_header() 
    <<~HTML
      <style>
      .header {
          background-color: #333;
          color: #fff;
          padding: 20px 0;
          text-align: center;
      }
      .container {
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
      }
      .hero {
          text-align: center;
          margin-top: 10px;
          padding: 20px 0;
      }
      .hero h1 {
          font-size: 30px;
          color: #333;
          margin-bottom: 20px;
      }
      .hero p {
          font-size: 18px;
          color: #666;
          margin-bottom: 30px;
      }
      .features {
          display: flex;
          justify-content: center;
          flex-wrap: wrap;
      }
      .feature {
          width: calc(15% - 20px);
          background: linear-gradient(to bottom right, #f5f5f5, #e0e0e0);
          border-radius: 10px;
          padding: 40px;
          margin: 20px;
          text-align: center;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
          transition: transform 0.3s ease;
          cursor: pointer;
      }
      .feature:hover {
          transform: translateY(-10px);
          box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      }
      .feature h2 {
          font-size: 20px;
          color: #333;
          margin-bottom: 10px;
      }
      .feature p {
          font-size: 13px;
          color: #666;
      }
    </style>
    HTML
    end  

    def home_body()
    <<~HTML
    <div class="container">
      <div class="features">
          <div class="feature" onclick="window.location.href = 'News';">
              <i class="fas fa-globe fa-2x"></i>
              <h2>News</h2>
              <p>Stay informed with breaking news and in-depth articles.</p>
          </div>

          <div class="feature" onclick="window.location.href = 'Books';">
              <i class="fas fa-book fa-2x"></i>
              <h2>Books</h2>
              <p>Find your next favorite read.</p>
          </div>

          <div class="feature" onclick="window.location.href = 'Recipes';">
              <i class="fas fa-utensils fa-2x"></i>
              <h2>Recipes</h2>
              <p>Cook up delicious dishes from around the world.</p>
          </div>
          <div class="feature" onclick="window.location.href = 'Movies';">
              <i class="fas fa-film fa-2x"></i>
              <h2>Movies</h2>
              <p>Enjoy blockbuster hits and indie gems.</p>
          </div>
          <div class="feature" onclick="window.location.href = 'Videos';">
              <i class="fas fa-video fa-2x"></i>
              <h2>Videos</h2>
              <p>Watch entertaining and informative videos.</p>
          </div>
          <div class="feature" onclick="window.location.href = 'Music';">
              <i class="fas fa-music fa-2x"></i>
              <h2>Music</h2>
              <p>Listen to the latest tracks and timeless classics.</p>
          </div>

          <div class="feature" onclick="window.location.href = 'Podcasts';">
              <i class="fas fa-podcast fa-2x"></i>
              <h2>Podcasts</h2>
              <p>Listen to insightful discussions and captivating stories.</p>
          </div>

          <div class="feature" onclick="window.location.href = 'Videogames';">
              <i class="fas fa-gamepad fa-2x"></i>
              <h2>Videogames</h2>
              <p>Embark on epic adventures and immerse yourself in virtual worlds.</p>
          </div>
          <div class="feature" onclick="window.location.href = 'Art';">
              <i class="fas fa-paint-brush  fa-2x"></i>
              <h2>Art</h2>
              <p>Explore stunning artworks and creative masterpieces.</p>
          </div>
          <div class="feature" onclick="window.location.href = 'Platforms';">
              <i class="fas fa-link fa-2x"></i>
              <h2>Platforms</h2>
              <p>Find out what's trending and discover hidden gems.</p>
          </div>

          <div class="feature" onclick="window.location.href = '/Events';">
              <i class="fas fa-calendar-alt fa-2x"></i>
              <h2>Events</h2>
              <p>Discover exciting events happening near you.</p>
          </div>
          <div class="feature" onclick="window.location.href = '/Create';">
              <i class="fas fa-plus-circle fa-2x"></i>
              <h2>Create</h2>
              <p>Bring your ideas to life and share them with the world.</p>
          </div>
      </div>
  </div>   
    HTML
    end

    def admin_css()
      <<~HTML
      <style>
        .button-container {
          float: right;
        }
        .button-container button {
          color: #FFF;
          padding: 10px;
          border-radius: 5px;
          margin-left: 10px;
          border: none;
          cursor: pointer;
        }
        .button-container button:hover {
          background: #1D6F9C;
        }
        .text-container {
          font-size: 11px;
          color: #555;
          margin-bottom: 10px;
        }
      </style>
      HTML
    end 
      
    def menu_css()
        <<~HTML
        <head>
        <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
        <style>
          body {
            margin: 0 auto;
            font-family: "Lato", sans-serif;
            color: black;
          }
          .menu {
            background-color: #E3ECD6;
            padding: 10px;
            text-align: center;
          }
          .menu a {
            color: #333;
            text-decoration: none;
            margin: 10px;
            padding: 10px;
            display: inline-block;
            font-size: 14px;
          }
          .menu a:last-child {
            margin-right: 0;
          }
          .menu a:hover {
           color:#1F6F3A;
          }
          .menu .user-info {
            float: right;
          }
          .menu .user-info span {
            color: #333;
            margin-right: 10px;
            font-size: 13px;
          }
          .menu .logout-link {
            color: #333;
            text-decoration: none;
          }
        </style>
        </head>         
        HTML
    end

    def menu_body()
      <<~HTML
      <div class='menu'>
      <a class='logout-link' href='/index' title='Home'><i class='fa fa-home'></i></a>
      <a href='/News'>News</a>
      <a href='/Books'>Books</a>
      <a href='/Recipes'>Recipes</a>
      <a href='/Movies'>Movies</a>
      <a href='/Videos'>Videos</a>
      <a href='/Music'>Music</a>
      <a href='/Podcasts'>Podcasts</a>
      <a href='/Videogames'>Videogames</a>
      <a href='/Art'>Art</a>
      <a href='/Platforms'>Platforms</a>
      <a href='/Events'>Events</a>
      <a href='/Create' title='Create'><i class='fas fa-plus-circle'></i></a>
      <div class='user-info'>
         <span><strong>#{$user_name}</strong></span>
         <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
         </div>
     </div>
     HTML
    end

    def header_events()
      <<~HTML
      <h4 style='text-align: center;
      margin-top: 10px;
      padding: 20px 0;font-size: 30px;
      color: #333;
      margin-bottom: 20px;'>Events</h4>
      HTML
    end

    def search_form_events(sb)
      <<~HTML
      <form id='sort-form' style='margin-top: 20px; margin: 20px;'>
        <div style='display: flex; align-items: center; justify-content: flex-end;'>
          <input type='text' name='search' id='search' placeholder='Search......' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
          <select id='sb' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
            <option value='upcoming' #{'selected' if sb == 'upcoming'}>Upcoming</option>
            <option value='recent' #{'selected' if sb == 'recent'}>Most recents</option>
          </select>
        </div>
      </form>
      <script>
        document.getElementById('search').addEventListener('input', filterEvents);
        document.getElementById('sb').addEventListener('change', function() {
          window.location.href = '/Events?sb=' + this.value;
        });
        function filterEvents() {
          var searchText = this.value;
          var eventContainers = document.querySelectorAll('.event-container');
          Array.from(eventContainers).forEach(function(container) {
            var title = container.querySelector('.event-title').innerText;
            var description = container.querySelector('.event-description').innerText;
            var location = container.querySelector('.event-location').innerText;
            if (title.toLowerCase().includes(searchText.toLowerCase()) || description.toLowerCase().includes(searchText.toLowerCase()) || location.toLowerCase().includes(searchText.toLowerCase())) {
              container.style.display = 'block';
            } else {
              container.style.display = 'none';
            }
          });
        }
      </script>
      HTML
    end
    
    def body_events(event)
      image = event['image']
      title_with_hyphens = event['title'].gsub(' ', '-')
      <<~HTML
      <div onclick="document.getElementById('event_form_#{event['id']}').submit()" class='event-container' style='cursor:pointer; width: 500px; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>
        <form id='event_form_#{event['id']}' action='/Event/#{title_with_hyphens}' method='post' style='display: none;'>
          <input type='hidden' name='event_id' value='#{event['id']}'>
        </form>
        <img src=#{image} style='width: 100%; height: 250px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 20px;'>
          <p class='event-title' style='font-weight: bold; color: #333; font-size: 16px; margin-bottom: 8px;'>#{event['title']}</p>
          <p class='event-location' style='color: #777; font-size: 12px; margin-bottom: 8px;'><i class='bi bi-geo-alt'></i> #{event['location']}</p>
          <p style='color: #777; font-size: 12px;'><i class='bi bi-clock'></i> #{ Date.parse(event['datetime']).strftime("%d/%m/%Y %I:%M")}</p>
        </div>
      </div>
      HTML
    end

    def content_items_header_style(type)
      <<~HTML
      <h4 style='text-align: center;
        margin-top: 10px;
        padding: 20px 0;font-size: 30px;
        color: #333;
        margin-bottom: 20px;'>#{type}
      </h4>
      HTML
    end

    def content_items_search_form(type, sb)
      <<~HTML
      <form id='sort-form' style='margin-top: 20px;margin: 20px;'>
      <div style='display: flex; align-items: center; justify-content: flex-end;'>
        <input type='text' name='search' id='search' placeholder='Search...' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
        <select id='sb' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc; margin-right: 10px;'>
          <option value='date'  #{'selected' if sb == 'date'}>Order by date</option>
          <option value='rating'  #{'selected' if sb == 'rating'}>Order by rating</option>
        </select>
      </div>
      </form>
      <script>
      document.getElementById('sb').addEventListener('change', function() {
        window.location.href = '/#{type}?sb=' + this.value;
      });
      document.getElementById('search').addEventListener('input', function() {
        var searchText = this.value.toLowerCase();
        var contentItems = document.getElementsByClassName('content-item');
        Array.from(contentItems).forEach(function(item) {
          var title = item.querySelector('.title').innerText.toLowerCase();
          var author = item.querySelector('.author').innerText.toLowerCase();
          if (title.includes(searchText) || author.includes(searchText)) {
            item.style.display = 'block';
          } else {
            item.style.display = 'none';
          }
        });
      });
      </script>
      HTML
    end 
    

    def admin_event_actions(event)
      <<~HTML
      <div class='button-container' style='display: flex; align-items: center;'>
      <form action='/edit_event' method='post'>
      <input type='hidden' name='event_id' value="#{event['id']}">
        <button style='background:#2B88C0; margin-right: 10px;'>
          <i class='fas fa-pencil-alt'></i>
        </button>
      </form>
      <form action='/delete_event' method='post'>
      <input type='hidden' name='event_id' value="#{event['id']}">
        <button style='background:#9C3030' onclick="return confirm('Are you sure you want to delete this item?')" title="Delete">
          <i class='fas fa-trash'></i>
        </button>
      </form>
    </div>
    HTML
    end

    def comments_form(content_item_id,sorted_comments) 
      <<~HTML
      <div style='margin: 20px auto; width: 70%;'>
      <div style='border: 1px solid #ddd; border-radius: 10px; overflow: hidden; padding: 20px; background-color: #f9f9f9;'>
      <div style='margin-bottom: 20px;'>
        <form action='/submit_comment' method='post'>
        <input type='hidden' name='content_item_id' value='#{content_item_id}'>
        <input type='hidden' name='comment_user_id' value='#{$user_id}'>
          <textarea placeholder='Add a comment' id='comment_text' name='comment_text' rows='4' cols='50' style='width: 100%; margin-top: 10px;padding:10px;border: none;outline:none'></textarea><br>
          <div style='text-align: right;'>
            <input type='submit' value='Comment' style='margin:10px;background-color: #1F6F3A; color: white; border: none; padding: 10px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
          </div>
        </form>
      </div>
      #{autoResizeTextarea('comment_text')}
      HTML
    end 

    def print_comment(comment,content_item_id,user) 
      <<~HTML
      <div style='padding: 15px; border-radius: 5px;text-align:justify;'>
        <span style='font-weight: bold; color: #333; font-size: 14px;'>#{user}</span>
        <span style='color: #777; margin-left: 10px; font-size: 13px;'>#{comment['pubdate']}</span>
        <p style='margin-top: 10px; color: #555; font-size: 13px; word-wrap: break-word; word-break: break-all;'>#{comment['text']}</p>
        #{if comment['user_id'] == $user_id # Edit and Delete operations if user is owner of the comment
          <<~HTML
          <form id='update_comment' action='/update_comment' method='post' style='margin-top: 10px; display: none;'>
            <input type='hidden' name='content_item_id' value='#{content_item_id}'>
            <input type='hidden' name='comment_id' value='#{comment["id"]}'>
            <textarea name='updated_text' style='width: 100%;' rows='4' cols='50'>#{comment['text']}</textarea><br><br>
            <input type='submit' value='Update' style='background-color: #1F6F3A; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            <button type='button' class='cancel-edit' style='background-color: #D86E6E; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>Cancel</button>
          </form>
          <div style='display: flex; justify-content: flex-end;'>
            <form action='' onsubmit='return false;'>
              <input type='submit' class='edit-button' value='Edit' style='background-color: #2B88C0; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            </form>          
            <form action='/delete_comment' method='post'>
              <input type='hidden' name='content_item_id' value='#{content_item_id}'>
              <input type='hidden' name='comment_id' value='#{comment["id"]}'>
              <input type='submit' value='Delete' style='background-color: #D86E6E; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>
            </form>
          </div>
          <script> 
            document.addEventListener('DOMContentLoaded', function() {
              var editButton = document.querySelector('.edit-button');
              var updateForm = document.querySelector('#update_comment');
              var cancelEditButton = document.querySelector('.cancel-edit');
              editButton.addEventListener('click', function() {
                updateForm.style.display = 'block';
              });
              cancelEditButton.addEventListener('click', function() {
                updateForm.style.display = 'none';
              });
            });
          </script>
          HTML
        end}
      </div>
      HTML
    end
    
    def autoResizeTextarea(id)
      <<~HTML
      <script>
        function autoResizeTextarea() {
          const textarea = document.getElementById('#{id}');
          textarea.style.height = 'auto';
          textarea.style.height = textarea.scrollHeight + 'px';
        }
        document.getElementById('#{id}').addEventListener('input', autoResizeTextarea);
        window.addEventListener('load', autoResizeTextarea);
      </script>
      HTML
    end
    
end