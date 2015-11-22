######
# NB: use rackup to startup Sinatra service (see config.ru)
#
#  e.g. config.ru:
#   require './boot'
#   run LogDbAdmin::Server


# 3rd party libs/gems   - include/require in ./boot 
### require 'sinatra/base'


# NOTE: it's an addon for logutils
#  assume logutils and logutils/activerecord already required
# require 'logutils'
# require 'logutils/activerecord'


# our own code

require 'logutils/admin/version'   # Note: version always goes first



module LogDbAdmin


class Server < Sinatra::Base

  PUBLIC_FOLDER = "#{LogDbAdmin.root}/lib/logutils/server/public"
  VIEWS_FOLDER  = "#{LogDbAdmin.root}/lib/logutils/server/views"

  puts "[boot] logdb-admin - setting public folder to: #{PUBLIC_FOLDER}"
  puts "[boot] logdb-admin - setting views folder to: #{VIEWS_FOLDER}"

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
end #  module LogDbAdmin


# say hello
puts LogDbAdmin.banner

