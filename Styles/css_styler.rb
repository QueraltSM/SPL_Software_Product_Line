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
          }
          .error-message {
              color: red;
              margin-top: 10px;
          }
        </style>
        HTML
      end  
      
    def admin_css()
      <<~HTML
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        <style>
          body {
            margin: 0 auto;
            font-family: 'Verdana', sans-serif;
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

    def header_events()
        <<~HTML
        <div style='display: flex; flex-wrap: wrap; justify-content: center; margin: 15px; padding: 10px;'>
        <p style='width: 100%; text-align: center; font-size: 18px; font-weight: bold;'>Events</p>
        HTML
    end

    def events_css(event)
        image = event['image']
        <<~HTML
        <div style='width: 30%; margin: 10px; background-color: #f5f5f5; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;text-align:justify;'>
        <img src=#{image} style='width: 100%; height: 150px; object-fit: cover; border-bottom: 1px solid #ddd;'>
        <div style='padding: 10px; margin: 15px;'>
          <p style='font-weight: bold; color: #333;'>#{event['title']}</p>
          <p style='display: block; color: #555;font-size:13px;text-align:justify;'>#{event['description']}</p>
          <p style="color: #777;font-size:13px"><i class='bi bi-geo-alt'></i>#{event['location']}</p>
          <p style='color: #777;font-size:13px'><i class='bi bi-clock'></i> #{event['datetime']}</p>
        </div>
      </div>
        HTML
    end
end 