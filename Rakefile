require 'hoe'
require './lib/logutils/version.rb'


Hoe.spec 'logutils' do
  
  self.version = LogUtils::Kernel::VERSION
  
  self.summary = 'Another Logger'
  self.description = summary

  self.urls    = ['https://github.com/geraldb/logutils']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'opensport@googlegroups.com'
    
  # switch extension to .markdown for gihub formatting
  #  -- NB: auto-changed when included in manifest
  self.readme_file  = 'README.md'
  self.history_file = 'History.md'
  
  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }
  
end