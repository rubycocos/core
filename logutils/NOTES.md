# Dev Notes


## Rails Logger Notes

### Using in Rails

Add a config/logging.rb e.g.

    require 'logutils'
    
    Rails.logger = LogUtils::Logger.root


### The Logger

Rails used to use Ruby's standard logging class, but it now uses
[ActiveSupport::BufferedLogger](http://api.rubyonrails.org/classes/ActiveSupport/BufferedLogger.html).

    Constants:
      DEBUG    = 0
      INFO     = 1
      WARN     = 2
      ERROR    = 3
      FATAL    = 4
      UNKNOWN  = 5


You can specify an alternative logger in your environment.rb or any environment file:

    Rails.logger = Logger.new(STDOUT)
    Rails.logger = Log4r::Logger.new("Application Log")

Or in the Initializer section, add any of the following

    config.logger = Logger.new(STDOUT)
    config.logger = Log4r::Logger.new("Application Log")

Source: [Debugging Rails Apps - The Logger](http://guides.rubyonrails.org/debugging_rails_applications.html#the-logger)

#### Log Levels

When something is logged it's printed into the corresponding log if the log level of the message
is equal or higher than the configured log level.
If you want to know the current log level you can call the Rails.logger.level method.

The available log levels are: :debug, :info, :warn, :error, and :fatal,
corresponding to the log level numbers from 0 up to 4 respectively. To change the default log level, use

    config.log_level = :warn # In any environment initializer, or
    Rails.logger.level = 0 # at any time

NB: The default Rails log level is info in production mode
and debug in development and test mode.

#### Logging

To write in the current log use the logger.(debug|info|warn|error|fatal) method
from within a controller, model or mailer:

    logger.debug "Person attributes hash: #{@person.attributes.inspect}"
    logger.info "Processing the request..."
    logger.fatal "Terminating application, raised unrecoverable error!!!"


## More Notes

## todo add name, level

    LogUtils[ name ] or
    LogUtils.logger( name )  e.g. LogUtils[ self ]

add logger to logger repo

## todo support

    logger.debug?
    logger.warn?
    etc.
    
## todo support blocks for conditional evaluation

    logger.debug { ruby code here }


### How to get process id (pid)?

* Yell uses   Process.pid
* Logging ???
* Log4r

### How to get thread id (tid)?

* Yell uses   Thread.current.object_id
* Logging ???
* Log4r ???

### How to get timestamp (ts)?

* Yell uses   Time.now

### How to get filename, line, method?

use caller ?


### Notes on logging levels/serverity

todo/check: use int constants or strings? 

There are two things you should know about log levels/severity:
- syslog defines levels from 0 (Emergency) to 7 (Debug).
      0 (Emergency) and 1 (Alert) levels are reserved for OS kernel.
- Ruby default Logger defines levels from 0 (DEBUG) to 4 (FATAL) and 5 (UNKNOWN).
      Note that order is inverted.
   For compatibility we define our constants as Ruby Logger, and convert values before
   generating GELF message, using defined mapping.

  module Levels
    DEBUG   = 0
    INFO    = 1
    WARN    = 2
    ERROR   = 3
    FATAL   = 4
    UNKNOWN = 5
  end

  include Levels

  Maps Ruby Logger levels to syslog levels as SyslogLogger and syslogger gems. This one is default.
  LOGGER_MAPPING = {DEBUG   => 7, # Debug
                    INFO    => 6, # Info
                    WARN    => 5, # Notice
                    ERROR   => 4, # Warning
                    FATAL   => 3, # Error
                    UNKNOWN => 1} # Alert  shouldn't be used

  Maps Ruby Logger levels to syslog levels as is.
  DIRECT_MAPPING = {DEBUG   => 7, # Debug
                    INFO    => 6, # Info
                    # skip 5 Notice
                    WARN    => 4, # Warning
                    ERROR   => 3, # Error
                    FATAL   => 2, # Critical
                    UNKNOWN => 1} # Alert  shouldn't be used
end