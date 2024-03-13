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
            <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
              <div style='margin-left: 20px;'>
                <h2 style='color: #333;'>#{@content_item['title']}</h2>
                <div style="display: flex; justify-content: center;"><img src='data:image/jpeg;base64,#{base64_image}'/></div>
                <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Written by</strong> #{@content_item['author']}</p>
                #{rating_html(@content_item['rating']) if @content_item['rating'] != -1}
                <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on</strong> #{@content_item['pubdate']}</p>
                <pre style='color: #555; white-space: pre-wrap;text-align:justify;'>#{@content_item['description']}</pre>
              </div>
            </div>
          HTML
        else
          <<~HTML
          <div style='padding: 20px;font-size:15px'>
            <h2 style='color: #333;'>#{@content_item['title']}</h2>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Author</strong> #{@content_item['author']}</p>
            <p style='color: #777; font-size: 14px; margin-bottom: 5px;'><strong>Posted on</strong> #{@content_item['pubdate']}</p>
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
            <button class="btn" style="background-color: #C0392B; color: #FFF; padding: 10px 20px; border: none; border-radius: 5px; margin-right: 10px; cursor: pointer;" onclick="window.location.href='/content_item/#{@content_item['id']}'">Cancel</button>
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
            <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
              <div style='margin-left: 20px;'>
                <h2 style='color: #333;'>#{@content_item['title']}</h2>
                <p style='color: #888; font-style: italic;'>#{@content_item['author']}</p>
                <div style="display: flex; justify-content: center;"><img src='data:image/jpeg;base64,#{base64_image}'/></div>
                <pre style='color: #555; white-space: pre-wrap;text-align:justify;'>#{@content_item['description']}</pre>
                <p style='color: #777;'><strong>Publication date</strong>: #{@content_item['pubdate']}</p>
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
        <form action='/update_content_item_form' method='post'>
          <input type='hidden' name='content_item_id' value="#{@content_item['id']}">
          <button style='background:#2B88C0; margin-right: 10px;'>
            <i class='fas fa-pencil-alt'></i>
          </button>
        </form>
        <form action='/delete_content_item' method='post'>
          <input type='hidden' name='content_item_id' value="#{@content_item['id']}">
          <button style='background:#C0392B' onclick="return confirm('Are you sure you want to delete this item?')">
            <i class='fas fa-trash'></i>
          </button>
        </form>
      </div> 
      HTML
    end

    def creation_content_item_form
      <<~HTML
      <br>
      <h4 style='text-align:center;'>Creation of new digital content</h4>
      <br>
      <form action='/create_content_item' method='post' style='max-width: 70%; margin: 0 auto; padding: 20px;'>
        <input type='hidden' name='_method' value='put'>
        <div class='form-group'>
          <label for='type' style='display: block; font-weight: bold;'>Select content type:</label>
          <select id='type' name='type' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;' onchange='toggleFields()'>
            <option value='Books'>Book</option>
            <option value='Movies'>Movie</option>
            <option value='Music'>Music</option>
            <option value='Videos'>Video</option>
            <option value='Recipes'>Recipe</option>
            <option value='News'>News</option>
            <option value='Events'>Events</option>
          </select>
        </div><br>
        <div id='media-input' class='form-group'>
          <label for='media' style='display: block; font-weight: bold;'>Enter relevant URL:</label>
          <input type='url' id='digital_content' name='digital_content' class='form-control' style='width: 100%; margin-top: 10px; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div><br>
        <div class='form-group'>
          <label for='title' id='title-label' style='display: none; display: block; font-weight: bold;'>Title:</label>
          <input type='text' id='title' name='title' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div><br>
        <div class='form-group'>
          <label for='author' id='author-label' style='display: none; display: block; font-weight: bold;'>Author:</label>
          <input type='text' id='author' name='author' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div><br>
        <div class='form-group'>
          <label for='description' id='description-label' style='display: none; display: block; font-weight: bold;'>Description:</label>
          <textarea id='description' name='description' placeholder="You can insert HTML code or plain text" class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'></textarea>
        </div><br>
        <div class='form-group'>
          <label for='location' id='location-label' style='display: none; display: block; font-weight: bold;'>Location:</label>
          <input type='text' id='location' name='location' class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div><br>
        <div class='form-group'>
          <label for='datetime' id='datetime-label' style='display: none; display: block; font-weight: bold;'>Event date and time:</label>
          <input type='text' id='datetime' name='datetime' placeholder="You must follow the format dd/MM/yyyy HH:mm" class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div>
        <div class='form-group'>
          <label for='pubdate' id='pubdate-label' style='display: none; display: block; font-weight: bold;'>Publication date:</label>
          <input type='text' id='pubdate' name='pubdate' placeholder="Feel free to input any format" class='form-control' style='width: 100%; padding: 8px; border: 1px solid lightgray; border-radius: 3px;'>
        </div><br>
        <div style='text-align: center;'>
          <button type='submit' class='btn btn-primary' style='width: 40%; padding: 10px; background-color: #E3ECD6; border: none; color: #000; border-radius: 3px; cursor: pointer;'>Create</button>
        </div>
      </form>
      <script>
      document.getElementById('datetime-label').style.display = 'none';
      document.getElementById('datetime').style.display = 'none';
      document.getElementById('location-label').style.display = 'none';
      document.getElementById('location').style.display = 'none';
      function toggleFields() {
        var type = document.getElementById('type').value;
        if (type === 'Events') {
          document.getElementById('datetime-label').style.display = 'block';
          document.getElementById('datetime').style.display = 'block';
          document.getElementById('location-label').style.display = 'block';
          document.getElementById('location').style.display = 'block';
          document.getElementById('pubdate-label').style.display = 'none';
          document.getElementById('pubdate').style.display = 'none';
          document.getElementById('author-label').style.display = 'none';
          document.getElementById('author').style.display = 'none';
        } else {
          document.getElementById('datetime-label').style.display = 'none';
          document.getElementById('datetime').style.display = 'none';
          document.getElementById('location-label').style.display = 'none';
          document.getElementById('location').style.display = 'none';
          document.getElementById('pubdate-label').style.display = 'block';
          document.getElementById('pubdate').style.display = 'block';
          document.getElementById('author-label').style.display = 'block';
          document.getElementById('author').style.display = 'block';
        }
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
  