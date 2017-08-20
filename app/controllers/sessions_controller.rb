# app/controllers/sessions_controller.rb
# https://www.twilio.com/blog/2014/09/gmail-api-oauth-rails.html

# The sessions controller handles the oauth2 callback.
class SessionsController < ApplicationController
  # request.env is a Ruby array that contains information about a visiting user
  # and server environment, including path_info, request_uri and lots more.

  # request.env is ENORMOUS.
  # request.env['omniauth.auth'] contains a lot of information,
  # mainly info Google knows about me.

  # The route to 'create' is the oauth2 callback we give Google
  def create
    @auth = request.env['omniauth.auth']['credentials']
    # The following statement saves the tokens to the database
    Token.create(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime
    )
    # Now we ask for the data
    redirect_to '/spreadsheet/getdata' && return
  end
end
