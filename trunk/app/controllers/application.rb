# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  helper_method :logged_in?

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #  protect_from_forgery # :secret => '4babfa345c55ce0180ffc0e9995d8a69'
  def current_user
    @current_user ||= User.find(session[:user])
  end

  def logged_in?
    not current_user.nil?
  end
end
