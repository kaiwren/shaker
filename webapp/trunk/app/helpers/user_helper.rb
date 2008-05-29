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

  def guess_link_for_report(user_report)
    return 'this is you' if user_report.id == current_user.id
    return link_to('guess', "/users/#{user_report.id}/guesses/#{user_report.guess_id_for_current_user}/edit") if user_report.has_a_guess_from_current_user?
    link_to 'guess', "/users/#{user_report.id}/guesses/new"
  end

  def render_clickable_watch(target_user, listening_user)
    image_tag('email.png', :alt => "watch", :onclick => "watch_user(#{target_user.id}, #{listening_user.id});")
  end

  def render_clickable_unwatch(watcher)
    image_tag('email_delete.png', :alt => "un-watch", :onclick => "unwatch_user(#{watcher.id}, #{watcher.target_user.id});")
  end

  def user_count_text(user)
    count = user.count_of_watchers
    people_person = count == 1 ? 'person is' : 'people are'
    "(#{count} #{people_person} watching this user)"
  end

  private

  def currencify(amount)
    number_to_currency(amount, :precision => 0)
  end
end
