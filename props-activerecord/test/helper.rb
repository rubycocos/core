
## $:.unshift(File.dirname(__FILE__))

## minitest setup

require 'minitest/autorun'


# our own code
require 'props'
require 'props/activerecord'      # Note: explict require required for ConfDb (not automatic)


Prop  = ConfDb::Model::Prop



def setup_in_memory_db
  # Database Setup & Config

  db_config = {
    adapter:  'sqlite3',
    database: ':memory:'
  }

  pp db_config

  ActiveRecord::Base.logger = Logger.new( STDOUT )
  ## ActiveRecord::Base.colorize_logging = false  - no longer exists - check new api/config setting?

  ## NB: every connect will create a new empty in memory db
  ActiveRecord::Base.establish_connection( db_config )


  ## build schema
  ConfDb.create
end


setup_in_memory_db()
