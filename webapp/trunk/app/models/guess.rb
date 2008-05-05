class Guess < ActiveRecord::Base
  belongs_to  :guessing_user, :class_name => 'User'
  belongs_to  :receiving_user, :class_name => 'User'

  validates_presence_of :guessing_user, :receiving_user
  validates_presence_of :suspected_amount, :if => lambda{|guess| guess.deserved_amount.nil? }
  validates_presence_of :deserved_amount, :if => lambda{|guess| guess.suspected_amount.nil? }

  validates_numericality_of :suspected_amount, :greater_than => -1, :unless => lambda{|guess| guess.suspected_amount.nil? }
  validates_numericality_of :deserved_amount, :greater_than => -1, :unless => lambda{|guess| guess.deserved_amount.nil? }

  validates_uniqueness_of  :receiving_user_id, :scope => :guessing_user_id
end
