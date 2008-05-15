require 'digest/sha1'
class User < ActiveRecord::Base
  SHOWTIME_GUESS_THRESHOLD = 5

  has_many  :guesses, :foreign_key => :guessing_user_id
  has_many  :received_guesses, :foreign_key => :receiving_user_id, :class_name => 'Guess'

  include UserAuthShite

  def average_suspected_amount
    calculate_average{|guess| guess.suspected_amount }
  end

  def average_deserved_amount
    calculate_average{|guess| guess.deserved_amount}
  end

  def published?
    not real.nil?
  end

  def showtime?
    not checked_real.nil?
  end

  def checked_real
    real if received_guesses.count >= SHOWTIME_GUESS_THRESHOLD
  end

  def guesses_left_until_showtime
    SHOWTIME_GUESS_THRESHOLD - received_guesses.count
  end

  def has_a_guess_from(user)
    guess_from(user) ? true : false
  end

  def guess_from(user)
    received_guesses.detect{|guess| guess.guessing_user == user }
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
