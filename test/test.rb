
puts "before require 'logutils'"
require 'logutils'

puts "LogUtils::VERSION #{LogUtils::VERSION}"

logger = LogUtils[ 'Test' ]
logger.info 'hello LogUtils'

puts "before require 'logutils/db'"
require 'logutils/db'


LOG_DB_PATH = './log.db'

LOG_DB_CONFIG = {
  :adapter   =>  'sqlite3',
  :database  =>  LOG_DB_PATH
}

require 'active_record'

pp LOG_DB_CONFIG
ActiveRecord::Base.establish_connection( LOG_DB_CONFIG )


LogDb.create

LogDb.setup

logger.info 'hola LogUtils'
logger.warn 'servus LogUtils'

