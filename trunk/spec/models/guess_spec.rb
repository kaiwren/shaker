require File.dirname(__FILE__) + '/../spec_helper'

describe "A", User do
  it "should have a guesser and a recepient" do
    g = Guess.new
    g.should_not be_valid
    g.should have(1).errors_on(:guessing_user)
    g.should have(1).errors_on(:receiving_user)
  end
end