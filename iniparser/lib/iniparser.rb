# encoding: utf-8


require 'pp'

# our own code
require 'iniparser/version'   # note: let version always go first
require 'iniparser/parser'



# say hello
puts IniParser.banner    if defined?( $RUBYLIBS_DEBUG )
