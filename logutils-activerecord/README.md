# logutils-activerecord  - Another Logger - Addon for Database Support (LogDb, Log Model etc.)

* home :: [github.com/rubycoco/core](https://github.com/rubycoco/core)
* bugs :: [github.com/rubycoco/core/issues](https://github.com/rubycoco/core/issues)
* gem  :: [rubygems.org/gems/logutils-activerecord](https://rubygems.org/gems/logutils-activerecord)
* rdoc :: [rubydoc.info/gems/logutils-activerecord](http://rubydoc.info/gems/logutils-activerecord)


## Usage

### Log to the database using `LogDb`

NB: To use the `LogDb` machinery require the module, that is, issue:

    require 'logutils/activerecord'

To create the database tables use:

    LogDb.create

To start logging to the database (established connection required) use:

    LogDb.setup

To clean out all log records from the database use:

    LogDb.delete!


### All together now

    require 'logutils'
    require 'logutils/activerecord'   # NOTE: will also require 'active_record'

    include LogUtils    # lets you use Logger instead of LogUtils::Logger

    logger = Logger[ 'Test' ]
    logger.info 'hello LogUtils'

    LOG_DB_CONFIG = {
      adapter:   'sqlite3',
      database:  './log.db'
    }

    pp LOG_DB_CONFIG
    ActiveRecord::Base.establish_connection( LOG_DB_CONFIG )

    LogDb.create
    LogDb.setup

    logger.info 'hola LogUtils'
    logger.warn 'servus LogUtils'


That's it.


## License

The `logutils-activerecord` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

