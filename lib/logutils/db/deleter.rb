
module LogDB

  class Deleter    
    include LogDB::Models

    def run( args=[] )
      # for now delete all tables
      
      Log.delete_all
    end
    
  end # class Deleter
  
end # module LogDB
