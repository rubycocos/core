# logutils

Another Logger in Ruby

* [github.com/geraldb/logutils](https://github.com/geraldb/logutils)

## Usage

Logging levels:

DEBUG < INFO < WARN < ERROR < FATAL

use methods e.g.

    logger = LoggerUtils::Logger.new
    
    logger.debug "msg"
    logger.info "another msg"
    logger.warn "another msg"
    logger.error "another msg"
    logger.fatal "another msg"

To get a Logger use

    logger = LogUtils[ self ]

or

    logger = LogUtils[ 'SportDb::Reader' ]

### Log to the database using `LogDb`

NB: To use the `LogDb` machinery require the module, that is, issue:

    require 'logutils/db'

To create the database tables use:

    LogDb.create

To start logging to database (established connection required) use:

    LogDb.setup

To clean out all log records from the database use:

    LogDb.delete!

That's it.



## Alternatives

* [Ruby Toolbox Logging Category](https://www.ruby-toolbox.com/categories/Logging)
* [log4r]()
* [slf4r](https://www.ruby-toolbox.com/projects/slf4r)
* [yell]()
* [logging](https://rubygems.org/gems/logging)

## License

The `logutils` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.