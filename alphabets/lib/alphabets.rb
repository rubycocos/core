
## note - pp now part of ruby core since version ???
###           check no longer required!!!
require 'pp'


###
# our own code
require_relative 'alphabets/version' # let version always go first
require_relative 'alphabets/reader'
require_relative 'alphabets/alphabets'
require_relative 'alphabets/utils'
require_relative 'alphabets/variants'


##
##  add globals inside Kernel ??
##    lets us use alias_method 
##    what else?   why? why not?


## add "global" convenience helper
def downcase_i18n( name )
  Alphabet.downcase_i18n( name )
end

def unaccent( name )
  Alphabet.unaccent( name )   ## using "default" language character mapping / table
end

def undiacritic( name ) unaccent( name ); end    ## alias for unaccent



def variants( name )    ## todo/check: rename to unaccent_variants or unaccent_names - why? why not?
  Variant.find( name )
end


## add convenience aliases - also add Alpha - why? why not?
Abc       = Alphabet
Alphabets = Alphabet
Alpha     = Alphabet


puts Alphabet.banner   # say hello
