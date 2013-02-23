# logutils

Another Logger in Ruby

* [github.com/geraldb/logutils](https://github.com/geraldb/logutils)

## Usage

Logging levels:

[ALL] < DEBUG < INFO < WARN < ERROR < FATAL < [OFF]


Start off getting a logger e.g.:

    logger = LogUtils::Logger.new

or

    include LogUtils
   
    logger = Logger.new

now you're ready to log using the methods `#debug`, `#info`, `#warn`, etc.

    logger.debug "msg"
    logger.info "another msg"
    logger.warn "another msg"
    logger.error "another msg"
    logger.fatal "another msg"


To get a Logger use

    logger = Logger[ self ]  # pass in object reference

or

    logger = Logger[ SportDb::Reader ]    # pass in class reference

or

    logger = Logger[ 'SportDb::Reader' ]  # pass in class name (as string)


### `Logging` Mixin

Note: In a class for convenience you can include the logging machinery
with a single line using the Logging mixin e.g.

    include LogUtils::Logging

This will add/mixin the logger attribute reader e.g.

    def logger
      @logger ||= Logger[ self ]
    end

plus the constants for all logging levels, that is, FATAL, ERROR, WARN, etc.

Example:

    class SampleClass
      include Logging
    
      def initialize
        logger.info 'hello SampleClass'
      end
    end


### Log to the database using `LogDb`

NB: To use the `LogDb` machinery require the module, that is, issue:

    require 'logutils/db'

To create the database tables use:

    LogDb.create

To start logging to the database (established connection required) use:

    LogDb.setup

To clean out all log records from the database use:

    LogDb.delete!


### All together now


    require 'logutils'
    
    include LogUtils    # lets you use Logger instead of LogUtils::Logger
    
    logger = Logger[ 'Test' ]
    logger.info 'hello LogUtils'
    
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


That's it.

## Todos

- [ ] Add UNKNOWN level - why? why not? check std logger



## Alternatives

* [Ruby Toolbox Logging Category](https://www.ruby-toolbox.com/categories/Logging)
* [log4r]()
* [slf4r](https://www.ruby-toolbox.com/projects/slf4r)
* [yell]()
* [logging](https://rubygems.org/gems/logging)

## License

The `logutils` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.