module ConfUtils

class Env

  def self.home
    path = if( ENV['HOME'] || ENV['USERPROFILE'] )
             ENV['HOME'] || ENV['USERPROFILE']
           elsif( ENV['HOMEDRIVE'] && ENV['HOMEPATH'] )
             "#{ENV['HOMEDRIVE']}#{ENV['HOMEPATH']}"
           else
             begin
                File.expand_path('~')
             rescue
                if File::ALT_SEPARATOR
                   'C:/'
                else
                   '/'
                end
             end
           end
     
    # todo: use logger - how?
    ## puts "env home=>#{path}<"
    
    path
  end


  def self.path    # returns array of paths (that is, path env gets split using PATH_SEPARATOR)
    parse_paths( ENV['PATH'] )
  end

  def self.parse_paths( paths )
    if paths
      paths.split( File::PATH_SEPARATOR ) # e.g. UNIX-style => :  or Windows-style => ;
    else
      []
    end
  end


end # class Env

end # module ConfUtils
