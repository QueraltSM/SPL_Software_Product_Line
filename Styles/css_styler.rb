class CSS_Styler
    
    def login_css
        <<~HTML
        <style>
            body {
                font-family: 'Verdana', sans-serif;
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
                font-family: 'Verdana', sans-serif;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                font-family: 'Verdana', sans-serif;
            }
            input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-family: 'Verdana', sans-serif;
            }
            .submit-btn {
                background-color: #E3ECD6;
                color: #000;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-family: 'Verdana', sans-serif;
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
              font-family: 'Verdana', sans-serif;
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
              font-family: 'Verdana', sans-serif;
          }
          .form-group {
              margin-bottom: 15px;
          }
          label {
              display: block;
              margin-bottom: 5px;
              font-weight: bold;
              font-family: 'Verdana', sans-serif;
          }
          input {
              width: 100%;
              padding: 8px;
              box-sizing: border-box;
              border: 1px solid #ccc;
              border-radius: 4px;
              font-family: 'Verdana', sans-serif;
          }
          .submit-btn {
              background-color: #E3ECD6;
              color: #000;
              padding: 10px;
              border: none;
              border-radius: 5px;
              cursor: pointer;
              width: 100%;
              font-family: 'Verdana', sans-serif;
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

    def header_events()
        <<~HTML
        <div style='display: flex; flex-wrap: wrap; justify-content: center; margin: 15px; padding: 10px;'>
        <p style='width: 100%; text-align: center; font-size: 18px; font-weight: bold;'>Events</p>
        HTML
    end

    def events_css(event)
        image = event['image']
        <<~HTML
        <div style='width: 40%; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;text-align:justify;'>
        <img src=#{image} alt='Event image' style='width: 100%; height: 150px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 10px; margin: 15px;'>
          <p style='font-weight: bold; color: #333;'>#{event['title']}</p>
          <p style='display: block; color: #555;font-size:15px'>#{event['description']}</p>
          <p style="font-size:13px"><i class='bi bi-geo'></i>#{event['location']}</p>
          <p style='color: #777;font-size:13px'><i class='bi bi-clock'></i> #{event['datetime']}</p>
        </div>
      </div>
        HTML
    end
end 