class Guess < ActiveRecord::Base
  belongs_to  :guessing_user, :class_name => 'User'
  belongs_to  :receiving_user, :class_name => 'User'

  validates_presence_of :guessing_user
  validates_presence_of :receiving_user
end
