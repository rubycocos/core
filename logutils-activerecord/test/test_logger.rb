###
#  to run use
#     ruby -I ./lib -I ./test test/test_logger.rb
#  or better
#     rake test

require 'helper'


class TestLogger < MiniTest::Test
  include LogUtils        # lets us use Logger instead of LogUtils::Logger


  def test_setup

    # connect to in-memory db
    ## ActiveRecord::Base.logger = Logger.new( STDOUT )
    ActiveRecord::Base.establish_connection( adapter:  'sqlite3',
                                             database: ':memory:' )

    LogDb.create
    LogDb.setup

    l1 = Logger[ self ]
    l2 = Logger[ 'Test' ]
    l3 = Logger[ TestLogger ]

    ### note: for now all return LogUtils::Kernel::STDLOGGER
    assert l1 == LogKernel::STDLOGGER
    assert l2 == LogKernel::STDLOGGER
    assert l3 == LogKernel::STDLOGGER 

    l1.info( 'info msg from l1')
    l1.warn( 'warn msg from li')
    
    l1.info( "log count: #{LogDb::Model::Log.count}" )

    assert true
  end

end # class TestLogger
