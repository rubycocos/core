# encoding: utf-8

##
# NOTE: logutils addon (logutils assumed/required) will NOT work stand-alone

# rubygems / 3rd party libs

require 'active_record'   ## todo: add sqlite3? etc.


# our own code

require 'logutils/activerecord/version'   # NOTE: let version always go first
require 'logutils/activerecord/models'
require 'logutils/activerecord/schema'


module LogDb

  class DbHandler
    include Models

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
    Model::Log.delete_all
  end # method delete!


  def self.stats
    # to be done
  end



  STDDBHANDLER = DbHandler.new   # default/standard db handler

  def self.setup   # check: use different name?  e.g. configure or connect ?? why or why not?
    # turn on logging to db  - assumes active connection
    LogKernel::STDLOGGER.handlers << STDDBHANDLER
  end

end # module LogDb


# say hello
puts LogDb.banner  if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
