require File.dirname(__FILE__) + '/../spec_helper'

describe "A", ThoughtWorker do
  it "should respect his relationships" do
    twer_one = ThoughtWorker.new
    twer_two = ThoughtWorker.new
    g = Guess.create(:guessing_thoughtworker => twer_one, :receiving_thoughtworker => twer_two)

    twer_one.reload
    twer_two.reload

    twer_one.guesses.first.should == g
    twer_two.received_guesses.first.should == g
  end
end