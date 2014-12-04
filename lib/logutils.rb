# encoding: utf-8

###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib lib/logutils.rb


# core and stlibs

require 'yaml'
require 'pp'
require 'fileutils'


# our own code

require 'logutils/version'    # NOTE: let version always go first
require 'logutils/logger'


module LogKernel

=begin   # not needed for now; keep it for later
  def self.config_path
    "#{root}/config"
  end
=end

end


module LogUtils

  ###################################
  # export public api from kernel


  ##############################
  #  use it like:
  #  logger = Logger[ self ]  or
  #  logger = Logger[ SportDb::Reader ] or
  #  logger = Logger[ 'SportDb::Reader' ] etc.

  Logger = LogKernel::Logger

  #####
  # use it like
  #
  #  class SampleClass
  #    include LogUtils::Logging
  #    ...
  #  end
  #
  #  or
  #
  #  include LogUtils
  #
  #  class SampleClass
  #    include Logging
  #    ...
  #  end
  #
  #  class AnotherSampleClass
  #    include Logging
  #    ...
  #    def sample_method
  #       logger.debug "calling sample_method"
  #    end
  #  end

  module Logging
    def logger
      @logger ||= LogKernel::Logger[ self ]
    end
  end

end  # module LogUtils


## say hello
puts LogKernel.banner   if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
