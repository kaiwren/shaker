module Enumerable
  def fold_left(init_val)
    acc = init_val
    self.each{|i|  acc = yield(i, acc)}
    acc
  end
end