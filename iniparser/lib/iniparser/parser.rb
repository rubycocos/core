# encoding: utf-8



module IniParser

  # returns a nested hash
  #  (compatible structure - works like YAML.load_file)
  def self.load_file( path  )   Parser.load_file( path );  end
  def self.load( text )         Parser.load( text );       end


  class Error < StandardError
  end

  ## todo/check - what is JSON and YAML returning Parser/ParseError something else?
  ##  YAML uses ParseError  and JSON uses ParserError
  class ParseError < Error
  end


  class Parser

    # returns a nested hash
    #  (compatible structure - works like YAML.load_file)

    def self.load_file( path )
      text = File.open( path, 'r:bom|utf-8' ) {|f| f.read }
      load( text )
    end

    def self.load( text )
      new( text ).parse
    end


    def initialize( text )
      @text = text
    end


    COMMENT_CLASS = '[#;]'      # note: for now support # and ; - why? why not?

    SEP_CLASS     = '[= ]'       # note: name/value separator
                                 # - for now support = AND yes, space!!
                                 # (note: no longer support :) - why? why not?


    # note: for now do NOT support dot (.) - keep reserved for hierarchy latter
    # note: for now allow dash (-) only inside identifier (NOT beginning or end)
    # note: yes, allow just numbers as identifiers
    IDENT = '[a-zA-Z0-9_](?:[a-zA-Z0-9_-]*[a-zA-Z0-9_])?'
    STRICT_SECTION_RE = %r{^
                            \s*
                             \[
                                \s*
                                  (?<key>#{IDENT})
                                \s*
                                (?:"    ## allow optional subsection
                                   (?<sub>[^"]+)
                                   "
                                   \s*
                                )?
                             \]
                            \s*
                            $}x

    # note: yes, allow spaces inside (but only inside) section name
    # note: for now NO quotes ("") allowed
    SECTION_RE = %r{^
                     \s*
                      \[
                         \s*
                           (?<key>[^ "\]]
                                   (?:[^"\]]*[^ "\]])?
                           )
                          \s*
                      \]
                    \s*
                    $}x     # liberal section; allow everything in key


    PROP_RE = %r{^
                  \s*
                     (?<key>#{IDENT})
                   \s*
                    (?:#{SEP_CLASS}
                        \s*
                         (?<value>.*?)    ## note: use non-greedy (.*?) match
                        \s*
                    )?
                  $}x


    def parse
      hash = top_hash = {}

      text = @text
      text = text.gsub( "\t", ' ' )   # replace all tabs w/ spaces for now

      lineno = 0
      text.each_line do |line|
        lineno += 1    ## track line numbers for (parse) error reporting

        ### skip comments
        #  e.g.   # this is a comment line

        if line =~ /^\s*#{COMMENT_CLASS}/
          ## logger.debug 'skipping comment line'
          next
        end

        ### skip blank lines
        if line =~ /^\s*$/
          ## logger.debug 'skipping blank line'
          next
        end

        # pass 1) remove possible trailing eol comment
        ##  e.g    -> New York   # Sample EOL Comment Here (with or without commas,,,,)
        ##  e.g    -> New York   ; Sample EOL Comment Here (with or without commas,,,,)
        ## becomes -> New York
        ## NOTE: MUST have leading white space for now - keep - why? why not!!!!!
        ##   do any urls use # for fragments?

        line = line.sub( /\s+#{COMMENT_CLASS}.*$/, '' )

        # pass 2) remove leading and trailing whitespace

        line = line.strip

        if m=STRICT_SECTION_RE.match( line )  # strict section
          key  = m[ :key ]
          hash = top_hash[ key ] ||= {}

          sub_key = m[ :sub ]
          if sub_key   ## check for subsection
            hash = hash[ sub_key ] ||= {}
          end
        elsif m=SECTION_RE.match( line )     # liberal section; allow everything in key
          key =  m[ :key ]
          hash = top_hash[ key ] ||= {}
        elsif m=PROP_RE.match( line )
          key   = m[ :key ]
          value = m[ :value].to_s   # note: use to_s - might return nil
          ### todo:  strip quotes from value??? why? why not?
          ## todo/check - raise error on duplicate - why? why not?
          ##  for now just warn
          puts "WARN: line #{lineno} - duplicate key >#{key}< in section; will overwrite existing value"   if hash.key?( key )
          hash[ key ] = value
        else
          raise ParseError.new( "line #{lineno} - unknown line type; cannot parse >#{line}<" )
        end
      end # each lines

      top_hash
    end

  end # class Parser
end # module IniParser


####
# add a convenience shortcut
INI = IniParser

