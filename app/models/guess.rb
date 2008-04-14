class Guess < ActiveRecord::Base
  belongs_to  :guessing_thoughtworker, :class_name => 'ThoughtWorker'
  belongs_to  :receiving_thoughtworker, :class_name => 'ThoughtWorker'
end
