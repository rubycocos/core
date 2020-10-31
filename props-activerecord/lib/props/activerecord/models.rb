# encoding: utf-8

module ConfDb
  module Model


class Prop < ActiveRecord::Base

  ### todo/fix: move create_from_fixture! method to textutils ??? - why? why not?
  ## yes - move to textutils! - fixture concept/notion is part of textutils

  def self.create_from_fixture!( name, path )
    key   = "db.#{fixture_name_to_prop_key(name)}.version"
    
    value = "txt.#{File.mtime(path).strftime('%Y.%m.%d')}"
    
    Prop.create!( key: key, value: value )
  end

  ### todo:
  ## add latest scope -> order props by creation date desc!!!!
  
  ## add dump -> dump latest props to console via puts
  ## check - dump already taken by activerecord??

private

  # helper
  #   change at/2012_13/bl           to at.2012/13.bl
  #    or    quali_2012_13_europe_c  to quali.2012/13.europe.c
  
  def self.fixture_name_to_prop_key( name )
    prop_key = name.gsub( '/', '.' )
    prop_key = prop_key.gsub( /(\d{4})_(\d{2})/, '\1/\2' )  # 2012_13 => 2012/13
    prop_key = prop_key.gsub( '_', '.' )
    prop_key
  end

end # class Prop

  end # module Model

  ##### add convenience module alias in plural e.g. lets you use include ConfDb::Models
  Models = Model
  ##### add convenience class alias e.g lets you use Prop instead of Model::Prop 
  Prop   = Model::Prop

end # module ConfDb
