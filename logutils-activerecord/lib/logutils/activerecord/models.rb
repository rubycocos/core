# encoding: utf-8

module LogDb
  module Model

class Log < ActiveRecord::Base

end # class Log

  end # module Model

##### add convenience module alias in plural e.g. lets you use include LogDb::Models
Models = Model

end # module LogDb

