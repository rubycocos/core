######
# NB: use rackup to startup Sinatra service (see config.ru)
#
#  e.g. config.ru:
#   require './boot'
#   run LogDb::Server


# 3rd party libs/gems

require 'sinatra/base'

# our own code

require 'logutils'
require 'logutils/db'



module LogDb

class Server < Sinatra::Base

  def self.banner
    "logdb-server #{LogKernel::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

  PUBLIC_FOLDER = "#{LogKernel.root}/lib/logutils/server/public"
  VIEWS_FOLDER  = "#{LogKernel.root}/lib/logutils/server/views"

  puts "setting public folder to: #{PUBLIC_FOLDER}"
  puts "setting views folder to: #{VIEWS_FOLDER}"
  
  set :public_folder, PUBLIC_FOLDER   # set up the static dir (with images/js/css inside)   
  set :views,         VIEWS_FOLDER    # set up the views dir

  set :static, true   # set up static file routing


  #####################
  # Models

  include LogDb::Models

  ##############################################
  # Controllers / Routing / Request Handlers

  get '/' do
    erb :index
  end

end # class Server
end #  module LogDb


# say hello
puts LogDb::Server.banner
