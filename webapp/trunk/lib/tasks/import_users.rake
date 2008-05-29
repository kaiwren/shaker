namespace :shaker do
  task :import do
    require 'logger'
    require "#{RAILS_ROOT}/config/environment"

    @log = Logger.new(STDOUT)
    @log.level = Logger::DEBUG
    @log.datetime_format = "%H:%M:%S"
    def log;
      @log;
    end

    file_name = ARGV[1]

    log.info("User csv file name: #{file_name}")

    raise 'Insufficient information - missing users csv file name' unless file_name

    id = ActiveRecord::Base.connection.select_one('select max(id) as max_id from users')['max_id'].to_i
    record_number = 0;
    User.transaction do
      ActiveRecord::Base.connection.execute('update users set exited = true')
      File.open(file_name){|file|
        file.each_line{|l|
          id += 1
          record_number += 1
          
          row = l.split(',').collect(&:strip)
          log.debug("#{record_number}> Importing #{l}")
          existing_user = User.find_by_email(row[1])
          if existing_user.nil?
            ActiveRecord::Base.connection.insert("INSERT INTO users (id, name, email, office, exited) VALUES (#{id}, \"#{row[0]}\", \"#{row[1]}\", \"#{row[2]}\",  false)")
          else
            existing_user.name = row[0]
            existing_user.office = row[2]
            existing_user.exited = false
            existing_user.save_without_validation!
          end
        }
      }
    end
  end
end