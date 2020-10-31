# encoding: utf-8

# core and stlibs

require 'yaml'
require 'pp'
require 'fileutils'
require 'erb'


# 3rd party
require 'iniparser'    # (auto-)include INI.load for now (was part of props - now its own gem)


# our own code

require 'props/version'   # version always goes first
require 'props/env'
require 'props/props'


######################
# add top_level convenience alias for classes

Env   = ConfUtils::Env
Props = ConfUtils::Props




puts ConfUtils.banner   if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)   # say hello
