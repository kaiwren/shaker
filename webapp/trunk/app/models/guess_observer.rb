class GuessObserver < ActiveRecord::Observer
  def after_save(guess)
    receiving_user = guess.receiving_user
    if receiving_user.notify_listeners?
      receiving_user.listeners.each{|listener|
        UserNotifier.deliver_watched_user_salary_visible(listener, receiving_user)
      }
    end
  end
end