#!/usr/bin/env ruby

require 'logutils'
require 'pp'

LOG = LogUtils::Logger['Test']
LOG.info "welcome to logutils #{LogKernel::VERSION}"

include LogUtils

