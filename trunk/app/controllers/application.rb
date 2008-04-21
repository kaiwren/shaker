# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #  protect_from_forgery # :secret => '4babfa345c55ce0180ffc0e9995d8a69'
  def current_user
    @current_user ||= User.find(session[:user])
  end
end
