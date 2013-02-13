
module LogUtils
  
  module Severity
    DEBUG = 'debug'
    INFO  = 'info'
    WARN  = 'warn'
    ERROR = 'error'
    FATAL = 'fatal'
  end
  
  
  class Logger
    include LogDB::Models
    include Severity
    
    def debug( msg )
      log( DEBUG, msg )
    end
    
    def info( msg )
      log( INFO, msg )
    end
    
    def warn( msg )
      log( WARN, msg )
    end
    
    def error( msg )
      log( ERROR, msg )
    end
    
    def fatal( msg )
      log( FATAL, msg )
    end

  private

    def log( kind, msg )
      puts "[#{kind}] #{msg}"
      
      if( [FATAL, ERROR, WARN].include?( kind ) )
        ## create log entry in db table (logs)
        Log.create!( kind: kind, msg: msg )
      end
    end
    
  end # class Logger
  
end # module LogUtils
