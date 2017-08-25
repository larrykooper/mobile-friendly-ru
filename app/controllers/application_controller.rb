# ApplicationController is the base class for all the application's controllers.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
