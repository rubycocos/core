# encoding: utf-8

###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib lib/logutils.rb


# core and stlibs

require 'yaml'
require 'pp'
require 'logger'
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
  # use it like:
  #  logger = LogUtils[ self ]  or
  #  logger = LogUtils[ 'SportDb::Reader' ] etc.

  def self.[]( class_or_name )
    # for now always return single instance, that is, use standard/default logger for all
    STDLOGGER
  end

end  # module LogUtils
