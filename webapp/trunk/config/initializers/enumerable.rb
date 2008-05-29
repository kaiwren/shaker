module Enumerable
  def fold_left
    copy = self.clone
    acc = copy.pop
    copy.each{|i|  acc = yield(i, acc)}
    acc
  end
end