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

  def self.find_ooga
    sql = <<-EOL
SELECT u.*, (SELECT COUNT(*)
              FROM guesses g
              WHERE g.receiving_user_id = u.id) AS received_guess_count
FROM users u
EOL
    ActiveRecord::Base.connection.select_all(sql).collect{|result| UserReport.new(result)}
  end

  integers :id, :received_guess_count, :real, :average_suspected_amount
end
