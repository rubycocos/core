# logutils - Another Logger in Ruby


* home :: [github.com/rubylibs/logutils](https://github.com/rubylibs/logutils)
* bugs :: [github.com/rubylibs/logutils/issues](https://github.com/rubylibs/logutils)
* gem  :: [rubygems.org/gems/logutils](https://rubygems.org/gems/logutils)
* rdoc :: [rubydoc.info/gems/logutils](http://rubydoc.info/gems/logutils)


## Usage

Logging levels:

[ALL] < DEBUG < INFO < WARN < ERROR < FATAL < [OFF]


Start by getting a logger e.g.:

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


### Addons / Plugins / Extensions

[logutils-activerecord](https://github.com/rubylibs/logutils-activerecord) - add LogDb, Log Models, etc.



## Real World Usage

[world.db.ruby](https://github.com/worlddb/world.db.ruby) - `world.db` Command Line Tool

[sport.db.ruby](https://github.com/sportdb/sport.db.ruby) - `sport.db` Command Line Tool

[Sportbook](https://github.com/openbookie) - A free, open source sports betting pool
in Ruby on Rails (version 3.2 and up). 


## Todos

- [ ] Add TRACE level - why? why not? check std logger


## Alternatives

* [log4r](https://github.com/colbygk/log4r)  - Logging Library modeled after log4j in the Java world
* [slf4r](https://github.com/mkristian/slf4r) - Logging Library modeled after slf4j in the Java world
* [yell](https://github.com/rudionrails/yell)
* [logging](https://github.com/TwP/logging)
* [Ruby Toolbox Logging Category](https://www.ruby-toolbox.com/categories/Logging)


## License

The `logutils` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
