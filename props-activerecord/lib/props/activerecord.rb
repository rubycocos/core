# encoding: utf-8


## note: assumes props alreay required
##  this is an addon/plugin/extension for the props gems (that is, will NOT work stand-alone)

# rubygems / 3rd party libs
require 'active_record'   ## todo: add sqlite3? etc.

# our own code

require 'props/activerecord/version'   # version always goes first
require 'props/activerecord/schema'
require 'props/activerecord/models'



module ConfDb

  def self.create
    CreateDb.new.up
  end

  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting props table records/data...'
    Prop.delete_all
  end # method delete!

##  def self.stats   ## remove ? -- duplicate - use tables - why?? why not????
##    puts "#{Model::Prop} props"
##  end

  def self.tables
    puts "#{Prop.count} props"
  end

end # module ConfDb



puts ConfDb.banner   if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)  # say hello
