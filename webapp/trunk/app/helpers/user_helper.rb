module UserHelper

  def checked_real_text(user)
    return link_to("publish your salary!", edit_user_path(current_user)) if ((not user.published?) and user == current_user)
    return user.checked_real if user.showtime?
    return "#{user.guesses_left_until_showtime} guesses to go..." if user.published?
    return "unpublished"
  end

  def guess_link_for(user)
    return link_to('guess', edit_user_guess_path(user, user.guess_from(current_user))) if user.has_a_guess_from current_user
    link_to 'guess', new_user_guess_path(user)
  end
end