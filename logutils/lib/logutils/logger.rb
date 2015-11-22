# encoding: utf-8

module LogKernel
  
  #####
  # private "kernel" do NOT include everything into LogUtils
  #  only "export" public API in LogUtils
  
  
  #####
  # use like:
  #  LEVEL_NAME[ DEBUG ]  will return  'debug'
  #  LEVEL_NAME[ ERROR ]  will return  'error' etc.
  
  ### todo: reverse level integers ??? why? why not??
  # more logical  no output     = 0 (off)
  #               everything    = 6 (all)
  #               debug         = 5 etc.

  module Level
    ALL     = 0
    DEBUG   = 1
    INFO    = 2
    WARN    = 3
    ERROR   = 4
    FATAL   = 5
    UNKNOWN = 6    ## make unknown higher than off? why? why not?
    OFF     = 7
  end

  LEVEL_NAME =
    [
     'all',     # 0
     'debug',   # 1
     'info',    # 2
     'warn',    # 3
     'error',   # 4
     'fatal',   # 5
     'unknown', # 6
     'off'      # 7
    ]
  
  # map symbol to levelno; if not match map to UNKNOWN
  LEVEL_HASH = {
      all:     Level::ALL,
      debug:   Level::DEBUG,
      info:    Level::INFO,
      warn:    Level::WARN,
      error:   Level::ERROR,
      fatal:   Level::FATAL,
      off:     Level::OFF
    }


  class Event
    include Level   # lets you access Level::DEBUG with just DEBUG etc.

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
    
    attr_reader :levelno
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
    
    def unknown?
      @levelno == UNKNOWN
    end


    def to_s
      # "[#{level}-#{pid}.#{tid}] #{msg}"
      "[#{level}] #{msg}"
    end

  end # class Event


  class ConsoleHandler
    def write( ev )
      if( ev.fatal? || ev.error? || ev.warn? || ev.unknown? )
        STDERR.puts ev.to_s
      else
        STDOUT.puts ev.to_s
      end
    end
  end  # class ConsoleHandler
  
  STDHANDLER = ConsoleHandler.new  # default/standard log handler


  class Logger
    include Level

    def self.[]( class_or_name )
      STDLOGGER
    end
    
    def self.root
      STDLOGGER
    end
    
    def initialize
      @handlers = []
      @handlers << STDHANDLER   # by default log to console

      ## todo/check: pass levelno through to handlers?
      #   do we need a "global" levelno in the logger?
      @levelno = ALL
    end
    
    attr_reader :handlers
    
    
    #####
    # NB: use :debug, :info, :warn, :error, etc as argument
    #
    #  if invalid argument gets passed in, level gets set to UNKNOWN
    
    def level=( key )
      @levelno = LEVEL_HASH.fetch( key, UNKNOWN )
    end


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
    
    def unknown( msg )
      write( Event.new( UNKNOWN, msg ) )
    end

  private

    def write( ev )
      if ev.levelno >= @levelno
        @handlers.each { |l| l.write( ev ) }
      end
    end
    
  end # class Logger
  
  STDLOGGER = Logger.new    # single instance - default/standard logger

end # module LogKernel
