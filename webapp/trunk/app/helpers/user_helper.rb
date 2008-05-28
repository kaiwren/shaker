module UserHelper

  def checked_real_text(user)
    return link_to("publish your salary!", 'user/edit') if ((not user.published?) and user.id == current_user.id)
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

  def render_clickable_watch(target_user, listening_user)
    image_tag('email.png', :alt => "watch", :onclick => "watch_user(#{target_user.id}, #{listening_user.id});")
  end

  def render_clickable_unwatch(guess_listener)
    image_tag('email_delete.png', :alt => "un-watch", :onclick => "unwatch_user(#{guess_listener.id}, #{guess_listener.target_user.id});")
  end

  private

  def currencify(amount)
    number_to_currency(amount, :precision => 0)
  end
end
