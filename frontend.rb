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
          max-width: 80%;
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
          width: 100%;
          padding-top: 20px;
      }
      .feature {
        width: calc(10% - 10px);
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
            <div class="feature" onclick="window.location.href = '/News';">
                <i class="fas fa-globe fa-1x"></i>
                <h2>News</h2>
                <p>Stay informed with breaking news and in-depth articles.</p>
            </div>
            <div class="feature" onclick="window.location.href = 'Books';">
                <i class="fas fa-book fa-1x"></i>
                <h2>Books</h2>
                <p>Find your next favorite read.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Recipes';">
                <i class="fas fa-utensils fa-1x"></i>
                <h2>Recipes</h2>
                <p>Cook up delicious dishes from around the world.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Movies';">
                <i class="fas fa-film fa-1x"></i>
                <h2>Movies</h2>
                <p>Enjoy blockbuster hits and indie gems.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Videos';">
                <i class="fas fa-video fa-1x"></i>
                <h2>Videos</h2>
                <p>Watch entertaining and informative videos.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Music';">
                <i class="fas fa-music fa-1x"></i>
                <h2>Music</h2>
                <p>Listen to the latest tracks and timeless classics.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Podcasts';">
                <i class="fas fa-podcast fa-1x"></i>
                <h2>Podcasts</h2>
                <p>Listen to insightful discussions and captivating stories.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Videogames';">
                <i class="fas fa-gamepad fa-1x"></i>
                <h2>Videogames</h2>
                <p>Embark on epic adventures and immerse yourself in virtual worlds.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Art';">
                <i class="fas fa-paint-brush  fa-1x"></i>
                <h2>Art</h2>
                <p>Explore stunning artworks and creative masterpieces.</p>
            </div>
            <div class="feature" onclick="window.location.href = '/Events';">
                <i class="fas fa-calendar-alt fa-1x"></i>
                <h2>Events</h2>
                <p>Discover exciting events happening near you.</p>
            </div>
        </div>
    </div>   
    HTML
    end

    def edit_item_form(item)
      <<~HTML
      <br><br>
      <h4 style='text-align: center;
      margin-top: 10px;
      padding: 20px 0;font-size: 30px;
      color: #333;
      margin-bottom: 20px;'>Edition of content</h4>
      <form action='/edit_item' method='post' style='max-width: 70%; margin: 0 auto; padding: 20px;'>
        <input type='hidden' name='_method' value='put'>
        <input type='hidden' name='item_id' value="#{item['id']}">
        <div class='form-group' style='padding-bottom:20px;'>
        <label for='title' id='title-label' style='display: none; display: block; font-weight: bold;'>Title</label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the title of the content.</p>
        <input type='text' id='title' value='#{item["title"]}' name='title' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' required>
        </div>
        <div class='form-group' id='source-div' style='padding-bottom:20px;'>
        <label id="source-label" for='source' style='display: none; display: block; font-weight: bold;'></label>
        <p style="font-size:13px;color:#9e9e9e;">Enter the source of the content.</p>
        <input type='text' id='source'  value='#{item["source"]}' name='source' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
        <div class='form-group' style='padding-bottom:20px;'>
        <label for='description' style='display: none; display: block; font-weight: bold;'>Description</label>
        <p id="description-label" style="font-size:13px;color:#9e9e9e;"></p>
        <textarea id='description' name='description' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px; height: 150px;' required>#{item["description"]}</textarea>
        </div>
        <div id='url-div' class='form-group' style='padding-bottom:20px;'>
        <label for='media' style='display: block; font-weight: bold;'>Media URL</label>
        <p style="font-size:13px;color:#9e9e9e;" id="url-label"></p>
        <input type='url' id='media_url'  value='#{item["media_url"]}' name='media_url' class='form-control' style='width: 100%; margin-top: 10px; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
        <div class='form-group' id='date-div' style='padding-bottom:50px;'>
        <label for='date' style='display: none; display: block; font-weight: bold;'>Date of released</label>
        <p style="font-size:13px;color:#9e9e9e;">Select the date of released.</p>
        <input type='date' id='date'  value='#{item["date"]}' name='date' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' min="1970-01-01" step="1">
        </div>
        <div style='text-align: center;padding-bottom:50px;'>
        <button type='submit' class='btn btn-primary' style='width: 10%; padding: 10px; font-weight:bold; background-color: #E3ECD6; border: none; color: #000; border-radius: 3px; cursor: pointer;'>Update</button>
        </div>
      </form>
      
      #{autoResizeTextarea('description')}

      <script>
        if ("#{item["type"]}" === "News") {
          document.getElementById('location-div').style.display = 'none';
          document.getElementById("source-label").innerHTML = "Source";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";
        }
        if ("#{item["type"]}" === 'Events') {
          document.getElementById('location-div').style.display = 'block';
          document.getElementById('url-div').style.display = 'none';
          document.getElementById("datetime").required = true;
          document.getElementById("location").required = true;
        } else {
          document.getElementById('location-div').style.display = 'none';
          document.getElementById('url-div').style.display = 'block';
          document.getElementById("date").required = true;
          document.getElementById("source").required = true;
          document.getElementById("media_url").required = true;
        }
        if ("#{item["type"]}" === "News") {
          document.getElementById("source-label").innerHTML = "Source";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";
          document.getElementById("description-label").innerHTML = "Please provide a detailed description of the content. You can insert HTML code or plain text";
        } else if ("#{item["type"]}" === "Books") {
          document.getElementById("source-label").innerHTML = "Author";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the book cover image.";
        } else if ("#{item["type"]}" === "Recipes") {
          document.getElementById("source-label").innerHTML = "Chef";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the dish's photo.";
        } else if ("#{item["type"]}" == "Movies") {
          document.getElementById("source-label").innerHTML = "Director";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the movie trailer. It can be from YouTube.";
        } else if ("#{item["type"]}" === "Videos") {
          document.getElementById("source-label").innerHTML = "Channel";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the video. It can be from YouTube.";
        } else if ("#{item["type"]}" == "Music") {
          document.getElementById("source-label").innerHTML = "Singer / Band";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the music video. It can be from YouTube.";
        } else if ("#{item["type"]}" === "Podcasts") {
          document.getElementById("source-label").innerHTML = "Podcast Host";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image for the podcast cover.";
          document.getElementById("description-label").innerHTML = "Include a comprehensive description of the episode or podcast, covering details like where it can be found across different platforms, URLs or hosting platforms.";
        } else if ("#{item["type"]}" === "Videogames") {
          document.getElementById("source-label").innerHTML = "Company";
          document.getElementById("url-label").innerHTML = "Please enter the URL of an image for the game cover.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the game, including its genre, gameplay features and any other relevant information.";
        }  else if ("#{item["type"]}" === "Art") {
          document.getElementById("source-label").innerHTML = "Creator";
          document.getElementById("url-label").innerHTML = "Enter the URL of an image of the artwork.";
          document.getElementById("description-label").innerHTML = "Provide a detailed description of the artwork, like information about the artistic style, the technique used, the theme or meaning of the artwork, historical or cultural context, and any other relevant details you'd like to share.";
        }
      </script>      
      HTML
    end

    def event_body_style(event)
      base64_image = image_url_to_base64(event['media_url'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        date = Date.parse(event['date']).strftime("%d %B %Y")
        if  Date.parse(event['date']) == Date.today
          date = "Today"
        end
        <<~HTML
          <style>
          .container {
              font-family: 'BBC Reith Sans';
              text-align: justify;
              width: 50%;
              margin: 20px auto;
              background-color: #fff;
              border-radius: 15px;
              overflow: hidden;
          }
          .header {
              padding: 20px 0;
          }
          .article-card {
              padding: 20px;
              border-bottom: 1px solid #eee;
          }
          .article-image {
              width: 100%;
              height: auto;
              border-radius: 10px;
              object-fit: cover;
          }
          .article-source {
              color: #666;
              margin-bottom: 5px;
          }
          .article-description {
              line-height: 2;
              font-size: 17px;
          }
          </style>
          <div class="container">
            <div class="header">
              <h1>#{event['title']}</h1>
              <span>By <strong>#{event['source']}</strong></span><br>
              <span style='color: #999999;'>#{date}</span>
            </div>
          </div>
          <img class="article-image" src='data:image/jpeg;base64,#{base64_image}' style='max-width:800px; max-height:700px;'>
          <div class="container"><p class="article-description">#{event['description']}</p></div>
          HTML
        end
    end 

    def item_body_style(item)
      base64_image = image_url_to_base64(item['media_url'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        date = Date.parse(item['date']).strftime("%d %B %Y")
        if  Date.parse(item['date']) == Date.today
          date = "Today"
        end
        if item['type'] == 'Books' ||  item['type'] == 'Podcasts' || item['type'] == 'Videogames'
          <<~HTML
          <style>
            .item-container {
                display: flex;
                align-items: center;
                padding: 20px;
                font-size: 15px;
                font-family: 'BBC Reith Sans';
            }
            .thumbnail {
                background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat;
                height: 400px;
                width: 35%;
            }
            .item-details {
                width: 50%;
            }
            .item-title {
                color: #333;
                font-size: 24px;
                margin-bottom: 10px;
            }
            .item-author, .item-released {
                color: #777;
                font-size: 14px;
                margin-bottom: 5px;
            }
            .item-description {
                color: #555;
                white-space: pre-wrap;
                font-family: 'BBC Reith Sans';
                line-height: 2;
                font-size: 17px;
            }
        </style>
        <div class='item-container'>
            <div class='thumbnail' name="image-container"></div>
            <div class='item-details'>
                <h2 class='item-title'>#{item['title']}</h2>
                <div style='margin-top: 15px;'>
                    <p class='item-author' style='text-transform: uppercase;'>#{item['source']}</p>
                    <p class='item-released'>#{date}</p>
                </div>
                <pre class='item-description'>#{item['description']}</pre>
            </div>
        </div>
          HTML
          elsif item['type'] == 'Videos' ||  item['type'] == 'Movies' || item['type'] == 'Music'
            <<~HTML
            <div style='font-family: "BBC Reith Sans"; padding: 20px; display: flex; flex-direction: column; align-items: flex-start;width:60%;'>
            <div style='width: 100%; border-radius: 10px; overflow: hidden;'>
            #{generate_video_embed(item['media_url'])}
            </div>
            <h1 style='color: #444; padding-top:18px; font-weight: bold; text-transform: uppercase;'>#{item['title']}</h1>
            <p style='color: #777; font-size: 20px; margin-bottom: 5px;'>By <strong>#{item['source']}</strong></p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'>#{date}</p>
            <p style='color: #555; font-size: 17px; line-height: 2; margin-bottom: 20px;'>#{item['description']}</p>
          </div>
          HTML
        elsif item['type'] == 'News' || item['type'] == 'Recipes' || item['type'] == 'Art' || item['type'] == 'Events'
          <<~HTML
          <style>
          .container {
              font-family: 'BBC Reith Sans';
              text-align: justify;
              width: 50%;
              margin: 20px auto;
              background-color: #fff;
              border-radius: 15px;
              overflow: hidden;
          }
          .header {
              padding: 20px 0;
          }
          .article-card {
              padding: 20px;
              border-bottom: 1px solid #eee;
          }
          .article-image {
              width: 100%;
              height: auto;
              border-radius: 10px;
              object-fit: cover;
          }
          .article-source {
              color: #666;
              margin-bottom: 5px;
          }
          .article-description {
              line-height: 2;
              font-size: 17px;
          }
          </style>
          <div class="container">
            <div class="header">
              <h1>#{item['title']}</h1>
              <span>By <strong>#{item['source']}</strong></span><br>
              <span style='color: #999999;'>#{date}</span>
            </div>
          </div>
          <img class="article-image" src='data:image/jpeg;base64,#{base64_image}' style='max-width:800px; max-height:700px;'>
          <div class="container"><p class="article-description">#{item['description']}</p></div>
          HTML
        else
          <<~HTML
          <div style='padding: 20px;font-size:15px'>
            <h2 style='color: #333;'>#{item['title']}</h2>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{item['author']}</p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on</strong> #{ Date.parse(item['date']).strftime("%d/%m/%Y")}</p>
            <div style='display: flex; justify-content: center;'><div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div></div>
            <pre style='color: #555; white-space: pre-wrap;'>#{item['description']}</pre>
          </div>
          </div>
          HTML
        end
      end
    end

    def content_item_body_image(item, base64_image)
      title_with_hyphens = item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <form class='item' action="/#{item['type']}/#{title_with_hyphens}" method='post' style='text-align:center;cursor: pointer; width: 30%; margin: 10px; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); background-color: #f9f9f9;'>
        <input type='hidden' name='item_id' value='#{item['id']}'>
        <button type='submit' style='background: none; border: none; padding: 0; margin: 0;width:100%;cursor: pointer;'>
          <div style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover; height: 300px; width: 100%;'></div>
          <div style='padding-top: 15px;'>
            <h3 class='title' style='font-size: 18px; font-weight: bold; color: #333; margin-bottom: 8px;'>#{item['title']}</h3>
            <p class='author' style='color: #555; font-size: 14px; margin-top: 5px;'>#{item['source']}</p>
          </div>
        </button>
      </form>
      HTML
    end  


    def event_body_image(event, base64_image)
      title_with_hyphens = event['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <form class='item' action="/Events/#{title_with_hyphens}" method='post' style='text-align:center;cursor: pointer; width: 30%; margin: 10px; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); background-color: #f9f9f9;'>
        <input type='hidden' name='item_id' value='#{event['id']}'>
        <button type='submit' style='background: none; border: none; padding: 0; margin: 0;width:100%;cursor: pointer;'>
          <div style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover; height: 300px; width: 100%;'></div>
          <div style='padding-top: 15px;'>
            <h3 class='title' style='font-size: 18px; font-weight: bold; color: #333; margin-bottom: 8px;'>#{event['title']}</h3>
            <p class='author' style='color: #555; font-size: 14px; margin-top: 5px;'>#{event['date']}</p>
          </div>
        </button>
      </form>
      HTML
    end  


    def content_item_body_video(content_item, embedded_video)
      title_with_hyphens = item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <form action='/#{item['type']}/#{title_with_hyphens}' method='post' style='text-align:center;cursor: pointer; width: 30%; margin: 10px; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); background-color: #f9f9f9;'>
      <input type='hidden' name='item_id' value='#{item['id']}'>
        <button type='submit' style='background: none; border: none; padding: 0; margin: 0;width:100%;cursor: pointer;'>
          #{embedded_video}
          <div class='info' style='padding-top: 15px;'>
            <h3 class='title' style='font-size: 18px; font-weight: bold; color: #333; margin-bottom: 8px;'>#{item['title']}</h3>
            <p class='author' style='color: #555; font-size: 14px; margin-top: 5px;'>#{item['source']}</p>
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
        <input type='url' id='media_url' name='media_url' class='form-control' style='width: 100%; margin-top: 10px; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' required>
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
      
      #{autoResizeTextarea('description')}

      <script>
      document.getElementById('location-div').style.display = 'none';
      document.getElementById("source-label").innerHTML = "Source";
      document.getElementById("url-label").innerHTML = "Please enter the URL of the header image for the news.";

      function toggleFields() {
        var type = document.getElementById('type').value;
        if (type === 'Events') {
          document.getElementById('location-div').style.display = 'block';
          document.getElementById("datetime").required = true;
          document.getElementById("location").required = true;
        } else {
          document.getElementById('location-div').style.display = 'none';
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
          document.getElementById("url-label").innerHTML = "Please enter the URL of the movie trailer. It can be from YouTube.";
        } else if (document.getElementById('type').value == "Videos") {
          document.getElementById("source-label").innerHTML = "Channel";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the video. It can be from YouTube.";
        } else if (document.getElementById('type').value == "Music") {
          document.getElementById("source-label").innerHTML = "Singer / Band";
          document.getElementById("url-label").innerHTML = "Please enter the URL of the music video. It can be from YouTube.";
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
        } else if (document.getElementById('type').value == "Events") {
          document.getElementById("source-label").innerHTML = "Creator";
          document.getElementById("url-label").innerHTML = "Please enter the URL of an image related to the event.";
          document.getElementById("description-label").innerHTML = "Provide a comprehensive description of the event, including details about its purpose, target audience, features, and any other relevant information you want to share.";
        }        
      }
      </script>      
      HTML
    end

    def manage_content_table(items)
      table_rows = ""
      items = items.sort_by { |item| DateTime.parse(item['pubdate']) }.reverse
      items.each do |item|
        type = item['type']
        title_with_hyphens = item['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
        table_rows += <<~HTML
          <tr data-type="#{type.downcase}">
            <td>#{type}</td>
            <td>#{item['title']}</td>
            <td>#{DateTime.parse(item['pubdate']).strftime("%d/%m/%Y %H:%M")}</td>
            <td class="table-actions" style="display: flex; align-items: center; justify-content: center;">
            <form action="/#{type}/#{title_with_hyphens}" method='post'>
              <input type='hidden' name='item_id' value="#{item['id']}">
              <button title="View">
                <i class='bi bi-eye'></i>
              </button>
            </form>
            <form action='/edit' method='post'>
              <input type='hidden' name='item_id' value="#{item['id']}">
              <button title="Edit">
                <i class='bi bi-pencil'></i>
              </button>
            </form>
            <form action='/delete' method='post'>
              <input type='hidden' name='page' value="/Manage-content">
              <input type='hidden' name='item_id' value="#{item['id']}">
              <button onclick="return confirm('Are you sure you want to delete this item?')" title="Delete">
                <i class='bi bi-trash'></i>
              </button>
            </form>
            </td>          
          </tr>
        HTML
      end
      <<~HTML
          <style>
          .table-wrapper {
            overflow-x: auto;
          }
          .table {
            padding-top: 20px;
            width: 95%;
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
            border-spacing: 0;
          }
          .table th, .table td {
            padding: 10px 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            font-size: 14px;
          }
          .table th {
            background-color: #E3ECD6;
            color: #333;
            font-weight: bold;
          }
          .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
          }
          .table tbody tr:hover {
            background-color: #f0f0f0;
          }
          .table-actions button {
            border: none;
            background: none;
            cursor: pointer;
            font-size: 16px;
            margin-right: 5px;
            padding: 5px;
            color: #999;
            transition: color 0.3s;
          }
          .table-actions button:hover {
            color: #333;
          }
        </style>
        <div class="table-wrapper">
          <br><br>
          <h4 style='text-align: center; margin-top: 10px; padding: 20px 0; font-size: 30px; color: #333;'>Manage content</h4>
          <div style='display: flex; align-items: center; justify-content: flex-end;'>
          <form id='sort-form' style='margin-right: 20px; display: flex; align-items: center;'>
            <div style='margin-right: 10px;'>
              <input type='text' name='search' id='search' placeholder='Search...' style='padding: 8px; border-radius: 5px; border: 1px solid #ccc;'>
            </div>
            <select onchange='filterByType()'id='type' name='type' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
              <option value='all'>All</option>
              <option value='News'>News</option>  
              <option value='Books'>Books</option>
              <option value='Recipes'>Recipes</option>  
              <option value='Movies'>Movies</option>
              <option value='Videos'>Videos</option>
              <option value='Music'>Music</option>
              <option value='Podcasts'>Podcasts</option>
              <option value='Videogames'>Videogames</option>
              <option value='Art'>Art</option>
              <option value='Events'>Events</option>
            </select>
          </form>
          </div>
          <table class="table">
            <thead>
              <tr>
                <th>Type of content</th>
                <th>Title</th>
                <th>Publication date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody id="table-body">
              #{table_rows}
            </tbody>
          </table>
        </div>
        <script>
        function filterByType() {
          const selectedType = document.getElementById('type').value;
          const rows = document.querySelectorAll('#table-body tr');
          rows.forEach(row => {
            const type = row.getAttribute('data-type').toLowerCase();
            if (selectedType === 'all' || type === selectedType.toLowerCase()) {
              row.style.display = '';
            } else {
              row.style.display = 'none';
            }
          });
        }
        document.addEventListener("DOMContentLoaded", function() {
          const searchInput = document.getElementById('search');
          const tableBody = document.getElementById('table-body');
          searchInput.addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            const rows = tableBody.getElementsByTagName('tr');
            for (let row of rows) {
              const titleCell = row.getElementsByTagName('td')[1];
              if (titleCell) {
                const titleText = titleCell.textContent.toLowerCase();
                if (titleText.includes(searchText)) {
                  row.style.display = '';
                } else {
                  row.style.display = 'none';
                }
              }
            }
          });
        });
      </script>
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
           color:#1D8348;
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
      <style>
        .dropdown {
          position: relative;
        }
        .dropdown-menu {
          display: none;
          position: absolute;
          background-color: #E3ECD6;
          z-index: 1;
          text-align:center;
          margin-top:0px;
          padding:0px;
        }
        .dropdown.show .dropdown-menu {
          display: block;
        }
      </style>
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
        <a href='/Events'>Events</a>
        <div class='user-info' id='user-info'  style="display: flex; align-items: center;">
          <div class="dropdown" style="width:150px;">
            <a class="dropdown-toggle" id="dropdownMenuButton">
              <strong>#{$user_name}</strong>
              <i class='bi bi-caret-down' id='dropdown-icon'></i>
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
              <a class="dropdown-item" href="/Create">Create content</a>
              <a class="dropdown-item" href="/Manage-content">Manage content</a>
            </ul>
          </div>
          <a class='logout-link' href='/'><i class='bi bi-box-arrow-right'></i></a>
        </div>
      </div>
      <script>
        document.addEventListener("DOMContentLoaded", function() {
        const dropdownToggle = document.querySelector('.dropdown-toggle');
        const dropdownMenu = document.querySelector('.dropdown-menu');
        dropdownToggle.addEventListener('click', function() {
          dropdownMenu.parentElement.classList.toggle('show');
        });
        document.addEventListener('click', function(event) {
          if (!dropdownMenu.parentElement.contains(event.target)) {
            dropdownMenu.parentElement.classList.remove('show');
          }
        });
      });
      </script>
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
      image = event['media_url']
      title_with_hyphens = event['title'].gsub(/[-\s']+/, '-').gsub(/(^\W+|\W+$)/, '').downcase
      <<~HTML
      <div onclick="document.getElementById('event_form_#{event['id']}').submit()" class='event-container' style='cursor:pointer; width: 500px; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>
        <form id='event_form_#{event['id']}' action='/Event/#{title_with_hyphens}' method='post' style='display: none;'>
          <input type='hidden' name='event_id' value='#{event['id']}'>
        </form>
        <img src=#{image} style='width: 100%; height: 250px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 20px;'>
          <p class='event-title' style='font-weight: bold; color: #333; font-size: 16px; margin-bottom: 8px;'>#{event['title']}</p>
          <p style='color: #777; font-size: 12px;'><i class='bi bi-clock'></i> #{ Date.parse(event['datetime']).strftime("%d/%m/%Y %I:%M")}</p>
        </div>
      </div>
      HTML
    end

    def body_event(event)
      <<~HTML
      <div class='event-container' style='width: 500px; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>
        <img src='#{event['media_url']}' style='width: 100%; height: 250px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 20px;'>
          <p class='event-title' style='font-weight: bold; color: #333; font-size: 16px; margin-bottom: 8px;'>#{event['title']}</p>
          <p class='event-description' style='color: #555; font-size: 13px; margin-bottom: 8px;'>#{event['description']}</p>
          <p style='color: #777; font-size: 12px;'><i class='bi bi-clock'></i> #{DateTime.parse(event['datetime']).strftime("%d/%m/%Y %I:%M")}</p>
        </div>
      </div>
      HTML
    end

    def items_header_style(type)
      <<~HTML
      <h4 style='text-align: center;
        margin-top: 10px;
        padding: 20px 0;font-size: 30px;
        color: #333;
        margin-bottom: 20px;'>#{type}
      </h4>
      HTML
    end

    def items_search_form(type, sb)
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
        var contentItems = document.getElementsByClassName('item');
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
          <i class='bi bi-trash'></i>
        </button>
      </form>
    </div>
    HTML
    end

    def comments_form(item_id,sorted_comments) 
      <<~HTML
      <div style='margin: 20px auto; width: 70%;padding-top:5%;'>
      <div style='border: 1px solid #ddd; border-radius: 10px; overflow: hidden; padding: 20px; background-color: #f9f9f9;'>
      <div style='margin-bottom: 20px;'>
        <form action='/submit_comment' method='post'>
        <input type='hidden' name='item_id' value='#{item_id}'>
        <input type='hidden' name='comment_user_id' value='#{$user_id}'>
          <textarea placeholder='Add a comment...' id='comment_text' name='comment_text' rows='4' cols='50' style='background-color: #f9f9f9; width: 100%; margin-top: 10px;padding:10px;border: none;outline:none'></textarea><br>
          <div style='text-align: right;'>
            <input type='submit' value='Comment' style='margin:10px;background-color: #1D8348; color: white; border: none; padding: 10px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
          </div>
        </form>
      </div>
      #{autoResizeTextarea('comment_text')}
      HTML
    end 

    def print_comment(comment,item_id,user) 
      <<~HTML
      <div style='border-radius: 5px;text-align:justify;'>
        <span style='font-weight: bold; color: #333; font-size: 14px;'>#{user}</span>
        <span style='color: #777; margin-left: 10px; font-size: 12px;'>#{comment['pubdate']}</span>
        <p style='margin-top: 10px; color: #555; font-size: 13px; word-wrap: break-word; word-break: break-all;'>#{comment['text']}</p>
        #{if comment['user_id'] == $user_id
          <<~HTML
          <form id='update_comment_#{comment["id"]}' action='/update_comment' method='post' style='margin-top: 10px; display: none;'>
            <input type='hidden' name='item_id' value='#{item_id}'>
            <input type='hidden' name='comment_id' value='#{comment["id"]}'>
            <textarea name='updated_text' style='width: 100%;' rows='4' cols='50'>#{comment['text']}</textarea><br><br>
            <input type='submit' value='Update' style='background-color: #1D8348; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            <button type='button' id='cancel-button_#{comment["id"]}' class='cancel-edit' style='background-color: #9C3030; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px;'>Cancel</button>
          </form>
          <div style='display: flex; justify-content: flex-end;'>
            <form action='update_comment_#{comment["id"]}' onsubmit='return false;'>
              <input type='hidden' name='comment_id' value='#{comment["id"]}'>
              <input type='submit' id='edit-button_#{comment["id"]}' class='edit-button' value='Edit' style='background-color: #2B88C0; color: white; border: none; padding: 5px 10px; text-align: center; text-decoration: none; display: inline-block; font-size: 12px; cursor: pointer; border-radius: 3px; margin-right: 10px;'>
            </form>
            <form action='/delete_comment' method='post'>
              <input type='hidden' name='item_id' value='#{item_id}'>
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

    def rating_body(item_id, content_rating)
      html = <<~HTML
        <div style='text-align: right;width:80%;'>
          <p style='font-size:15px;color:#9e9e9e;text-align:center;display:inline-block;'><i class="bi bi-star-fill" style="color:#FFDE59"></i><span style="font-size:18px;color:#000"><strong>&nbsp;#{content_rating}</strong></span>/10</p>
          <button onclick="rate()" type='submit' style='color: #1D8348; font-weight:bold; background-color:#FFF; border: none; padding:10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'><i class="bi bi-star" style="color:#1D8348"></i> Rate</button>
        </div>    
        <form id='ratingForm' action='/update_rating' method='post' onsubmit='return confirmRating();' style="display:none;;">
        <input type='hidden' name='item_id' value='#{item_id}'>
        <input type='hidden' name='rating' id='selectedRating'>
        <div style='text-align: center;'>
          <div class='rating'>
            HTML
            (1..10).each do |i|
              html += "<input type='radio' id='star#{i}' name='rating' value='#{i}' onclick='setSelectedRating(#{i})' #{'checked' if i == content_rating}><label for='star#{i}'></label>"
            end
            html += <<~HTML
          </div><br>
          <input id='submitBtn' type='submit' value='Submit' style='background-color: #1F6F3A; color: white; border: none; padding:10px; text-align: center; text-decoration: none; display: inline-block; font-size: 15px; margin-top: 10px; cursor: pointer; border-radius: 5px;'>
        </div>
      </form>
        <script>
          function setSelectedRating(starValue) {
            document.getElementById('selectedRating').value = starValue;
            document.getElementById('submitBtn').innerText = 'Submit Rating';
          }
          function confirmRating() {
            return confirm('Are you sure you want to submit this rating?');
          }
          function rate() {
            var ratingForm = document.getElementById("ratingForm");
            if (ratingForm.style.display === "block") ratingForm.style.display = "none";
            else ratingForm.style.display = "block";
        }        
        </script>
      HTML
      return html
    end
     
end