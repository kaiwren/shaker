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

    File.open(file_name){|file|
      i = 0
      file.each_line{|l|
        i += 1
        row = l.split(',').collect(&:strip)
        log.debug("#{i}> Importing #{l}")
        ActiveRecord::Base.connection.insert("INSERT INTO users (id, name, email, office) VALUES (#{i}, \"#{row[0]}\", \"#{row[1]}\", \"#{row[2]}\")")
      }
    }
  end
end