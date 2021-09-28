# encoding: utf-8

require 'pp'

## our own code
require 'safebool/version'    # note: let version always go first


module Bool

  TRUE_VALUES =  ['true', 'yes', 'on', 't', 'y', '1']
  FALSE_VALUES = ['false', 'no', 'off', 'f', 'n', '0']

  def self.parse( o )
    if o.is_a? String
      str = o
    else  ## try "coerce" to string
      str = o.to_str
    end

    case str.downcase.strip
    when *TRUE_VALUES
      true
    when *FALSE_VALUES
      false
    else
      nil   ## note: returns nil if cannot convert to true or false
    end
  end


  def self.convert( o )   ## used by "global" Bool( o ) kernel conversion method
    if o.respond_to?( :parse_bool )
      value = o.parse_bool()  # note: returns true/false OR nil
      if value.nil?
        raise ArgumentError.new( "invalid value >#{o.inspect}< of type >#{o.class.name}< for Bool(); method parse_bool failed (returns nil)")
      end
      value
    else
      raise TypeError.new( "can't convert >#{o.inspect}< of type >#{o.class.name}< to Bool; method parse_bool expected / missing")
    end
  end

  def self.zero() false; end


  def to_b()       self; end
  def parse_bool() self; end
end # module Bool



class FalseClass
  include Bool     ## "hack" - enables false.is_a?(Bool)

  def zero?() true; end
  def to_i()  0; end

  ## note: include Bool does NOT include module function (e.g. self.zero, etc.)
  ##   todo/check/discuss - also include self.parse - why? why not?
  def self.zero() false; end     ## lets you write:  false.class.zero
end

class TrueClass
  include Bool    ## "hack" - enables true.is_a?(Bool)

  def zero?() false; end
  def to_i()  1; end

  ## note: include Bool does NOT include module function (e.g. self.zero, etc.)
  def self.zero() false; end   ## lets you write:  true.class.zero
end






module Kernel

  ######
  ## Returns true if object class is TrueClass or FalseClass, otherwise false.
  ##
  ## true.bool?   #=> true
  ## false.bool?  #=> true
  ## nil.bool?    #=> false
  def bool?() self.class == TrueClass || self.class == FalseClass; end  ## todo/discuss: use "shortcut" self == true || self == false - why? why not?

  #########
  ## Returns true if object class is FalseClass, otherwise false.
  ##
  ## false.false?  #=> true
  ## true.false?   #=> false
  ## nil.false?    #=> false
  def false?() self.class == FalseClass; end  ## todo/discuss: use "shortcut" self == false - why? why not?

  ############
  ## Returns true if object class is TrueClass, otherwise false.
  ##
  ## true.true?   #=> true
  ## false.true?  #=> false
  ## nil.true?    #=> false
  def true?() self.class == TrueClass; end    ## todo/discuss: use "shortcut" self == true - why? why not?


  #####
  #  default "explicit" conversion to bool for all objects
  def to_b
    if respond_to?( :parse_bool )
      value = parse_bool()         # note: returns true/false/nil  (nil for error/cannot parse)
      value = true  if value.nil?  #         default nil (cannot parse to bool) to true
      value
    else
      self ? true : false    ## use "standard" ruby semantics, that is, everything is true except false & nil
    end
  end


  # to_bool - "porcelain" method "alias" for parse_bool; use parse_bool for "internal" use and to_bool for "external" use
  # note: by "default" the method parse_bool is undefined (!);
  #         define parse_bool in concrete / derived class to add bool conversion support
  def to_bool()
    if respond_to?( :parse_bool )
      parse_bool()
    else
      nil   ## note: returns nil if can't convert to true or false
    end
  end

  ### "global" conversion function / method
  def Bool( o ) Bool.convert( o ); end
end



class NilClass
  def to_b()       false; end
  def parse_bool() false; end
end

class String
  def to_b
    if strip.empty?   ## add special case for empty / blank strings - return false (!)
      value = false
    else
      value = parse_bool()
      value = true  if value.nil?   ## note: return true  for all undefined / unknown string values that cannot convert to bool (except empty string)
      value
    end
  end
  def parse_bool() Bool.parse( self ); end
end

class Symbol
  def to_b()       to_s.to_b; end
  def parse_bool() to_s.parse_bool(); end
end

class Integer
  def to_b
    value = parse_bool()
    value = true  if value.nil?   ## note return true for all undefined / unknown number/numeric values that cannot convert to bool
    value
  end
  def parse_bool
    if self == 0
      false
    elsif self == 1
      true
    else
      nil  ## note: returns nil if can't convert to true or false
    end
  end
end



puts SaferBool.banner    ## say hello
