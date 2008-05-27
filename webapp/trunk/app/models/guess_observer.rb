class GuessObserver < ActiveRecord::Observer
  def after_save(guess)
    "Send Email to #{guess.target_user.listeners}"
  end
end