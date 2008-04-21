require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  before(:each) do
    @twer_one = User.create(:login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire')
    @twer_two = User.create(:login => 'mire', :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire')
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
end