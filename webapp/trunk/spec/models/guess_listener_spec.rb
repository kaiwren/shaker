require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  it "should allow any user to register only once to watch any other user" do
    twer_one = User.create( :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire')
    twer_two = User.create( :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire')
    GuessListener.new(:target_user => twer_one, :listening_user  => twer_two).save.should be_true

    listener = GuessListener.new(:target_user => twer_one, :listening_user  => twer_two)
    listener.save.should be_false
    listener.should have(1).errors_on(:target_user_id)
  end
end
