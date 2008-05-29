require File.dirname(__FILE__) + '/../spec_helper'

describe Enumerable do
  it "should fold left" do
    array = [1, 2, 3, 4]
    array.fold_left{|a, b| a + b}.should == 10
    array.should == [1, 2, 3, 4]
  end
end
