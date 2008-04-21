require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  it "should have a guesser and a recepient" do
    g = Guess.new
    g.should_not be_valid
    g.should have(1).errors_on(:guessing_user)
    g.should have(1).errors_on(:receiving_user)
  end

  it "should be invalid if it doesn't have at least one of the two amounts" do
    g = Guess.new(:guessing_user => User.new, :receiving_user => User.new)
    g.should_not be_valid
    g.should have(1).errors_on(:suspected_amount)
    g.should have(1).errors_on(:deserved_amount)
  end

  it "should ensure that suspected amount is a number" do
    Guess.new(:suspected_amount => 100).should  have(0).errors_on(:suspected_amount)
    Guess.new(:suspected_amount => 'bac').should  have(1).errors_on(:suspected_amount)
  end

  it "should ensure that deserverd amount is a number" do
    Guess.new(:deserved_amount => 100).should  have(0).errors_on(:deserved_amount)
    Guess.new(:deserved_amount => 'bac').should  have(1).errors_on(:deserved_amount)
  end

  it "should have be valid if it has a guesser, a recepient and valid suspected amount" do
    Guess.new(:guessing_user => User.new, :receiving_user => User.new, :suspected_amount => 100).should be_valid
  end

  it "should have be valid if it has a guesser, a recepient and valid deserved amount" do
    Guess.new(:guessing_user => User.new, :receiving_user => User.new, :deserved_amount => 100).should be_valid
  end

  it "should have be valid if it has a guesser, a recepient and valid both amounts" do
    Guess.new(:guessing_user => User.new, :receiving_user => User.new, :suspected_amount => 100, :deserved_amount => 100).should be_valid
  end

  it "should have a positive value for amounts" do
    Guess.new(:suspected_amount => -33).should  have(1).errors_on(:suspected_amount)
    Guess.new(:deserved_amount => -33).should  have(1).errors_on(:deserved_amount)
  end

  it "should be unique for a given pair of users" do
    twer_one = User.new(:login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire')
    twer_two = User.new(:login => 'mire', :email => 'mire@example.com', :password => 'muire', :password_confirmation => 'muire')

    twer_one.save.should be_true
    twer_two.save.should be_true

    Guess.new(:guessing_user => twer_one, :receiving_user => twer_two, :suspected_amount => 100, :deserved_amount => 100).save.should be_true

    duplicate = Guess.new(:guessing_user => twer_one, :receiving_user => twer_two, :suspected_amount => 100, :deserved_amount => 100)
    duplicate.should_not be_valid
    duplicate.should have(1).error_on(:receiving_user_id)
  end
end
