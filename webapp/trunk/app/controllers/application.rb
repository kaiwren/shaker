# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required
  helper :all # include all helpers, all the time
  helper_method :current_user
  helper_method :logged_in?

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
#  protect_from_forgery  :secret => '4babfa345c55ce0180ffc0e9995d8a69'
end
