# iniparser - read / parse INI configuration, settings and data files into a hash (incl. named subsections)


* home  :: [github.com/datatxt/iniparser](https://github.com/datatxt/iniparser)
* bugs  :: [github.com/datatxt/iniparser/issues](https://github.com/datatxt/iniparser/issues)
* gem   :: [rubygems.org/gems/iniparser](https://rubygems.org/gems/iniparser)
* rdoc  :: [rubydoc.info/gems/iniparser](http://rubydoc.info/gems/iniparser)
* forum :: [groups.google.com/group/wwwmake](http://groups.google.com/group/wwwmake)



## Usage

`INI.load` • `INI.load_file`


Option 1) `INI.load` - load from string. Example:

``` ruby
hash = INI.load( <<TXT )
  title = Planet Open Data News

  [Open Street Map (OSM) News]
    feed = https://blog.openstreetmap.org/feed
TXT
```


Option 2) `INI.load_file` - load from file (shortcut). Example:

``` ruby
hash = INI.load_file( './planet.ini' )
```


All together now. Example:

``` ruby
require 'iniparser'

text = <<TXT
# comment
; another comment

key1 = hello
key2 = hi!

[section1]
key3 = salut    # end of line comment here

[section2]
key4  = hola    ; another end of line comment here
blank =
blank2

[section3 "http://example.com"]
# comment here
title  = A rose is a rose is a rose, eh?
; another comment here
title2 = A rose is a rose is a rose, eh?
TXT

hash = INI.load( text )
pp hash
```

resulting in:

``` ruby
{"key1"=>"hello",
 "key2"=>"hi!",
 "section1"=>{"key3"=>"salut"},
 "section2"=>{"key4"=>"hola", "blank"=>"", "blank2"=>""},
 "section3"=>{"http://example.com"=>{"title"=>"A rose is a rose is a rose, eh?",
                                     "title2"=>"A rose is a rose is a rose, eh?"}}}
```

to access use:

``` ruby
puts hash['key1']
#=> 'hello'
puts hash['key2']
#=> 'hi!'
puts hash['section1']['key3']
#=> 'salut'
puts hash['section2']['key4']
#=> 'hola'
puts hash['section2']['blank']
#=> ''
puts hash['section2']['blank2']
#=> ''      
puts hash['section3']['http://example.com']['title']
#=> 'A rose is a rose is a rose, eh?'
puts hash['section3']['http://example.com']['title2']
#=> 'A rose is a rose is a rose, eh?'
```



## Real World Example


**Git Config**

```
#
# This is the config file, and
# a '#' or ';' character indicates
# a comment
#

; core variables
[core]
  ; Don't trust file modes
  filemode = false

; Our diff algorithm
[diff]
  external = /usr/local/bin/diff-wrapper
  renames = true

; Proxy settings
[core]
  gitproxy=proxy-command for kernel.org
  gitproxy=default-proxy ; for all the rest

; HTTP
[http]
  sslVerify
[http "https://weak.example.com"]
  sslVerify = false
  cookieFile = /tmp/cookie.txt
```

resulting in
a format warning:

```
WARN: line 20 - duplicate key >gitproxy< in section; will overwrite existing value
```

and:

``` ruby
{"core"=>{"filemode"=>"false", "gitproxy"=>"default-proxy"},
 "diff"=>{"external"=>"/usr/local/bin/diff-wrapper", "renames"=>"true"},
 "http"=>
  {"sslVerify"=>"",
   "https://weak.example.com"=>
    {"sslVerify"=>"false", "cookieFile"=>"/tmp/cookie.txt"}}}
```

**"Classic" Windows INI Config**

```
; last modified 1 April 2001 by John Doe
[owner]
name=John Doe
organization=Acme Widgets Inc.

[database]
; use IP address in case network name resolution is not working
server=192.0.2.62
port=143
file=payroll.dat
```

resulting in:

``` ruby
{"owner"=>{"name"=>"John Doe", "organization"=>"Acme Widgets Inc."},
 "database"=>{"server"=>"192.0.2.62", "port"=>"143", "file"=>"payroll.dat"}}
```

**Planet Pluto Config**

```
title = Planet Ruby

[Ruby Lang News]
  feed = http://www.ruby-lang.org/en/feeds/news.rss

[Rails Girls Summer of Code News]
  feed = https://railsgirlssummerofcode.org/blog.xml


[Benoit Daloze]
  feed     = https://eregon.me/blog/feed.xml
  location = Zürich › Switzerland

[Thomas Leitner]
  feed     = https://gettalong.org/posts.atom
  location = Vienna • Wien › Austria

[Paweł Świątkowski]
  feed     = https://rubytuesday.katafrakt.me/feed.xml
  location = Kraków › Poland
```

resulting in:

``` ruby
{"title"=>"Planet Ruby",
 "Ruby Lang News"=>
  {"feed"=>"http://www.ruby-lang.org/en/feeds/news.rss"},
 "Rails Girls Summer of Code News"=>
  {"feed"=>"https://railsgirlssummerofcode.org/blog.xml"},
 "Benoit Daloze"=>
  {"feed"=>"https://eregon.me/blog/feed.xml",
   "location"=>"Z\u00FCrich \u203A Switzerland"},
 "Thomas Leitner"=>
  {"feed"=>"https://gettalong.org/posts.atom",
   "location"=>"Vienna \u2022 Wien \u203A Austria"},
 "Pawe\u0142 \u015Awi\u0105tkowski"=>
  {"feed"=>"https://rubytuesday.katafrakt.me/feed.xml",
   "location"=>"Krak\u00F3w \u203A Poland"}}
```

**Rosetta Stone - Read A Configuration File**

```
# This is a configuration file in standard configuration file format
#
# Lines beginning with a hash or a semicolon are ignored by the application
# program. Blank lines are also ignored by the application program.

# This is the fullname parameter
FULLNAME Foo Barber

# This is a favourite fruit
FAVOURITEFRUIT banana

# This is a boolean that should be set
NEEDSPEELING

# This boolean is commented out
; SEEDSREMOVED

# Configuration option names are not case sensitive, but configuration parameter
# data is case sensitive and may be preserved by the application program.

# An optional equals sign can be used to separate configuration parameter data
# from the option name. This is dropped by the parser. 

# A configuration option may take multiple parameters separated by commas.
# Leading and trailing whitespace around parameter names and parameter data fields
# are ignored by the application program.

OTHERFAMILY Rhu Barber, Harry Barber
```

resulting in:

``` ruby
{"FULLNAME"=>"Foo Barber",
 "FAVOURITEFRUIT"=>"banana",
 "NEEDSPEELING"=>"",
 "OTHERFAMILY"=>"Rhu Barber, Harry Barber"}
```



## Frequently Asked Questions (FAQ) and Answers

### Q: Why not use TOML (Tom's Obvious, Minimal Language)?

The IniParser returns a simple (nested) hash table and
all values are always strings, period 
(no auto-magic type inference or casting) and you MUST always 
use strings "unquoted" e.g.

    title = Planet Open Data News

instead of requiring "typed" quoted string values:

    title = "Planet Open Data News"

Yes, TOML is great for more "advanced" INI configurations / settings 
that require (strong) data types, 
nested lists, inline arrays, and much more. 


### Q: Why not use `IniFile` - the most popular library (10+ million downloads and counting)?

Again the IniParser returns a simple (nested) "standard" hash table and
all values are always strings, period 
(no auto-magic type inference or casting 
e.g. no conversion to bool (for true/false) 
or numbers (for 1,2, etc.). 
No wrapper around Hash or anything. Here be dragons ;-). 

The popular IniFile CANNOT handle properties without values. Example: 

```
[http]
  sslVerify
```

resulting in:

```
ERROR: Could not parse line: "  sslVerify" (IniFile::Error)
```

And parses "modern" named subsections into "flat" sections. Example:

```
[http]
  ; sslVerify
[http "https://weak.example.com"]
  sslVerify = false
  cookieFile = /tmp/cookie.txt

```

resulting in:

``` ruby
{"http"=>{},
 "http \"https://weak.example.com\""=>
  {"sslVerify"=>false, "cookieFile"=>"/tmp/cookie.txt"}}}
```

and NOT resulting in:

``` ruby
{"http"=>
  {"https://weak.example.com"=>
    {"sslVerify"=>false, "cookieFile"=>"/tmp/cookie.txt"}}}
```



### Q: What are some known IniParser format quirks?

No quoted values (e.g. `"Hello"`)
or escapes (e.g. `\#` `\n`) or quoted values with escapes (e.g. `"\n"`).

No multi-line support for values.

Inline end-of-line comments MUST start with at least one leading
space (e.g. `test.html#test` is NOT an inline end-of-line comment but `test.html #test` is).

Property key names must match the text pattern / regular expression `[a-zA-Z0-9_]([a-zA-Z0-9_-]*[a-zA-Z0-9_])?`,
that is, use `a-z` / `A-Z`, `0-9` or underscore (`_`) and dash (`-`) only inside
BUT no dot (`.`) for now.



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `iniparser` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Post them to the [wwwmake forum](http://groups.google.com/group/wwwmake). Thanks!
