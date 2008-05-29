require 'digest/sha1'
class User < ActiveRecord::Base
  SHOWTIME_GUESS_THRESHOLD = 5

  has_many  :guesses, :foreign_key => :guessing_user_id
  has_many  :received_guesses, :foreign_key => :receiving_user_id, :class_name => 'Guess'
  has_many  :watchers, :foreign_key  => :target_user_id

  include UserAuthShite
  include UserBehaviour
  
  def average_suspected_amount
    calculate_average{|guess| guess.suspected_amount }
  end

  def average_deserved_amount
    calculate_average{|guess| guess.deserved_amount}
  end


  def received_guess_count
    received_guesses.count
  end

  def has_a_guess_from(user)
    guess_from(user) ? true : false
  end

  def guess_from(user)
    received_guesses.detect{|guess| guess.guessing_user == user }
  end

  def register_watcher(user)
    self.watchers << Watcher.new(:target_user => self, :listening_user => user)
    self.save
  end

  # listeners are users - the watcher is simply a join table
  def listeners
    self.watchers.collect(&:listening_user)  
  end

  def watching?(user)
    watcher_for(user) ? true : false
  end

  def watcher_for(target)
    Watcher.find_by_target_user_id_and_listening_user_id(target.id, self.id)
  end

  def count_of_watchers
    watchers.count    
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

  def self.showtime_guess_threshold
    SHOWTIME_GUESS_THRESHOLD
  end
end
