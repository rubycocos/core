# core tools, libraries & scripts

Gems:

- [**bytes**](bytes) - bits 'n' bytes made easy/easier incl. new buffer helper / wrapper class to help with the string byte vs character dichotomy
- [**enums**](enums) - safe enum / enumeration types - a set of symbolic keys bound to unique integer numbers (incl. bit flags option)
- [**safebool**](safebool) - safe bool / boolean type adds `Bool()`, `to_b`, `parse_bool` / `to_bool`, `bool?`, `false?`, `true?`, `true.is_a?(Bool)==true`, `false.is_a?(Bool)==true`, and more


<!-- break -->


- [**logutils**](logutils)  - (lite) logger library
- [logutils-activerecord](logutils-activerecord) - addon for database support (e.g. LogDb, log model etc.)
- [logutils-admin](logutils-admin) - addon for browsing logs in database (e.g. LogDb, log model etc.)


<!-- break -->
- [**props**](props)  - manage settings hierarchies (commandline, user, home, defaults, etc.)
- [props-activerecord](props-activerecord) - addon for database support (ConfDb, props model, etc.)


<!-- break -->
- [iniparser](iniparser) - read / parse INI configuration, settings and data files into a hash (incl. named subsections)

<!-- break -->
- [alphabets](alphabets) - alphabet (a-z) helpers incl. unaccent, downcase, variants, and more
- [date-formats](date-formats) - read / parse and print dates (and times) from around the world
- [date-formatter](date-formatter) - date formatter by example; auto-builds the strftime format string from an example date


<!-- break -->
- [records](records) -  frozen / immutable structs with copy on updates
- [safedata](safedata) - safe (algebraic) union data types with (enumerated) variants



<!-- break -->
- [shell-lite](shell-lite) - run / execute shell commands




## If I Were ~~King~~ Matz (aka Yukihiro Matsumoto) - Ideas For Ruby 4.0   - What's Broken & Missing in Ruby 3.x and How To Fix It

