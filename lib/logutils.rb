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


# rubygems / 3rd party libs

require 'active_record'   ## todo: add sqlite3? etc.


# our own code

require 'logutils/version'

require 'logutils/db/models'
require 'logutils/db/schema'
require 'logutils/db/deleter'

require 'logutils/logger'


module LogUtils

end  # module LogUtils


module LogDB

  def self.banner
    "logdb #{LogUtils::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

  def self.config_path
    "#{root}/config"
  end

  def self.create
    CreateDB.up
  end

  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting log table records/data...'
    Deleter.new.run
  end # method delete!


  def self.stats
    # to be done
  end


end # module LogDB

## say hello
puts LogDB.banner
