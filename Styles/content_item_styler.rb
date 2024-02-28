class ContentItemStyler
    def initialize(content_item)
      @content_item = content_item
    end
  
    def content_item_header_style
      if @content_item['type'] == 'News'
          <<~HTML
            <div class='news-style' style='width: 50%; margin-bottom: 20px; overflow: hidden;margin: 20px auto;'>
          HTML
      else
        <<~HTML
          <div style='width: 70%; margin-bottom: 20px; overflow: hidden;margin: 20px auto; '>
        HTML
      end
    end

    def content_item_body_style
      base64_image = image_url_to_base64(@content_item['digital_content'])
      unique_images = Set.new
      unless unique_images.include?(base64_image)
        unique_images.add(base64_image)
        if @content_item['type'] == 'Books'
          <<~HTML
          <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
            <div class='thumbnail' style='background: url(data:image/jpeg;base64,#{base64_image}) center center / cover no-repeat; height: 400px; width: 560px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); margin-right: 20px;'></div>
                <div style='margin-left: 20px;'>
                    <h2 style='color: #333;'>#{@content_item['title']}</h2>
                    <p style='color: #888; font-style: italic;'>#{@content_item['author']}</p>
                    <pre style='color: #555; white-space: pre-wrap;'>#{@content_item['description']}</pre>
                    <p style='color: #777;'><strong>Publication date</strong>: #{@content_item['pubdate']}</p>
                </div>
              </div>
          </div>
          HTML
          elsif @content_item['type'] == 'Videos'
            <<~HTML
            <div style='padding: 20px;font-size:15px;display: flex; justify-content: flex-start; align-items: center;'>
              <div style='margin-left: 20px;'>
                <h2 style='color: #333;'>#{@content_item['title']}</h2>
                <p style='color: #888; font-style: italic;'>#{@content_item['author']}</p>
                <div style='display: flex; justify-content: center;'><iframe width='560' height='315' src='#{@content_item["digital_content"]}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe></div>
                <pre style='color: #555; white-space: pre-wrap;'>#{@content_item['description']}</pre>
                <p style='color: #777;'><strong>Publication date</strong>: #{@content_item['pubdate']}</p>
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
        <div class='button-container'>
          <button style='background:#2B88C0'>Modify content</button>
          <button style='background:#C0392B'>Delete item</button>
        </div>
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
  