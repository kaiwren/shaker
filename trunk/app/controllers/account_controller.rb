class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    if logged_in?
      redirect_to(:controller => 'users')
    else
      redirect_to(:action => 'login')
    end
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token, :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/users', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      flash[:error] = "Something was wrong with either your username, password, or both. If you just signed up, please check your email to activate your account."
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
#    self.current_user = @user
    UserNotifier.deliver_signup_notification(@user)
    redirect_back_or_default(:controller => '/account', :action => 'login')
    flash[:notice] = "Thanks for signing up! Please check your e-mail (#{@user.email}) for a link which will activate your Shaker account."
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end

  def activate
    @user = User.find_by_activation_code(params[:id]) if params[:id]
    if @user and @user.activate
      self.current_user = @user
      flash[:notice] = "Your account has been activated."
    else
      flash[:notice] = "It looks like you're trying to activate an account.  Perhaps have already activated this account?"
    end
    redirect_back_or_default(:controller => 'users', :action => 'index')
  end
end
