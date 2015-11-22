# encoding: utf-8

module LogDbAdmin

  MAJOR = 0    ## todo: namespace inside version or something - why? why not??
  MINOR = 1
  PATCH = 0
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "logdb-admin/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) )}"
  end

end  # module LogDbAdmin
