module UserBehaviour
  def published?
    not real.nil?
  end

  def checked_real
    real if received_guess_count >= User.showtime_guess_threshold
  end

  def showtime?
    not checked_real.nil?
  end

  def guesses_left_until_showtime
    User.showtime_guess_threshold - received_guess_count
  end
end