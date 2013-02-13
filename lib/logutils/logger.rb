
module LogUtils
  
  module Level
    DEBUG = 'debug'
    INFO  = 'info'
    WARN  = 'warn'
    ERROR = 'error'
    FATAL = 'fatal'
  end
  
  class Event
    def initialize( level, msg )
      @level = level
      @msg   = msg
      
      @pid   = Process.pid
      @tid   = Thread.current.object_id
      
      @ts    = Time.now
    end

    attr_reader :level
    attr_reader :msg
    attr_reader :pid   # process_id
    attr_reader :tid   # thread_id
    attr_reader :ts    # timestamp


    def to_s()
      "[#{level}-#{pid}.#{tid}] #{msg}"
    end

  end # class Event
  
  
  class Logger
    include LogDB::Models
    include Level
    
    def debug( msg )
      write( Event.new( DEBUG, msg ) )
    end
    
    def info( msg )
      write( Event.new( INFO, msg ) )
    end
    
    def warn( msg )
      write( Event.new( WARN, msg ) )
    end
    
    def error( msg )
      write( Event.new( ERROR, msg ) )
    end
    
    def fatal( msg )
      write( Event.new( FATAL, msg ) )
    end

  private

    def write( ev )
      puts ev.to_s
      
      if( [FATAL, ERROR, WARN].include?( ev.level ) )
        ## create log entry in db table (logs)
        Log.create!( level: ev.level, msg: ev.msg, pid: ev.pid, tid: ev.tid, ts: ev.ts )
      end
    end
    
  end # class Logger
  
end # module LogUtils
