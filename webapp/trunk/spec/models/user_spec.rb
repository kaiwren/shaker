require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  before(:each) do
    @twer_one = User.create( :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire')
    @twer_two = User.create( :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire')
  end

  it "should respect his relationships" do

    @twer_one.should be_valid
    @twer_two.should be_valid

    g = Guess.new(:guessing_user => @twer_one, :receiving_user => @twer_two, :suspected_amount => 100)
    g.save.should be_true

    @twer_one.reload
    @twer_two.reload

    @twer_one.guesses.first.should == g
    @twer_two.received_guesses.first.should == g
  end

  it "should know how to average out suspected salaries" do
    @twer_one.received_guesses = (1..10).collect{|i|  Guess.new(:suspected_amount => i) }
    @twer_one.average_suspected_amount.should == 5
  end

  it "should know how to average out deserved salaries" do
    @twer_one.received_guesses = (1..10).collect{|i|  Guess.new(:deserved_amount => i) }
    @twer_one.average_deserved_amount.should == 5
  end

  it "average suspected shouldn't die with a divide by zero when there are no guesses" do
    @twer_two.average_suspected_amount.should == 0
  end

  it "average deserved shouldn't die with a divide by zero when there are no guesses" do
    @twer_two.average_deserved_amount.should == 0
  end

  it "should only be able to make one guess about another user's suspected salary" do
    Guess.create(:guessing_user => @twer_one, :receiving_user => @twer_two)
    Guess.new(:guessing_user => @twer_one, :receiving_user => @twer_two).save.should
  end

  it "should calculate average supected salary even if some guesses don't have it defined" do
     @twer_one.received_guesses = (1..10).collect{|i|  Guess.new(:suspected_amount => i) }
     @twer_one.received_guesses <<  Guess.new(:suspected_amount => nil)
     @twer_one.received_guesses <<  Guess.new(:suspected_amount => nil)
     @twer_one.received_guesses <<  Guess.new(:suspected_amount => nil)
     @twer_one.average_suspected_amount.should == 5
  end

  it "should not barf when calculating averages if there are no received guesses" do
    @twer_one.average_suspected_amount.should == 0
  end

  it "should not barf when calculating averages for a amount type if there are guesses with nil values for said amount" do
    @twer_one.received_guesses <<  Guess.new(:suspected_amount => nil)
    @twer_one.average_suspected_amount.should == 0
  end

  it "should know if a user has not published his real salary" do
    @twer_one.should_not be_published
  end

  it "should know if a user has published his real salary" do
    @twer_one.real = 123000
    @twer_one.should be_published
  end

  it "should not reveal the real salary when received guesses are fewer than 5" do
    @twer_one.real = 123000
    @twer_one.received_guesses.should have(0).things
    @twer_one.checked_real.should be_nil
  end

  it "should know it isn't showtime when received guesses are less than 5" do
    @twer_one.should_not be_showtime
  end

  it "should know how many guesses are left before showtime" do
    @twer_one.guesses_left_until_showtime.should == 5
    add_n_guesses_to(@twer_two, 5).guesses_left_until_showtime.should == 0
  end

  it "should know it's showtime when received guesses are greater than 4" do
    @twer_two.real = 123000
    @twer_two.checked_real.should be_nil
    add_n_guesses_to(@twer_two, 6)
    @twer_two.should be_showtime
  end

  it "should reveal all when received guesses are greater than 4" do
    @twer_two.real = 123000
    @twer_two.checked_real.should be_nil
    add_n_guesses_to(@twer_two, 6)
    @twer_two.save.should be_true
    @twer_two.checked_real.should == 123000
  end

  it "should know when another user has already guessed at her salary" do
    @twer_one.has_a_guess_from(@twer_two).should be_false
    @twer_one.received_guesses << Guess.new(:guessing_user => @twer_two, :receiving_user => @twer_one, :suspected_amount => 555)
    @twer_one.has_a_guess_from(@twer_two).should be_true
  end

  it "should know how to find a guess received from another user" do
    guess = Guess.create(:guessing_user => @twer_two, :receiving_user => @twer_one, :suspected_amount => 555)
    @twer_one.received_guesses << guess
    @twer_one.save.should be_true
    @twer_one.guess_from(@twer_two).should == guess
  end

  def add_n_guesses_to(target_user, n)
    name = 'a'
    for i in 1..n
      user = User.create(:email => "quire_#{name}@example.com", :password => 'quire', :password_confirmation => 'quire')
      target_user.received_guesses << Guess.new(:guessing_user => user, :receiving_user => @twer_two, :suspected_amount => 100 + i)
      name.next!
    end
    target_user
  end
end