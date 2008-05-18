module UserHelper

  def checked_real_text(user)
    return link_to("publish your salary!", 'user/edit') if ((not user.published?) and user == current_user)
    return currencify(user.checked_real) if user.showtime?
    return "#{user.guesses_left_until_showtime} guesses to go..." if user.published?
    return "unpublished"
  end

  def suspected_text(user)
    currencify(user.average_suspected_amount)
  end

  def guess_link_for(user)
    return 'this is you' if user == current_user
    return link_to('guess', edit_user_guess_path(user, user.guess_from(current_user))) if user.has_a_guess_from current_user
    link_to 'guess', new_user_guess_path(user)
  end

  private

  def currencify(amount)
    number_to_currency(amount, :precision => 0)
  end
end
