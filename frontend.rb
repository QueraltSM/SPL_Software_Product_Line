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
        background: linear-gradient(135deg, #f5f5f5, #e0e0e0, #f5f5f5);
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
          font-size: 18px;
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
                <i class="fas fa-globe fa-1x"></i>
                <h2>News</h2>
                <p>Stay informed with breaking news and in-depth articles.</p>
            </div>

            <div class="feature" onclick="window.location.href = 'Books';">
                <i class="fas fa-book fa-1x"></i>
                <h2>Books</h2>
                <p>Find your next favorite read.</p>
            </div>

            <div class="feature" onclick="window.location.href = 'Recipes';">
                <i class="fas fa-utensils fa-1x"></i>
                <h2>Recipes</h2>
                <p>Cook up delicious dishes from around the world.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Movies';">
                <i class="fas fa-film fa-1x"></i>
                <h2>Movies</h2>
                <p>Enjoy blockbuster hits and indie gems.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Videos';">
                <i class="fas fa-video fa-1x"></i>
                <h2>Videos</h2>
                <p>Watch entertaining and informative videos.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Music';">
                <i class="fas fa-music fa-1x"></i>
                <h2>Music</h2>
                <p>Listen to the latest tracks and timeless classics.</p>
            </div>

            <div class="feature" onclick="window.location.href = 'Podcasts';">
                <i class="fas fa-podcast fa-1x"></i>
                <h2>Podcasts</h2>
                <p>Listen to insightful discussions and captivating stories.</p>
            </div>

            <div class="feature" onclick="window.location.href = 'Videogames';">
                <i class="fas fa-gamepad fa-1x"></i>
                <h2>Videogames</h2>
                <p>Embark on epic adventures and immerse yourself in virtual worlds.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Art';">
                <i class="fas fa-paint-brush  fa-1x"></i>
                <h2>Art</h2>
                <p>Explore stunning artworks and creative masterpieces.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Platforms';">
                <i class="fas fa-link fa-1x"></i>
                <h2>Platforms</h2>
                <p>Find out what's trending and discover hidden gems.</p>
            </div>

            <div class="feature" onclick="window.location.href = '/Events';">
                <i class="fas fa-calendar-alt fa-1x"></i>
                <h2>Events</h2>
                <p>Discover exciting events happening near you.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Create';">
                <i class="fas fa-plus-circle fa-1x"></i>
                <h2>Create</h2>
                <p>Bring your ideas to life and share them with the world.</p>
            </div>
        </div>
    </div>   
    HTML
    end

    def edit_content_item_form(content_item)
      <<~HTML
      <br><br>
      <h4 style='text-align: center;
      margin-top: 10px;
      padding: 20px 0;font-size: 30px;
      color: #333;
      margin-bottom: 20px;'>Edition of content</h4>
      <form action='/edit_item' method='post' style='max-width: 70%; margin: 0 auto; padding: 20px;'>
        <input type='hidden' name='_method' value='put'>
        <input type='hidden' name='content_item_id' value="#{content_item['id']}">
  
        <div class='form-group' style='padding-bottom:20px;'>
        <label for='title' id='title-label' style='display: none; display: block; font-weight: bold;'>Title</label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the title of the content.</p>
        <input type='text' id='title' value='#{content_item["title"]}' name='title' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' required>
        </div>
    
        <div class='form-group' id='source-div' style='padding-bottom:20px;'>
        <label id="source-label" for='source' style='display: none; display: block; font-weight: bold;'></label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the source of the content.</p>
        <input type='text' id='source'  value='#{content_item["source"]}' name='source' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
    
  
        <div class='form-group' style='padding-bottom:20px;'>
        <label for='description' style='display: none; display: block; font-weight: bold;'>Description</label>
        <p id="description-label" style="font-size:13px;color:#9e9e9e;"></p>
        <textarea id='description' name='description' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px; height: 150px;' required>#{content_item["description"]}</textarea>
        </div>
  
  
        <div id='url-div' class='form-group' style='padding-bottom:20px;'>
        <label for='media' style='display: block; font-weight: bold;'>Media URL</label>
        <p style="font-size:13px;color:#9e9e9e;" id="url-label"></p>
        <input type='url' id='digital_content'  value='#{content_item["digital_content"]}' name='digital_content' class='form-control' style='width: 100%; margin-top: 10px; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
    
  
        <div class='form-group' id='location-div' style='padding-bottom:20px;'>
        <label for='location' style='display: none; display: block; font-weight: bold;'>Location</label>
        <p style="font-size:13px;color:#9e9e9e;">Please enter the complete address.</p>
        <input type='text' id='location' name='location' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
  
          <div class='form-group'  id='datetime-div' style='padding-bottom:20px;'>
          <label for='datetime' style='display: none; display: block; font-weight: bold;'>Date and time</label>
          <p style="font-size:13px;color:#9e9e9e;">Please select the date and time of the event.</p>
          <input type='datetime-local' id='datetime' name='datetime' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
  
        <div class='form-group' id='date-div' style='padding-bottom:50px;'>
        <label for='date' style='display: none; display: block; font-weight: bold;'>Date of released</label>
        <p style="font-size:13px;color:#9e9e9e;">Select the date of released.</p>
        <input type='date' id='date'  value='#{content_item["date"]}' name='date' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' min="1970-01-01" step="1">
        </div>
    
        <div style='text-align: center;padding-bottom:50px;'>
        <button type='submit' class='btn btn-primary' style='width: 10%; padding: 10px; font-weight:bold; background-color: #E3ECD6; border: none; color: #000; border-radius: 3px; cursor: pointer;'>Update</button>
        </div>
      </form>
  
      <script>
        if ("#{content_item["type"]}" === "News") {
          document.getElementById('datetime-div').style.display = 'none';
          document.getElementById('location-div').style.display = 'none';
          document.getElementById("source-label").innerHTML = "Source";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";
        }
        if ("#{content_item["type"]}" === 'Events') {
          document.getElementById('datetime-div').style.display = 'block';
          document.getElementById('location-div').style.display = 'block';
          document.getElementById('date-div').style.display = 'none';
          document.getElementById('source-div').style.display = 'none';
          document.getElementById('url-div').style.display = 'none';
          document.getElementById("datetime").required = true;
          document.getElementById("location").required = true;
        } else {
          document.getElementById('datetime-div').style.display = 'none';
          document.getElementById('location-div').style.display = 'none';
          document.getElementById('date-div').style.display = 'block';
          document.getElementById('source-div').style.display = 'block';
          document.getElementById('url-div').style.display = 'block';
          document.getElementById("date").required = true;
          document.getElementById("source").required = true;
          document.getElementById("digital_content").required = true;
        }
        if ("#{content_item["type"]}" === "News") {
          document.getElementById("source-label").innerHTML = "Source";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";
          document.getElementById("description-label").innerHTML = "Please provide a detailed description of the content. You can insert HTML code or plain text";
        } else if ("#{content_item["type"]}" === "Books") {
          document.getElementById("source-label").innerHTML = "Author";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the book cover image.";
        } else if ("#{content_item["type"]}" === "Recipes") {
          document.getElementById("source-label").innerHTML = "Chef";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the dish's photo.";
        } else if ("#{content_item["type"]}" == "Movies") {
          document.getElementById("source-label").innerHTML = "Director";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the movie trailer. It can be from YouTube or Vimeo.";
        } else if ("#{content_item["type"]}" === "Videos") {
          document.getElementById("source-label").innerHTML = "Channel";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the video. It can be from YouTube or Vimeo.";
        } else if ("#{content_item["type"]}" == "Music") {
          document.getElementById("source-label").innerHTML = "Singer / Band";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the music video. It can be from YouTube or Vimeo.";
        } else if ("#{content_item["type"]}" === "Podcasts") {
          document.getElementById("source-label").innerHTML = "Podcast Host";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image for the podcast cover.";
          document.getElementById("description-label").innerHTML = "Include a comprehensive description of the episode or podcast, covering details like where it can be found across different platforms, URLs or hosting platforms.";
        } else if ("#{content_item["type"]}" === "Videogames") {
          document.getElementById("source-label").innerHTML = "Company";
          document.getElementById("url-label").innerHTML = "Please enter the URL of an image for the game cover.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the game, including its genre, gameplay features and any other relevant information.";
        }  else if ("#{content_item["type"]}" === "Art") {
          document.getElementById("source-label").innerHTML = "Creator";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image of the artwork.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the artwork, like information about the artistic style, the technique used, the theme or meaning of the artwork, historical or cultural context, and any other relevant details you'd like to share.";
        } else if ("#{content_item["type"]}" === "Platforms") {
          document.getElementById("source-label").innerHTML = "Publisher / Company";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the platform's logo or icon.";
          document.getElementById("description-label").innerHTML = "Provide a comprehensive description of the platform, including details about its purpose, target audience, features, usability, and any other relevant information you want to share.";
        }
      </script>      
      HTML
    end
    

    def content_item_body_style(content_item)
      base64_image = image_url_to_base64(content_item['digital_content'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        if content_item['type'] == 'Books'
          <<~HTML
          <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
          <div class='thumbnail' name="image-container" style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div>
            <div style='margin-left: 20px;'>
                    <h2 style='color: #333;'>#{content_item['title']}</h2>
                    <div style='margin-top: 15px;'>
                    <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{content_item['author']}</p>
                    <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Released</strong> #{content_item['pubdate']}</p>
                    #{rating_html(content_item['rating']) if content_item['rating'] != -1}
                    </div>
                  <pre style='color: #555; white-space: pre-wrap;'>#{content_item['description']}</pre>
                </div>
              </div>
          </div>
          HTML
          elsif content_item['type'] == 'Videos' ||  content_item['type'] == 'Movies'
            <<~HTML
            <div style='padding: 20px; font-size: 16px; display: flex; flex-direction: column; align-items: flex-start;'>
            <h3 style='color: #444; font-size: 26px; margin: 10px; font-weight: bold; text-transform: uppercase;'>#{content_item['title']}</h3>
            <div style='width: 100%; border-radius: 10px; overflow: hidden;'>
              <iframe width='100%' height='600' style='border: none; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);' src='#{content_item["digital_content"]}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>
            </div>
            <div style='margin-top: 15px;'>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>#{(content_item['type'] == 'Movies') ? 'Director' : 'Channel' }</strong> #{content_item['author']}</p>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Released</strong> #{content_item['pubdate']}</p>
              #{rating_html(content_item['rating']) if content_item['rating'] != -1}
            </div>
            <div style='margin-top: 20px;'>
              <p style='color: #555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;'>#{content_item['description']}</p>
            </div>
          </div>
          HTML
        elsif content_item['type'] == 'News'
          <<~HTML
          <div style='padding: 20px; font-size: 15px;'>
            <h2 style='color: #333; margin: 20px;text-align:center;'>#{content_item['title']}</h2>
            <div style="display: flex; justify-content: center; margin-bottom: 15px;">
              <img src='data:image/jpeg;base64,#{base64_image}' style="max-width: 100%; border-radius: 5px;">
            </div>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>#{content_item['source']}</strong></p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on:</strong> #{ Date.parse(content_item['date']).strftime("%d/%m/%Y")}</p>
            <p style='color: #555; font-size: 14px; line-height: 1.6; text-align: justify;'>#{content_item['description']}</p>
         </div>
          HTML
        else
          <<~HTML
          <div style='padding: 20px;font-size:15px'>
            <h2 style='color: #333;'>#{content_item['title']}</h2>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{content_item['author']}</p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on</strong> #{ Date.parse(content_item['date']).strftime("%d/%m/%Y")}</p>
            <div style='display: flex; justify-content: center;'><div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div></div>
            <pre style='color: #555; white-space: pre-wrap;'>#{content_item['description']}</pre>
          </div>
          </div>
          HTML
        end
      end
    end

    def content_item_body_image(content_item, base64_image)
      title_with_hyphens = content_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <form class='content-item' action='/#{content_item['type']}/#{title_with_hyphens}' method='post' style='text-align:center;cursor: pointer; width: 30%; margin: 10px; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); background-color: #f9f9f9;'>
        <input type='hidden' name='content_item_id' value='#{content_item['id']}'>
        <button type='submit' style='background: none; border: none; padding: 0; margin: 0;width:100%;cursor: pointer;'>
          <div style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover; height: 300px; width: 100%;'></div>
          <div style='padding-top: 15px;'>
            <h3 class='title' style='font-size: 18px; font-weight: bold; color: #333; margin-bottom: 8px;'>#{content_item['title']}</h3>
            <p class='author' style='color: #555; font-size: 14px; margin-top: 5px;'>#{content_item['source']}</p>
          </div>
        </button>
      </form>
      HTML
    end  

    def content_item_body_video(content_item, embedded_video)
      title_with_hyphens = content_item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <form action='/#{content_item['type']}/#{title_with_hyphens}' method='post' style='text-align:center;cursor: pointer; width: 30%; margin: 10px; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); background-color: #f9f9f9;'>
      <input type='hidden' name='content_item_id' value='#{content_item['id']}'>
        <button type='submit' style='background: none; border: none; padding: 0; margin: 0;width:100%;cursor: pointer;'>
          #{embedded_video}
          <div class='info' style='padding-top: 15px;'>
            <h3 class='title' style='font-size: 18px; font-weight: bold; color: #333; margin-bottom: 8px;'>#{content_item['title']}</h3>
            <p class='author' style='color: #555; font-size: 14px; margin-top: 5px;'>#{content_item['source']}</p>
          </div>
        </button>
      </form>
      HTML
    end 


    def creation_content_item_form
      <<~HTML
      <br><br>
      <h4 style='text-align: center;
      margin-top: 10px;
      padding: 20px 0;font-size: 30px;
      color: #333;
      margin-bottom: 20px;'>Creation of new digital content</h4>
      <form action='/create_item' method='post' style='max-width: 70%; margin: 0 auto; padding: 20px;'>
        <input type='hidden' name='_method' value='put'>

        <div class='form-group' style='padding-bottom:20px;'>
          <label for='type' style='display: block; font-weight: bold;'>Content type</label>
          <p style="font-size:13px;color:#9e9e9e;">Please select the type of multimedia content you want to share.</p>
          <select id='type' name='type' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' onchange='toggleFields()'>
          <option value='News'>News</option>  
          <option value='Books'>Book</option>
          <option value='Recipes'>Recipe</option>  
          <option value='Movies'>Movie</option>
            <option value='Videos'>Video</option>
            <option value='Music'>Music</option>
            <option value='Podcasts'>Podcast</option>
            <option value='Videogames'>Videogame</option>
            <option value='Art'>Art</option>
            <option value='Platforms'>Platform</option>
            <option value='Events'>Event</option>
          </select>
        </div>

        <div class='form-group' style='padding-bottom:20px;'>
        <label for='title' id='title-label' style='display: none; display: block; font-weight: bold;'>Title</label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the title of the content.</p>
        <input type='text' id='title' name='title' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' required>
        </div>
    
        <div class='form-group' id='source-div' style='padding-bottom:20px;'>
        <label id="source-label" for='source' style='display: none; display: block; font-weight: bold;'></label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the source of the content.</p>
        <input type='text' id='source' name='source' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
    

        <div class='form-group' style='padding-bottom:20px;'>
        <label for='description' style='display: none; display: block; font-weight: bold;'>Description</label>
        <p id="description-label" style="font-size:13px;color:#9e9e9e;"></p>
        <textarea id='description' name='description' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px; height: 150px;' required></textarea>
        </div>


        <div id='url-div' class='form-group' style='padding-bottom:20px;'>
        <label for='media' style='display: block; font-weight: bold;'>Media URL</label>
        <p style="font-size:13px;color:#9e9e9e;" id="url-label"></p>
        <input type='url' id='digital_content' name='digital_content' class='form-control' style='width: 100%; margin-top: 10px; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' required>
        </div>
    

        <div class='form-group' id='location-div' style='padding-bottom:20px;'>
        <label for='location' style='display: none; display: block; font-weight: bold;'>Location</label>
        <p style="font-size:13px;color:#9e9e9e;">Please enter the complete address.</p>
        <input type='text' id='location' name='location' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>

        <div class='form-group'  id='datetime-div' style='padding-bottom:20px;'>
        <label for='datetime' style='display: none; display: block; font-weight: bold;'>Date and time</label>
        <p style="font-size:13px;color:#9e9e9e;">Please select the date and time of the event.</p>
        <input type='datetime-local' id='datetime' name='datetime' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>

        <div class='form-group' id='date-div' style='padding-bottom:50px;'>
        <label for='date' style='display: none; display: block; font-weight: bold;'>Date of released</label>
        <p style="font-size:13px;color:#9e9e9e;">Select the date of released.</p>
        <input type='date' id='date' name='date' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' min="1970-01-01" step="1">
        </div>
    
        <div style='text-align: center;padding-bottom:50px;'>
        <button type='submit' class='btn btn-primary' style='width: 10%; padding: 10px; font-weight:bold; background-color: #E3ECD6; border: none; color: #000; border-radius: 3px; cursor: pointer;'>Publish</button>
        </div>
      </form>

      <script>
      document.getElementById('datetime-div').style.display = 'none';
      document.getElementById('location-div').style.display = 'none';
      document.getElementById("source-label").innerHTML = "Source";
      document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";

      function toggleFields() {
        var type = document.getElementById('type').value;
        if (type === 'Events') {
          document.getElementById('datetime-div').style.display = 'block';
          document.getElementById('location-div').style.display = 'block';
          document.getElementById('date-div').style.display = 'none';
          document.getElementById('source-div').style.display = 'none';
          document.getElementById("datetime").required = true;
          document.getElementById("location").required = true;
        } else {
          document.getElementById('datetime-div').style.display = 'none';
          document.getElementById('location-div').style.display = 'none';
          document.getElementById('date-div').style.display = 'block';
          document.getElementById('source-div').style.display = 'block';
          document.getElementById('url-div').style.display = 'block';
          document.getElementById("date").required = true;
          document.getElementById("source").required = true;
        }

        if (document.getElementById('type').value == "News") {
          document.getElementById("source-label").innerHTML = "Source";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";
          document.getElementById("description-label").innerHTML = "Please provide a detailed description of the content. You can insert HTML code or plain text";
        } else if (document.getElementById('type').value == "Books") {
          document.getElementById("source-label").innerHTML = "Author";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the book cover image.";
        } else if (document.getElementById('type').value == "Recipes") {
          document.getElementById("source-label").innerHTML = "Chef";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the dish's photo.";
        } else if (document.getElementById('type').value == "Movies") {
          document.getElementById("source-label").innerHTML = "Director";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the movie trailer. It can be from YouTube or Vimeo.";
        } else if (document.getElementById('type').value == "Videos") {
          document.getElementById("source-label").innerHTML = "Channel";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the video. It can be from YouTube or Vimeo.";
        } else if (document.getElementById('type').value == "Music") {
          document.getElementById("source-label").innerHTML = "Singer / Band";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the music video. It can be from YouTube or Vimeo.";
        } else if (document.getElementById('type').value == "Podcasts") {
          document.getElementById("source-label").innerHTML = "Podcast Host";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image for the podcast cover.";
          document.getElementById("description-label").innerHTML = "Include a comprehensive description of the episode or podcast, covering details like where it can be found across different platforms, URLs or hosting platforms.";
        } else if (document.getElementById('type').value == "Videogames") {
          document.getElementById("source-label").innerHTML = "Company";
          document.getElementById("url-label").innerHTML = "Please enter the URL of an image for the game cover.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the game, including its genre, gameplay features and any other relevant information.";
        }  else if (document.getElementById('type').value == "Art") {
          document.getElementById("source-label").innerHTML = "Creator";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image of the artwork.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the artwork, like information about the artistic style, the technique used, the theme or meaning of the artwork, historical or cultural context, and any other relevant details you'd like to share.";
        } else if (document.getElementById('type').value == "Platforms") {
          document.getElementById("source-label").innerHTML = "Publisher / Company";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the platform's logo or icon.";
          document.getElementById("description-label").innerHTML = "Provide a comprehensive description of the platform, including details about its purpose, target audience, features, usability, and any other relevant information you want to share.";
        } else if (document.getElementById('type').value == "Events") {
          document.getElementById("source-label").innerHTML = "Creator";
          document.getElementById("url-label").innerHTML = "Please enter the URL of an image related to the event.";
          document.getElementById("description-label").innerHTML = "Provide a comprehensive description of the event, including details about its purpose, target audience, features, and any other relevant information you want to share.";
        }        
      }
      </script>      
      HTML
    end

    def owner_css()
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

    def owner_actions(content_item)
      <<~HTML
      <div class='button-container' style='display: flex; align-items: center;'>
        <form action='/edit' method='post'>
          <input type='hidden' name='content_item_id' value="#{content_item['id']}" title="Edit">
          <button style='background:#2B88C0; margin-right: 10px;'>
            <i class='fas fa-pencil-alt'></i>
          </button>
        </form>
        <form action='/delete_content_item' method='post'>
          <input type='hidden' name='content_item_id' value="#{content_item['id']}">
          <button style='background:#9C3030' onclick="return confirm('Are you sure you want to delete this item?')" title="Delete">
            <i class='fas fa-trash'></i>
          </button>
        </form>
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
      title_with_hyphens = event['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
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

    def body_event(event)
      <<~HTML
      <div class='event-container' style='width: 500px; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>
        <img src='#{event['image']}' style='width: 100%; height: 250px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 20px;'>
          <p class='event-title' style='font-weight: bold; color: #333; font-size: 16px; margin-bottom: 8px;'>#{event['title']}</p>
          <p class='event-description' style='color: #555; font-size: 13px; margin-bottom: 8px;'>#{event['description']}</p>
          <p class='event-location' style='color: #777; font-size: 12px; margin-bottom: 8px;'><i class='bi bi-geo-alt'></i> #{event['location']}</p>
          <p style='color: #777; font-size: 12px;'><i class='bi bi-clock'></i> #{DateTime.parse(event['datetime']).strftime("%d/%m/%Y %I:%M")}</p>
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
      <div style='border-radius: 5px;text-align:justify;'>
        <span style='font-weight: bold; color: #333; font-size: 14px;'>#{user}</span>
        <span style='color: #777; margin-left: 10px; font-size: 12px;'>#{comment['pubdate']}</span>
        <p style='margin-top: 10px; color: #555; font-size: 13px; word-wrap: break-word; word-break: break-all;'>#{comment['text']}</p>
        #{if comment['user_id'] == $user_id
          <<~HTML
          <form id='update_comment_#{comment["id"]}' action='/update_comment' method='post' style='margin-top: 10px; display: none;'>
            <input type='hidden' name='content_item_id' value='#{content_item_id}'>
            <input type='hidden' name='comment_id' value='#{comment["id"]}'>
            <textarea name='updated_text' style='width: 100%;' rows='4' cols='50'>#{comment['text']}</textarea><br><br>
            <input type='submit' value='Update' style='background-color: #1F6F3A; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            <button type='button' id='cancel-button_#{comment["id"]}' class='cancel-edit' style='background-color: #9C3030; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>Cancel</button>
          </form>
          <div style='display: flex; justify-content: flex-end;'>
            <form action='update_comment_#{comment["id"]}' onsubmit='return false;'>
              <input type='hidden' name='comment_id' value='#{comment["id"]}'>
              <input type='submit' id='edit-button_#{comment["id"]}' class='edit-button' value='Edit' style='background-color: #2B88C0; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            </form>
            <form action='/delete_comment' method='post'>
              <input type='hidden' name='content_item_id' value='#{content_item_id}'>
              <input type='hidden' name='comment_id' value='#{comment["id"]}'>
              <input type='submit' value='Delete' style='background-color: #9C3030; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>
            </form>
          </div>
          <script>
              document.getElementById('edit-button_#{comment["id"]}').addEventListener('click', function() {
                document.getElementById('update_comment_#{comment["id"]}').style.display = 'block';
              }); 
              document.getElementById('cancel-button_#{comment["id"]}').addEventListener('click', function() {
                document.getElementById('update_comment_#{comment["id"]}').style.display = 'none';
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

    def image_url_to_base64(image_url)
      begin
        uri = URI.parse(image_url)
        response = Net::HTTP.get_response(uri)
    
        if response.is_a?(Net::HTTPSuccess)
          image_data = response.body
          base64_data = Base64.strict_encode64(image_data)
          return base64_data
        else
          puts "Error: Unable to fetch the image. HTTP response code: #{response.code}"
          return nil
        end
      rescue StandardError => e
        puts "Error: #{e.message}"
        return nil
      end
    end

    def rating_html(rating)
      "<p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Rating</strong> #{rating}</p>"
    end

    def rating_body(content_item_id, content_rating)
      html = <<~HTML
        <p style='font-size:13px;color:#9e9e9e;text-align:center'>Rating is now #{content_rating}</p>
        <div style='margin-bottom: 20px;'>
          <form id='ratingForm' action='/update_rating' method='post' onsubmit='return confirmRating();'>
            <input type='hidden' name='content_item_id' value='#{content_item_id}'>
            <input type='hidden' name='rating' id='selectedRating'>
            <div style='text-align: center;'>
              <div class='rating'>
                HTML
                (1..10).each do |i|
                  html += "<input type='radio' id='star#{i}' name='rating' value='#{i}' onclick='setSelectedRating(#{i})' #{'checked' if i == content_rating}><label for='star#{i}'></label>"
                end
                html += <<~HTML
              </div><br>
              <input id='submitBtn' type='submit' value='Rate' style='background-color: #1F6F3A; color: white; border: none; padding:10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
            </div>
          </form>
        </div>
        <script>
          function setSelectedRating(starValue) {
            document.getElementById('selectedRating').value = starValue;
            document.getElementById('submitBtn').value = 'Rate';
          }
          function confirmRating() {
            return confirm('Are you sure you want to submit this rating?');
          }
        </script>
      HTML
      return html
    end  
end