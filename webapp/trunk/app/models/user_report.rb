require 'ostruct'
class UserReport < OpenStruct
  include UserBehaviour

  def self.integers(*fields)
    fields.each{|field|
      self.class_eval {
        define_method(field){
          @table[field].to_i if @table[field]
        }
      }
    }
  end

  def self.find_ooga current_user
    sql = <<-EOL
SELECT u.*, (SELECT COUNT(*)
              FROM guesses g
              WHERE g.receiving_user_id = u.id) AS received_guess_count,
            (SELECT AVG(suspected_amount)
              FROM guesses g
              WHERE g.receiving_user_id = u.id) AS average_suspected_amount,
            (SELECT COUNT(*)
              FROM guesses g
              WHERE g.receiving_user_id = u.id and g.guessing_user_id = #{current_user.id}) AS guess_count_from_user,
            (SELECT COUNT(*)
              FROM watchers w
              WHERE w.target_user_id = u.id and w.listening_user_id = #{current_user.id}) AS watches_from_user
FROM users u
EOL
    ActiveRecord::Base.connection.select_all(sql).collect{|result| UserReport.new(result)}
  end

  integers :id, :received_guess_count, :real, :average_suspected_amount, :average_suspected_amount, :guess_count_from_user, :watches_from_user

  def has_a_guess_from_current_user?
    guess_count_from_user.to_i > 0
  end

  def watched_by_current_user?
    watches_from_user.to_i > 0
  end
end
