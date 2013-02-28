
# 3rd party libs/gems

require 'sinatra/base'

# our own code

require 'logutils'
require 'logutils/db'



module LogDb::Web

  def self.banner
    ## add w/ Sinatra??
    "logdb-web #{LogKernel::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end
  
end #  module LogDb::Web


# say hello
puts LogDb::Web.banner

# require Sinatra App / Base
require 'logutils/web/app'
