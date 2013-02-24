
#########################################
# NB: only load on demand
#  we do NOT want to pull in activerecord gem/dep for simple scripts

# rubygems / 3rd party libs

require 'active_record'   ## todo: add sqlite3? etc.

# our own code

require 'logutils/db/models'
require 'logutils/db/schema'
require 'logutils/db/deleter'


module LogDb

  include LogKernel   # NB: will also include VERSION constant e.g. LogDB::VERSION == LogUtils::Kernel::VERSION

  def self.banner
    "logdb #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

end

###########################################3
## fix: remove old alias for LogDb

LogDB = LogDb



###########################

module LogDb

  class DbHandler
    include LogDb::Models
    
    def write( ev )
      if( ev.fatal? || ev.error? || ev.warn? || ev.unknown? )
        ## create log entry in db table (logs)
        Log.create!( level: ev.level, msg: ev.msg, pid: ev.pid, tid: ev.tid, ts: ev.ts )
      end
    end # method write
  end  # class DbHandler

  def self.create
    CreateDb.up
  end

  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting log table records/data...'
    Deleter.new.run
  end # method delete!


  def self.stats
    # to be done
  end


  STDDBHANDLER = DbHandler.new   # default/standard db handler

  def self.setup   # check: use different name?  e.g. configure or connect ?? why or why not?
    # turn on logging to db  - assumes active connection
    STDLOGGER.handlers << STDDBHANDLER
  end


end # module LogDb


# say hello
puts LogDb.banner
