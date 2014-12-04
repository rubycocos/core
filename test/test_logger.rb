###
#  to run use
#     ruby -I ./lib -I ./test test/test_logger.rb
#  or better
#     rake test

require 'helper'

class TestLogger < MiniTest::Test
  include LogUtils        # lets us use Logger instead of LogUtils::Logger

  ####
  # just for testing testing machinery
  #  simple tests

  def test_root
    l1 = Logger[ self ]
    l2 = Logger[ 'Test' ]
    l3 = Logger[ TestLogger ]
    
    ### nb: for now all return LogUtils::Kernel::STDLOGGER
    
    assert(l1 == LogKernel::STDLOGGER )
    assert(l2 == LogKernel::STDLOGGER )
    assert(l3 == LogKernel::STDLOGGER )
  end
  
  class SampleClass
    include LogUtils  # NB: constant from containing class not available (only if class is nested in module)
    include Logging
  end
  
  class Sample2Class
    include LogUtils::Logging
  end
  
  def test_class
     obj  = SampleClass.new
     obj2 = Sample2Class.new
     
     assert( obj.logger == LogKernel::STDLOGGER )
     assert( obj2.logger == LogKernel::STDLOGGER )
  end
  
end