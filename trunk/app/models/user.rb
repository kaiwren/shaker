require 'digest/sha1'
class User < ActiveRecord::Base
  has_many  :guesses, :foreign_key => :guessing_user_id
  has_many  :received_guesses, :foreign_key => :receiving_user_id, :class_name => 'Guess'

  include UserAuthShite

  def average_suspected_amount
    calculate_average{|guess| guess.suspected_amount }
  end

  def average_deserved_amount
    calculate_average{|guess| guess.deserved_amount}
  end

  def announced?
    not real.nil?
  end

  def checked_real
    real if received_guesses.count > 14
  end

  private
  def calculate_average(&field_strategy)
    return 0 if non_nil_received_guess_count(field_strategy) == 0
    sum = 0
    received_guesses.each{|guess| sum += field_strategy.call(guess).to_i}
    sum / non_nil_received_guess_count(field_strategy)
  end

  def non_nil_received_guess_count(field_strategy)
    received_guesses.reject{|guess| field_strategy.call(guess).nil? }.size
  end
end
