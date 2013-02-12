
module LogUtils
  
  class Logger
    
    
    def debug( msg )
      log( 'debug', msg )
    end
    
    def info( msg )
      log( 'info', msg )
    end
    
    def warn( msg )
      log( 'warn', msg )
      log_db( 'warn', msg )
    end
    
    def error( msg )
      log( 'error', msg )
      log_db( 'error', msg )
    end
    
    def fatal( msg )
      log( 'fatal', msg )
      log_db( 'fatal', msg )
    end
    
    private
 
    def log_db( kind, msg )
    
    end
    
    def log( kind, msg )
      puts "[#{kind}], #{msg}"
    end
    
  end # class Logger
  
  
end # module LogUtils
