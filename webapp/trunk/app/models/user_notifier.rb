class UserNotifier < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://YOURSITE/account/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end

  def watched_user_salary_visible(user, target_user)
    setup_email(user)
    @subject    += "#{target_user.name}'s salary is now visible!"
    @body[:url]  = "http://YOURSITE/"
    @body[:target_user]  = target_user
  end

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @bcc         = "shaker.thoughtworks@gmail.com"
    @from        = "spartan117.noreply@thoughtworks.com"
    @subject     = "[Shaker] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
