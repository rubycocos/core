######
# NB: use rackup to startup Sinatra service (see config.ru)


module LogDb::Web

  PUBLIC_FOLDER = "#{LogKernel.root}/public"
  VIEWS_FOLDER  = "#{LogKernel.root}/lib/logutils/web/views"

  
class App < Sinatra::Base

  # set up static file routing
  set :static, true
  
  puts "setting public folder to: #{PUBLIC_FOLDER}"
  puts "setting views folder to: #{VIEWS_FOLDER}" 
  
  set :public_folder, PUBLIC_FOLDER   # set up the static dir (with images/js/css inside)   
  set :views,         VIEWS_FOLDER    # set up the views dir


  #####################
  # Models 

  Log  =  LogDb::Models::Log

##############################################
# Controllers / Routing / Request Handlers


get '/' do
  erb :index
end


end # class App

end  # module LogUtils::Web
