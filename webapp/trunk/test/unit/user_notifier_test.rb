require File.dirname(__FILE__) + '/../test_helper'
require 'user_notifier'

class UserNotifierTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
  end


  def test_place_holder
    UserNotifier.deliver_signup_notification(User.create(:email => 'deobald@gmail.com', :password => 'quire', :password_confirmation => 'quire'))
    assert true
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/user_notifier/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
