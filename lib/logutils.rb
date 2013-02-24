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

require 'logutils/version'

require 'logutils/logger'


module LogKernel
=begin   # not needed for now; keep it for later

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

  def self.config_path
    "#{root}/config"
  end

=end
end


module LogUtils

  ###########
  # deprecated - remove old api!!!

  def self.[]( class_or_name )
    
    puts "depreceated API call LogUtils[] - use Logger[] / LogUtils::Logger[] instead"
    
    # for now always return single instance, that is, use standard/default logger for all
    LogKernel::STDLOGGER
  end

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
