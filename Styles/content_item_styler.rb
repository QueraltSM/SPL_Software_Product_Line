class ContentItemStyler
    def initialize(content_item)
      @content_item = content_item
    end
  
    def content_item_header_style
      header_style = <<~HTML
        <style>
          .input-container {
            margin-bottom: 20px;
          }
          .input-label {
            color: #444;
            font-size: 16px;
            margin-bottom: 5px;
          }
          .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #E3ECD6;;
            border-radius: 5px;
            font-size: 16px;
          }
          .input-field:focus {
            outline: none;
            border-color: #ccc;
          }
          .news-style {
            width: 50%;
            margin-bottom: 20px;
            overflow: hidden;
            margin: 20px auto;
          }
        </style>
      HTML
      if @content_item['type'] == 'News'
        header_style += "<div class='news-style'>"
      else
        header_style += "<div style='width: 70%; margin-bottom: 20px; overflow: hidden;margin: 20px auto;'>"
      end
      return header_style
    end
    
    def rating_html(rating)
      "<p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Rating</strong> #{rating}</p>"
    end

    def content_item_body_style
      base64_image = image_url_to_base64(@content_item['digital_content'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        if @content_item['type'] == 'Books'
          <<~HTML
          <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
          <div class='thumbnail' name="image-container" style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div>
            <div style='margin-left: 20px;'>
                    <h2 style='color: #333;'>#{@content_item['title']}</h2>
                    <div style='margin-top: 15px;'>
                    <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{@content_item['author']}</p>
                    <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Released</strong> #{@content_item['pubdate']}</p>
                    #{rating_html(@content_item['rating']) if @content_item['rating'] != -1}
                    </div>
                  <pre style='color: #555; white-space: pre-wrap;'>#{@content_item['description']}</pre>
                </div>
              </div>
          </div>
          HTML
          elsif @content_item['type'] == 'Videos' ||  @content_item['type'] == 'Movies'
            <<~HTML
            <div style='padding: 20px; font-size: 16px; display: flex; flex-direction: column; align-items: flex-start;'>
            <h3 style='color: #444; font-size: 26px; margin: 10px; font-weight: bold; text-transform: uppercase;'>#{@content_item['title']}</h3>
            <div style='width: 100%; border-radius: 10px; overflow: hidden;'>
              <iframe width='100%' height='600' style='border: none; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);' src='#{@content_item["digital_content"]}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>
            </div>
            <div style='margin-top: 15px;'>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>#{(@content_item['type'] == 'Movies') ? 'Director' : 'Channel' }</strong> #{@content_item['author']}</p>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Released</strong> #{@content_item['pubdate']}</p>
              #{rating_html(@content_item['rating']) if @content_item['rating'] != -1}
            </div>
            <div style='margin-top: 20px;'>
              <p style='color: #555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;'>#{@content_item['description']}</p>
            </div>
          </div>
          HTML
        elsif @content_item['type'] == 'News'
          <<~HTML
          <div style='padding: 20px; font-size: 15px;'>
          <div style='border: 1px solid #ddd; border-radius: 5px; padding: 20px; background-color: #f9f9f9;'>
            <h2 style='color: #333; margin: 20px;text-align:center;'>#{@content_item['title']}</h2>
            <div style="display: flex; justify-content: center; margin-bottom: 15px;">
              <img src='data:image/jpeg;base64,#{base64_image}' style="max-width: 100%; border-radius: 5px;">
            </div>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>#{@content_item['source']}</strong></p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on:</strong> #{ Date.parse(@content_item['date']).strftime("%d/%m/%Y")}</p>
            <p style='color: #555; font-size: 14px; line-height: 1.6; text-align: justify;'>#{@content_item['description']}</p>
          </div>
        </div>
        
          HTML
        else
          <<~HTML
          <div style='padding: 20px;font-size:15px'>
            <h2 style='color: #333;'>#{@content_item['title']}</h2>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{@content_item['author']}</p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on</strong> #{ Date.parse(@content_item['date']).strftime("%d/%m/%Y")}</p>
            <div style='display: flex; justify-content: center;'><div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div></div>
            <pre style='color: #555; white-space: pre-wrap;'>#{@content_item['description']}</pre>
          </div>
          </div>
          HTML
        end
      end
    end

    def update_content_item_body_style
      base64_image = image_url_to_base64(@content_item['digital_content'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        if @content_item['type'] == 'Books'
          <<~HTML
          <div style='padding: 20px; font-size: 15px; display: flex; align-items: flex-start;'>
            <form action="/update_content_item" method="post" style="display: flex; width: 100%;">
              <input type="hidden" name="content_item_id" value="#{@content_item['id']}">
              <div class='thumbnail' name="image-container" style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 400px; width: 560px; margin-right: 20px;'></div>
              <div style='width:100%;'>
                <div class="input-container">
                  <label class="input-label"><strong>Title</strong></label>
                  <input class="input-field" name="updated_title" type="text" style="color: #333;" value="#{@content_item['title']}">
                </div>
                <div class="input-container">
                  <label class="input-label"><strong>Author</strong></label>
                  <input class="input-field" name="updated_author" type="text" style="color: #333;" value="#{@content_item['author']}">
                </div>
                <div class="input-container">
                  <label class="input-label"><strong>Description</strong></label>
                  <textarea class="input-field" name="updated_description" style="color: #333; height: 100px;">#{@content_item['description']}</textarea>
                </div>
                <div class="input-container">
                  <label class="input-label"><strong>Release</strong></label>
                  <input class="input-field" name="updated_pubdate" type="text" style="color: #333;" value="#{@content_item['pubdate']}">
                </div>
              </div>
            </form>
          </div>
          <div style="margin-top: 20px; text-align: center;">
            <input type="file" name="updated_digital_content" accept="image/*" style="display: none;">
            <button class="btn" style="background-color: #2B88C0; color: #FFF; padding: 10px 20px; border: none; border-radius: 5px; margin-right: 10px; cursor: pointer;" onclick="document.getElementById('updated_digital_content').click();">Choose Image</button>
            <button class="btn" style="background-color: #9C3030; color: #FFF; padding: 10px 20px; border: none; border-radius: 5px; margin-right: 10px; cursor: pointer;" onclick="window.location.href='/content_item/#{@content_item['id']}'">Cancel</button>
            <button class="btn" style="background-color: #1F6F3A; color: #FFF; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;" onclick="if(confirm('¿Estás seguro de que quieres actualizar este contenido?')) { document.querySelector('form').submit(); }">Update</button>
          </div>
          <script>
          document.getElementById('updated_digital_content').addEventListener('change', function(event) {
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e) {
              var imageDataUrl = e.target.result;
              document.getElementById('image-container').style.backgroundImage = "url(" + imageDataUrl + ")";
            };
            reader.readAsDataURL(file);
          });
        </script>
          HTML
          elsif @content_item['type'] == 'Videos' ||  @content_item['type'] == 'Movies'
            <<~HTML
            <div style='padding: 20px; font-size: 16px; display: flex; flex-direction: column; align-items: flex-start;  border-radius: 10px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);'>
            <h3 style='color: #444; font-size: 26px; margin: 10px; font-weight: bold; text-transform: uppercase;'>#{@content_item['title']}</h3>
            <div style='width: 100%; border-radius: 10px; overflow: hidden;'>
              <iframe width='100%' height='600' style='border: none; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);' src='#{@content_item["digital_content"]}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>
            </div>
            <div style='margin-top: 15px;'>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>#{(@content_item['type'] == 'Movies') ? 'Director' : 'User' }</strong> #{@content_item['author']}</p>
              <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Released</strong> #{@content_item['pubdate']}</p>
            </div>
            <div style='margin-top: 20px;'>
              <p style='color: #555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;'>#{@content_item['description']}</p>
            </div>
          </div>
          HTML
        elsif @content_item['type'] == 'News'
          <<~HTML
          <div style='padding: 20px; font-size: 15px; display: flex; justify-content: center; align-items: center;'>
          <div style='max-width: 800px; border: 1px solid #ddd; border-radius: 5px; padding: 20px; background-color: #f9f9f9;'>
            <h2 style='color: #333; margin-bottom: 10px;'>#{@content_item['title']}</h2>
            <div style="display: flex; justify-content: center; margin-bottom: 15px;">
              <img src='data:image/jpeg;base64,#{base64_image}' style="max-width: 100%; border-radius: 5px;">
            </div>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Written by:</strong> #{@content_item['source']}</p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on:</strong> #{ Date.parse(@content_item['date']).strftime("%d/%m/%Y")}</p>
            <p style='color: #555; font-size: 14px; line-height: 1.6; text-align: justify;'>#{@content_item['description']}</p>
          </div>
        </div>
          HTML
        else
          <<~HTML
          <div style='padding: 20px;font-size:15px'>
            <h2 style='color: #333;'>#{@content_item['title']}</h2>
            <p style='color: #888; font-style: italic;'>#{@content_item['author']}</p>
            <div style='display: flex; justify-content: center;'><div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / contain no-repeat; height: 250px; width:200px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);'></div></div>
            <pre style='color: #555; white-space: pre-wrap;'>#{@content_item['description']}</pre>
            <p style='color: #777;'><strong>Publication date</strong>: #{@content_item['pubdate']}</p>
          </div>
          </div>
          HTML
        end
      end
    end
    
    def admin_actions
      <<~HTML
      <div class='button-container' style='display: flex; align-items: center;'>
        <form action='/edit' method='post'>
          <input type='hidden' name='content_item_id' value="#{@content_item['id']}" title="Edit">
          <button style='background:#2B88C0; margin-right: 10px;'>
            <i class='fas fa-pencil-alt'></i>
          </button>
        </form>
        <form action='/delete_content_item' method='post'>
          <input type='hidden' name='content_item_id' value="#{@content_item['id']}">
          <button style='background:#9C3030' onclick="return confirm('Are you sure you want to delete this item?')" title="Delete">
            <i class='fas fa-trash'></i>
          </button>
        </form>
      </div> 
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