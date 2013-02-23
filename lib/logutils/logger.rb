
module LogUtils::Kernel
  
  ## private "kernel" - with include LogUtils - do NOT include everything
  
  
  #####
  # use like:
  #  LEVEL_NAME[ DEBUG ]  will return  'debug'
  #  LEVEL_NAME[ ERROR ]  will return  'error' etc.
  
  ### todo: reverse level integers ??? why? why not??
  # more logical  no output     = 0 (off)
  #               everything    = 6 (all)
  #               debug         = 5 etc.

  module Level
    ALL   = 0
    DEBUG = 1
    INFO  = 2
    WARN  = 3
    ERROR = 4
    FATAL = 5
    OFF   = 6
  end


  class Event
    include Level   # lets you access Level::DEBUG with just DEBUG etc.

    LEVEL_NAME =
    [
     'all',    # 0
     'debug',  # 1
     'info',   # 2
     'warn',   # 3
     'error',  # 4
     'fatal',  # 5
     'off'     # 6
    ]

    def initialize( levelno, msg )
      @levelno = levelno    # pass in integer e.g. 0,1,2,3,etc.
      @msg     = msg
      
      @pid   = Process.pid
      @tid   = Thread.current.object_id
      
      @ts    = Time.now
    end

    def level
      LEVEL_NAME[ @levelno ]
    end

    attr_reader :msg
    attr_reader :pid   # process_id
    attr_reader :tid   # thread_id
    attr_reader :ts    # timestamp


    def fatal?
      @levelno == FATAL
    end

    def error?
      @levelno == ERROR
    end

    def warn?
      @levelno == WARN
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

    def self.[]( class_or_name )
      STDLOGGER
    end

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
