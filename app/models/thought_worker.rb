class ThoughtWorker < ActiveRecord::Base
  has_many  :guesses, :foreign_key => :guessing_thoughtworker_id
  has_many  :received_guesses, :foreign_key => :receiving_thoughtworker_id, :class_name => 'Guess'
end