After programming in ruby for more than 10+ years and [sharing / publishing 200+ gems](https://rubygems.org/profiles/geraldbauer)
and - yes, believe it or not - getting perma-banned ("cancel-cultured" ) for life twice (thanks to Richard Schneeman, Brandon Weaver, et al)
on r/reddit and ruby-talk - see the [public service announcement](https://old.reddit.com/r/planetruby/comments/swzz2h/public_service_announcement_this_reddit_here_is/) for some background  -
I (Gerald Bauer) will try to keep a log on how to make
ruby even more fun by collecting ideas  (mostly backed-up by "real-world" code & monkey patches) right here on this page.   Your questions and comments are more than welcome.


### Core Language & Types

About Strings

Did you know? In rubyland a string (like a character) started
as a series of bytes. In the old days a character was a byte (that is, an unsigned integer number in the range of 0-255).

Background Reading
-  [Programming Bits, Bytes 'n' Blocks Step-by-Step Book / Guide](bytes) -
   _Let's start with the three types of strings, that is, bytes, string buffers, and frozen strings, ..._


That all changed with wide-chars, unicode, & friends.
In 2024 does ruby need a (Binary) Buffer class?
Why? Why Not? Discuss.


Working with binary and hex(adecimal) strings in ruby

In 2024 the "classic" way
to convert a binary string to a hex(adecimal) string
and vice versa in ruby is like:

``` ruby
def hex_to_bin( hex )
    raise TypeError, "hex_to_bin - non-hexadecimal digit found in >#{hex}<" unless hex =~ /\A(?:0x)?[0-9a-f]*\z/i

    ## note: assume pack always returns string with BINARY/ASCII-8BIT encoding!!!
    if ['0x', '0X'].include?( hex[0,2] )   ## cut-of leading 0x or 0X if present
      [hex[2..-1]].pack('H*')
    else
      [hex].pack('H*')
    end
end

def bin_to_hex( bin )
  # note: unpack returns string with <Encoding:US-ASCII>
  # convert to default encoding
  hex = bin.unpack('H*').first
  hex.encode!( Encoding::UTF_8 )
  hex
end
```

The idea is to add new hex helpers to `String#hex` and `Kernel#hex`.

That let's you use convert hex strings to bin(ary) string via `Kernel#hex`
e.g.

``` ruby
bin = hex"00000000000000000000000000000000000000000000000000000000000004d2"
```

and vice versa via `String#hex`:

``` ruby
bin.hex
#=> "00000000000000000000000000000000000000000000000000000000000004d2"
```


Did you know? In rubyland `String#hex`  like `String#oct`
is already defined
and is an alias for `String#to_i(16)`  or `String#to_i(8)`.

``` ruby
"41".to_i(16)          #=> 65
"0x41".to_i(16)        #=> 65 - same as "41" - 0x hex prefix gets skipped
"41".hex          #=> 65
"0x41".hex        #=> 65 - same as "41" - 0x hex prefix gets
```

The idea for ruby 3.0 is to redefine `String#hex`  to return a hex string.
Another idea is to use a different name (and aliases)
such as `String#hexdump` or `String#hexdigest` and so on.
But somehow the matching symetry  of `String#hex` and `Kernel#hex`
and principle of least surprise gets lost.
Anyone ever used the old `String#hex`?  Let's find real-world code snippets / references.




#### The Missing Bool Class

Did you know? In rubyland there is no `Bool` class only `TrueClass` and `FalseClass`.

This can easily monkey-patched - why not make it official?
See the [safebool gem](safebool) for a start.

Background Reading:
-  [The State of Bool - Everything You Never Wanted to Know](https://github.com/geraldb/talks/blob/master/bool.md) @ Vienna Ruby Meetup, April 2019


#### The Missing Enum Class?

Did you know? In rubyland there is no `Enum` class.
The official party line is that
there's no class needed, just use symbols :-) or use constants. Example:

``` ruby
Color = [:red, :blue, :green]
Color[0]  #=> :red
Color[1]  #=> :blue

# -or-

Color = {red: 0, blue: 1, green: 2}
Color[:red]   #=> 0
Color[:blue]  #=> 1
Color.keys    #=> [:red, :blue, :green]
Color.values  #=> [0, 1, 2]

# -or-

module Color
  RED   = 0
  BLUE  = 1
  GREEN = 2
end
Color::RED       #=> 0
Color::BLUE      #=> 1
Color.constants  #=> [:RED, :BLUE, :GREEN]
# ...
```

Why? Why not? Discuss.


See the [enums gem](enums) for a start on a enum class.



#### The Missing Preludes / Quick Starters?

Are there any auto-include quick-starter prelude & prolog gems
out there in rubyland?


You could argue ruby is dead and rails is the "All your base are belong to us"
prelude & prolog quick-starter gem.

Why not make the concept of
auto-include quick-starter prelude & prolog gems
more popular and offer more options?


See the [cocos (code commons) gem](https://github.com/rubycocos/cocos) for a start on an (off-rails)
auto-include quick-starter prelude & prolog gem.




### Standard Gems / Libraries

#### (Open) Tabular Data Formats - A Better CSV Gem (Or Better) Gems

I have written a [seven part series on how the standard csv package
in rubyland is broken years ago](https://github.com/rubycocos/csvreader/tree/master/docs) (some issues got fixed thanks to [Sutou Kouhei](https://github.com/kou) - you are a hero)
but others are "unfixable" evergreens.

See the [csvreader gem series](https://github.com/rubycocos/csvreader) for a start.


Background Reading:
- [Mining for Gold Using the World's #1 and Most Popular Data Format (Spoiler: It's Comma-Separated Values (CSV))](https://github.com/geraldb/talks/blob/master/csv.md)


### Standard Project Scaffolders

Did you know?  In rubyland everyone rolls their own project scaffolder (bundler, hoe, rails, jekyll, etc.)  -  why not use a shared project scaffolder open to everyone?


See the [quik gem series](https://github.com/quikstart) for a start.


Background Reading:
- [The Missing Project Scaffolder for Ruby - Quick Start Your Ruby Gems, Your Sinatra Apps, Your Jekyll Sites 'n' More](https://github.com/geraldb/talks/blob/master/quik.md)



<!--
### Miscellaneous
-->


To be continued & updated...


Reminder:   Your questions and comments are more than welcome.





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

