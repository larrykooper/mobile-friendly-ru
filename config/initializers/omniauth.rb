#config/initalizers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do

    # provider: Tells Omniauth to initialize the google_oauth2 strategy
    #  with my client_id and client_secret

    provider :google_oauth2, ENV['MOBILE_RU_CLIENT_ID'], ENV['MOBILE_RU_CLIENT_SECRET'], {
    # scope: Tells Google which APIs I would like to access
    # see this https://developers.google.com/google-apps/spreadsheets/
    scope: ['email', "https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
    }
end

#scope: ['email', "https://www.googleapis.com/auth/drive",
#            "https://spreadsheets.google.com/feeds/"]
#    }