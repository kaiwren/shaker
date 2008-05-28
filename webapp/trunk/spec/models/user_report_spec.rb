require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  before(:each) do
    @twer_one = User.create( :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire', :name => 'twer1', :real => 500)
    @twer_two = User.create( :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire', :name => 'twer2')
  end

  it "should ooga" do
    add_n_guesses_to(@twer_one, 3)
    @twer_one.save.should be_true

    results = UserReport.find_ooga

    results.should have(5).things

    one = results[0]
    two = results[1]

    one.id.should == @twer_one.id
    two.id.should == @twer_two.id

    one.name.should == @twer_one.name
    one.real == @twer_one.real

    one.received_guess_count.should == 3
    one.should be_published
    two.should_not be_published
    User.stub!(:showtime_guess_threshold).and_return(3)
    one.checked_real.should == 500

    one.should be_showtime
    two.should_not be_showtime

    one.guesses_left_until_showtime.should == 0
    two.guesses_left_until_showtime.should == 3

#    one.average_suspected_amount.should == User.find(:first)
    

  end

  def add_n_guesses_to(target_user, n)
    name = 'a'
    for i in 1..n
      user = User.create(:email => "quire_#{name}@example.com", :password => 'quire', :password_confirmation => 'quire')
      target_user.received_guesses << Guess.new(:guessing_user => user, :receiving_user => target_user, :suspected_amount => 100 + i)
      name.next!
    end
    target_user
  end
end