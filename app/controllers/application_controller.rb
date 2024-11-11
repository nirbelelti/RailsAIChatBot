class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :set_current_user

  # def set_current_user
  #  current = current_user if user_signed_in?
  # end
end
