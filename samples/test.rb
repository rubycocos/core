

require 'logutils'

puts "LogUtils::Kernel::VERSION #{LogUtils::Kernel::VERSION}"

logger = LogUtils[ 'Test' ]   ## old api remove
logger.info 'hello LogUtils'

logger2 = LogUtils::Logger[ 'Test' ]
logger2.info 'hello LogUtils 2'

include LogUtils

logger3 = Logger[ 'Test' ]
logger3.info 'hello LogUtils 3'

class SampleClass
  include Logging

  def initialize
    logger.info 'hello SampleClass'
  end
end

SampleClass.new


#####################################
# check db logging machinery

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

