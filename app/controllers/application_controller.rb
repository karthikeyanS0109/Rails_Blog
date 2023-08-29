class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend
  # before_action :set_theme
  include CanCan::ControllerAdditions

 # private
 #
 #  def set_theme
 #    session[:theme] ||= 'light' # Default to light theme
 #    @current_theme = session[:theme]
 #  end
 #  def toggle_theme
 #    session[:theme] = (@current_theme == 'light') ? 'dark' : 'light'
 #    redirect_back fallback_location: root_path
 #  end

end
