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


module LogUtils

=begin   # not needed for now; keep it for later

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

  def self.config_path
    "#{root}/config"
  end

=end

  ###########
  # deprecated - remove old api!!!
  #  use it like:
  #  logger = LogUtils[ self ]  or
  #  logger = LogUtils[ 'SportDb::Reader' ] etc.

  def self.[]( class_or_name )
    
    puts "depreceated API call LogUtils[] - use Logger[] / LogUtils::Logger[] instead"
    
    # for now always return single instance, that is, use standard/default logger for all
    LogUtils::Kernel::STDLOGGER
  end

  ###################################
  # export public api from kernel

  Logger = LogUtils::Kernel::Logger
  include LogUtils::Kernel::Level



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
    include LogUtils::Kernel::Level

    def logger
      @logger ||= LogUtils::Kernel::Logger[ self ]
    end
  end

end  # module LogUtils

