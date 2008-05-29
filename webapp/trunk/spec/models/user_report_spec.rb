require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  before(:each) do
    @twer_one = User.create( :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire', :name => 'twer1', :real => 500)
    @twer_two = User.create( :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire', :name => 'twer2')
  end

  it "should ooga" do
    add_n_guesses_to(@twer_one, 3)
    @twer_one.save.should be_true

    results = UserReport.find_ooga @twer_two

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

    one.average_suspected_amount.should == User.find(:first).average_suspected_amount


  end

  it "should receive guess from current user" do
    @twer_one.received_guesses << Guess.new(:guessing_user => @twer_two, :receiving_user => @twer_one, :suspected_amount => 100)
    results = UserReport.find_ooga @twer_two
    results.should have(2).things

    one = results[0]
    two = results[1]

    one.guess_id_for_current_user.should == @twer_one.guess_from(@twer_two).id
    one.should be_has_a_guess_from_current_user
    two.should_not be_has_a_guess_from_current_user
  end

  it "should check if the retrieved user is watched by current user" do
    @twer_one.register_watcher(@twer_two)
    results = UserReport.find_ooga @twer_two
    results.should have(2).things

    one = results[0]
    two = results[1]

    one.should be_watched_by_current_user
    two.should_not be_watched_by_current_user

    one.count_of_watchers.should == 1
    two.count_of_watchers.should == 0
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