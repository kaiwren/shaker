class Guess < ActiveRecord::Base
  belongs_to  :guessing_user, :class_name => 'User'
  belongs_to  :receiving_user, :class_name => 'User'
end
