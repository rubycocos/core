
module LogUtils
  
  module Level
    DEBUG = 'debug'
    INFO  = 'info'
    WARN  = 'warn'
    ERROR = 'error'
    FATAL = 'fatal'
  end


  class Event
    include Level

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


    def fatal?
      @level == FATAL
    end

    def error?
      @level == ERROR
    end

    def warn?
      @level == WARN
    end


    def to_s
      # "[#{level}-#{pid}.#{tid}] #{msg}"
      "[#{level}] #{msg}"
    end

  end # class Event


  class ConsoleListener
    def write( ev )
      if( ev.fatal? || ev.error? || ev.warn? )
        STDERR.puts ev.to_s
      else
        STDOUT.puts ev.to_s
      end
    end
  end  # class ConsoleListener
  
  STDLISTENER = ConsoleListener.new  # default/standard console listener


  class Logger
    include Level
    
    def initialize
      @listeners = []
      @listeners << STDLISTENER  # by default log to console
    end
    
    attr_reader :listeners
    
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
      @listeners.each { |l| l.write( ev ) }
    end
    
  end # class Logger
  
  STDLOGGER = Logger.new    # single instance - default/standard logger

end # module LogUtils
