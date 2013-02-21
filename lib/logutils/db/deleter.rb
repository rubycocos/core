
module LogDb

  class Deleter
    include LogDb::Models

    def run
      # for now delete all tables
      
      Log.delete_all
    end
    
  end # class Deleter
  
end # module LogDb
