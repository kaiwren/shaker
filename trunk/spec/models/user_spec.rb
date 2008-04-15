require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  before(:each) do
    @twer_one = User.create(:login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire')
    @twer_two = User.create(:login => 'mire', :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire')
  end

  it "should respect his relationships" do

    @twer_one.should be_valid
    @twer_two.should be_valid

    g = Guess.new(:guessing_user => @twer_one, :receiving_user => @twer_two)
    g.save.should be_true

    @twer_one.reload
    @twer_two.reload

    @twer_one.guesses.first.should == g
    @twer_two.received_guesses.first.should == g
  end

  it "should know how to average out suspected salaries" do
    (1..10).each{|i|
      Guess.new(:guessing_user => @twer_one, :receiving_user => @twer_two, :suspected_amount => i).save.should be_true
    }
    @twer_two.average_suspected_amount.should == 5
  end
end