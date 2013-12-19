class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include Authentication

  before_action :confirm_signed_in

  helper_method :current_user, :signed_in?

end
