require File.dirname(__FILE__) + '/../spec_helper'

describe Enumerable do
  it "should fold left example one" do
    array = [1, 2, 3, 4]
    array.fold_left(0){|a, b| a + b}.should == 10
    array.should == [1, 2, 3, 4]
  end

  it "should fold left example two" do
    array = [1, 2, 3, 4]
    array.fold_left(1){|a, b| a * b}.should == 24
    array.should == [1, 2, 3, 4]
  end
end
